function demo3(h_fig,no)
% RECODEMO RECOnstruction demonstration
%
% syntax: recodemo(h_fig,no)
%
% Show slide number no of the reconstruction demonstration in figure h_fig.

% (c) of, 2003 Dec 16
% Last Update: 2005 Feb 02
% Timestamp: <recodemo.m Wed 2005/02/02 16:15:15 OF@OFPC>

figure(h_fig);

% General settings for all slides
srate = 8000;
freq  = 800;
tb    = 0;
te    = 2/freq;
fb    = -srate*2.5;
fe    = srate*2.5;
t     = tb:1/srate:te-1/srate;
sig   = 2*sin(2*pi*freq*t);
spec  = fftshift(abs(fft(sig)))/length(sig);
spec  = [spec spec spec spec spec];
step  = srate/length(sig);
f     = fb:step:fe-step;

% The 'analogue' signal:
srateA = 96000;
tA     = tb:1/srateA:te-1/srateA;
sigA   = 2*sin(2*pi*freq*tA - 2*pi/20);

% just for plotting purposes
t      = t*1000;        % time in ms
tA     = tA*1000;
f      = f/1000;        % time in kHz
tb     = min(t);
te     = max(t);
fb     = min(f);
fe     = max(f);
txtY_t = 3.4;
xl_t   = [tb-(te-tb)*0.05 te+(te-tb)*0.05];
yl_t   = [-2.1 3.8];
txtY_f = 1.4;
xl_f   = [fb-(fe-fb)*0.05 fe+(fe-fb)*0.05];
yl_f   = [0 1.5];

spec(find(spec<1E-14)) = 0.0;   % get rid of numerical errors

% individual slides
switch no,
case 1,
  clf
  subplot(211);                 % Time domain
  stem(t,sig,'filled');
  xlabel('Time in ms');
  str2 = sprintf('Assume we have a sampled sinusoid (f=%s Hz, f_s=%s kHz).', ...
                 num2str(freq),num2str(srate/1000));
  h_txt(1) = text(tb,txtY_t,{'What happens during the reconstruction process?', ...
                             str2});
  xlim(xl_t);
  ylim(yl_t);
  subplot(212);                 % Frequency domain
  stem(f,spec,'filled');
  xlabel('Frequency in kHz');
  h_txt(2) = text(fb,txtY_f,{'Due to the sampling we have a periodic replication of', ...
                             'the original spectrum at intervals of the sampling rate.'});
  xlim(xl_f);
  ylim(yl_f);
case 2,
  clf
  subplot(211)
  stem(t,sig,'b');
  hold on
  % simulate the staircase reconstructor (using fs=50*srate [=96 kHz]):
  sig = repmat(sig,50,1);
  sig = sig(:);
  t = (0:length(sig)-1)/(50*srate/1000) + tb;
  plot(t,sig,'r-');
  hold off
  xlabel('Time in ms');
  h_txt(1) = text(tb,txtY_t,{'A typical D/A converter uses some kind of sample-and-hold', ...
                            'reconstruction, resulting in a staircase function.'});
  xlim(xl_t);
  ylim(yl_t);
  %
  subplot(212);                 % Frequency domain
  stem(f,spec,'b');
  hold on
  fact = abs(sinc(f*1000/srate));
  plot(f,fact,'r');
  stem(f,spec.*fact,'r','filled');
  hold off
  xlabel('Frequency in kHz');
  h_txt(2) = text(fb,txtY_f,{'However, this type of reconstruction does not completely', ...
                             'eliminate the replicated images in the spectrum.'});
  xlim(xl_f);
  ylim(yl_f);
case 3,
  clf
  subplot(211)
  % simulate the staircase reconstructor (using fs=50*srate [=96 kHz]):
  sig = repmat(sig,50,1);
  sig = sig(:);
  t = (0:length(sig)-1)/(50*srate/1000) + tb;
  plot(t,sig,'r-',tA,sigA,'b-');
  xlabel('Time in ms');
  h_txt(1) = text(tb,txtY_t,{'The ''surviving'' spectral replicas may be removed by an' ...
                             'additional lowpass postfilter with cutoff frequency f_s/2'});
  xlim(xl_t);
  ylim(yl_t);
  %
  subplot(212);                 % Frequency domain
  fact = abs(sinc(f*1000/srate));
  stem(f,spec.*fact,'r');
  hold on
  fc = srate/2/1000;            % cutoff frequency of the lowpass postfilter in kHz
  line([-fc -fc fc fc],[0 max(spec)*[1.025 1.025] 0],'LineStyle','--','Color','b');
  spec = fact.*spec;
  fact = zeros(size(spec));
  fact(find(abs(f)<=fc)) = 1;
  stem(f,spec.*fact,'b--','filled');
  hold off
  xlabel('Frequency in kHz');
  h_txt(2) = text(fb,txtY_f,{'Hear the difference between the staircase reconstructor', ...
                             'with and without an additional lowpass postfilter!'});
  xlim(xl_f);
  ylim(yl_f);
  % the buttons
  set([h_txt(2), gca],'Units','pixels');
  pos_txt = get(h_txt(2),'Extent');
  pos_ax  = get(gca,'Position');
  set(h_txt(2),'Units','data');
  set(gca,  'Units','normalized');
  CBS_rect = strcat(mfilename,'(',int2str(h_fig),',''s1'');');
  CBS_orig = strcat(mfilename,'(',int2str(h_fig),',''s2'');');
  h_rect = uicontrol(h_fig,'Style','PushButton','CallBack',CBS_rect, ...
                     'String','w/o postfilter','ForegroundColor','r');
  h_orig = uicontrol(h_fig,'Style','PushButton','CallBack',CBS_orig, ...
                     'String','w/ postfilter','ForegroundColor','b');
  pos_rect = get(h_rect,'Position');
  pos_orig = get(h_orig,'Position');
  pos_rect = [pos_txt(1)+pos_ax(1) pos_txt(2)+pos_ax(2)-pos_txt(4)*1.5 ...
              pos_rect(3)*1.6      pos_rect(4)];
  pos_orig = [pos_txt(1)+pos_ax(1) pos_rect(2)-pos_rect(4)*1.2 ...
              pos_orig(3)*1.6      pos_orig(4)];
  set(h_rect,'Position',pos_rect);
  set(h_orig,'Position',pos_orig);
case 's1',
  % just for playback purposes
  tmp = repmat(sig,12,1);
  tmp = tmp(:);
  tmp = repmat(tmp,512,1);
  sound(tmp/2,12*srate);
case 's2',
  % just for playback purposes
  tmp = repmat(sigA',512,1);
  sound(tmp/2,srateA);
end

if isnumeric(no),
  set(h_txt,'VerticalAlignment','cap','FontSize',14);
end
