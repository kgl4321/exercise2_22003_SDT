function DFTdemo1(h_fig)
% DFTdemo       Demonstration of the discrete Fourier transform
% 
% Function to demonstrate the discrete Fourier transformation within MATLAB.
% Several subplots are used to show the signal and its fourier transform. It
% is possible to navigate through the different screens using the buttons
% below the plots.
%
% See also FTDEMO, RECTDEMO, DELTDEMO, GAUSDEMO, SICODEMO, WINDEMO, ZPDEMO,
%          SWPDEMO.

% based on TAG2.M from Feb 99, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2005 Mar 09

% Check Matlab release: Figure handles changed since 2014!
strVersion = version('-release');

if ~exist('h_fig','var'),
  h_fig = figure;               % open new figure,
end
set(gcf,'KeyPressFcn','processkey(gcf)');  % set handling for keyboard and

if str2double(strVersion(1:4)) < 2014; %use figure handle acc. to release version
    DFTslide1(h_fig,1);              % start with the first slide
else
    DFTslide1(h_fig.Number,1);              % start with the first slide
end

scrsize = get(0,'ScreenSize');  % get screensize
winpos = [scrsize(1) scrsize(2)+31 scrsize(3) scrsize(4)-31-37];
set(h_fig,'Position',winpos);   % set the figure size to full screen
adjbutpos(h_fig);               % adjust the button positions
return
