function recodemo(h_fig);
% RECODEMO      Demonstration of different effects while reconstruction
% 
% It is possible to navigate through the different screens using the
% buttons below the plots.
%
% See also SMPLSLIDE, DEMO1, DEMO2

% (c) of, 2003 Dec 03
% Last Update: 2005 Mar 09

% Check Matlab release: Figure handles changed since 2014!
strVersion = version('-release');

if ~exist('h_fig','var'),
  h_fig = figure;               % open new figure,
end
set(gcf,'KeyPressFcn','processkey(gcf)');  % set handling for keyboard and

if str2double(strVersion(1:4)) < 2014; %use figure handle acc. to release version
    recoslide(h_fig,1);             % start with the first slide
else
    recoslide(h_fig.Number,1);      % start with the first slide
end

scrsize = get(0,'ScreenSize');  % get screensize
winpos = [scrsize(1) scrsize(2)+31 scrsize(3) scrsize(4)-31-37];
set(h_fig,'Position',winpos);   % set the figure size to full screen
adjbutpos(h_fig);               % adjust the button positions

return

