function [vFreq, vBMLD, vStd] = plBMLD(vp, group, flag)
% plBMLD        plots data from BMLD experiment
%
% usage: [vFreq, vBMLD, vStd] = plBMLD(vp, group, flag)
%
% input: vp     subjects (e.g.: 'an', {'an','bo'})
%        group  group name (e.g. 'group1')
%        flag   'raw' plot raw data (before calculated the BMLD)
%               'mean' plot mean BMLD data
% output:
%        vFreq  Frequency axis
%        vBMLD  mean BMLD in dB (N0S0 - N0Spi)
%        vStd   Standard deviation of vBMLD
%
% see also: afc_main, get_data

% Author     : Oliver Fobel (of@oersted.dtu.dk)
% Created    : 2004 Mar 12
% Last Update: 2007 Mar 16 by Eric Thompson
% Timestamp  : <plBMLD.m Tue 2007/03/16 10:10:01 ET@ETPC>

% Some testing
if nargin < 2,
  help(mfilename)
  return
end

if ~iscell(vp),
  vp = {vp};
end

if ~iscell(group),
  group = {group};
end

if ~exist('flag','var') || isempty(flag),
  flag = 'mean';
end

bMean = ~isempty(findstr(flag,'mean'));
bRaw = ~isempty(findstr(flag,'raw'));

% some settings for the plot
colors = [0.2 0.7 0.2;0 0 1; 1 0 0;0 0 0;0.7 0.2 0.2; 1 1 0; 1 0 1];
lines =  {'-','--','-.',':'};
symbols = {'s','^','v','d','>','<','x','p'};
fsize = 16;
msize = 12;
lwidth = 2;

% initializing:
xmin = [];
xmax = [];
expname = 'BMLD';

iCol = 1;                              % we just want to use one color
actCol = colors((mod(iCol-1,length(colors))+1),:);
if ~ishold,                            % was the figure hold before calling this function?
  bWasHold = 0;                        % no:
  clf;                                 % clear the figure
  set(gca,'FontSize',fsize,'Box','on','LineWidth',lwidth);  % set properties of the axis
  hold on;                             % hold on figure to add subjects
else                                   % yes:
  bWasHold = 1;                        % remember status!
end

for i_vp = 1:length(vp),
  actVp = vp{i_vp};                    % each subject
  actSym = symbols{mod(i_vp-1,length(symbols))+1}; % has its own symbol
  for i_grp = 1:length(group),
    actGrp = group{i_grp};             % each group
    actLin = lines{mod(i_grp-1,length(lines))+1};  % has its own linestyle
    dat = get_results(expname,actVp,actGrp);  % read in data to TOO
    tmp = toouq(dat,'exppar2[degree]');  % find unique phases
    vPh = toogetc(tmp,'exppar2[degree]',1);  % copy them to a vector
    vPh = sort(vPh);                   % and sort it (0°, 180°)
    for i1 = 1:length(vPh),            % for each phase angle do
      vi_ri = toogetri(dat,'exppar2[degree]',vPh(i1));  % get row indices with this phase
      tmp = tooselec(dat,vi_ri);       % get this subset in a new TOO
      tmp = toouq(tmp,'exppar1[Hz]');  % find unique frequencies
      vFr{i1} = toogetc(tmp,'exppar1[Hz]',1);  % copy them to a vector
      vFr{i1} = sort(vFr{i1})';        % and sort it
      for i2 = 1:length(vFr{i1}),      % for each frequency do
        vAndFlt = {{'exppar1[Hz]',vFr{i1}(i2),} ...  % define the AND-filter
                   {'exppar2[degree]',vPh(i1)}};
        tmp = tooand(dat,vAndFlt);     % get all elements matching the filter
        vals = toogetc(tmp,'expvar[dB]',1);  % get all values
        if isempty(vals),              % work around a bug in AFC
          vals = toogetc(tmp,'expvar[n/a]',1);  % get all values
        end
        vLvl{i1}(i2) = mean(vals);     % calculate the mean value
        vStd{i1}(i2) = std(vals);      % and the standard deviation
      end
    end
    [vFreq{i_vp}, ind1, ind2] = intersect(vFr{1},vFr{2});  % which frequencies are available for both phases?
    vBMLD{i_vp} = vLvl{1}(ind1)-vLvl{2}(ind2);  % calculate the BMLD
    vStd{i_vp}  = sqrt(vStd{1}(ind1).^2 + vStd{2}(ind2).^2);  % variances will add up
    if bRaw,
      hpl = plot(log(vFr{1}),vLvl{1},actSym,'Markersize',msize,...
                 'LineWidth',lwidth,'Color',actCol,'MarkerFaceColor','w');
      hpl = plot(log(vFr{2}),vLvl{2},actSym,'Markersize',msize,...
                 'LineWidth',lwidth,'Color',actCol,'MarkerFaceColor',actCol);
      xmin = min([xmin; vFr{1}; vFr{2}]);  % minimum x-value
      xmax = max([xmax; vFr{1}; vFr{2}]);  % maximum x-value
      ylabel('Signal/Noise Ratio [dB]')
    end
    if bMean,
      hpl = errorbar(log(vFreq{i_vp}),vBMLD{i_vp},vStd{i_vp});  % plot the mean BMLD
      set(hpl,'linestyle',actLin,'marker',actSym, ...
          'MarkerFaceColor','w','markersize',msize);
      set(hpl,'Color',actCol,'linewidth',lwidth);
      xmin = min([xmin vFreq{i_vp}]);  % minimum x-value
      xmax = max([xmax vFreq{i_vp}]);  % maximum x-value
        ylabel('BMLD [dB]');                  % set ylabel
    end
  end
end

xlim(log([min(xmin)/1.4 max(xmax)*1.4]));        % set xlimits
ticks = union(vFr{1},vFr{2});          % find all used frequencies
set(gca,'XTick',log(ticks));           % and set XTicks accordingly
set(gca,'XTickLabel',ticks);           % and XTickLabels
xlabel('Signal Frequency [Hz]');             % set xlabel
title('BMLD (N_0S_0 - N_0S_\pi)');     % set title
ch = get(gca,'Children');              % get axis children
h_open = findobj(ch,'flat','MarkerFaceColor',[1 1 1]);  % find curves with open symbols
h_leg = legend(h_open,vp);              % add legend
set(h_leg,'LineWidth',lwidth);         % set properties of the handle
if ~bWasHold,                          % was figure hold before calling this function?
  hold off;                            % no: so hold off
end
if length(vp) == 1,
  vBMLD = vBMLD{1};
  vStd  = vStd{1};
  vFreq = vFreq{1};
end

