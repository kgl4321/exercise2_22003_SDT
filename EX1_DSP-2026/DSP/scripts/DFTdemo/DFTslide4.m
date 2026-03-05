function DFTslide4(h_fig,no)
%DFTSLIDE       show a specific slide of the DFT demonstration
%
% syntax:  DFTslide(h_fig,no)
%
% Show slide number no in figure number h_fig.
%
% see also DFTDEMO

% (c) of 2003 Dec 02
% Last Update: 2003 Dec 03

switch no,              % which slide to show?
case 1,
    swpdemo(h_fig,1);   % First slide of the sweep demonstration
case 2,
    swpdemo(h_fig,2);   % Second slide of the sweep demonstration
case 3,
    swpdemo(h_fig,3);   % Third slide of the sweep demonstration
case 4,
    swpdemo(h_fig,4);   % Fourth slide of the sweep demonstration
case 5,
    swpdemo(h_fig,5);   % Fifth slide of the sweep demonstration
case 6
    swpdemo(h_fig,6);   % Sixth slide of the sweep demonstration (!!! requires LTFAT)
otherwise,
  error(['Slide number ', int2str(no), ' does not exist!']);
end

% get handles of the buttons
h_prev = findobj(h_fig,'Style','PushButton','String','Previous');
h_next = findobj(h_fig,'Style','PushButton','String','Next');

if isempty(h_prev),             % if button does not exist add it
h_prev = uicontrol(h_fig,'Style','PushButton','String','Previous');
end
if isempty(h_next),             % if button does not exist add it
  h_next = uicontrol(h_fig,'Style','PushButton','String','Next');
end
adjbutpos(h_fig);               % adjust the button positions

% Create the CallBack strings
CBS_prev = strcat(mfilename,'(',int2str(h_fig),',',int2str(no-1),');');
CBS_next = strcat(mfilename,'(',int2str(h_fig),',',int2str(no+1),');');

switch no,
case 1,
  set(h_prev,'Enable','off','Callback','');
  set(h_next,'Enable','on','Callback',CBS_next);
case 6,
  set(h_prev,'Enable','on','Callback',CBS_prev);
  set(h_next,'Enable','off','Callback','');
otherwise,
  set(h_prev,'Enable','on','Callback',CBS_prev);
  set(h_next,'Enable','on','Callback',CBS_next);
end

set(h_fig,'Name',['DFTdemo -- slide ' int2str(no)]);    % add figure name
set(h_fig,'ResizeFcn','adjbutpos(gcf)');                % set resize function
zoom on

return
