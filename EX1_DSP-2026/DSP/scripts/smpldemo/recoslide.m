function recoslide(h_fig,no)
%RECOSLIDE      show a specific slide of the demonstration of reconstruction effects
%
% syntax:  recolide(h_fig,no)
%
% Show slide number no in figure number h_fig.
%
% See also RECODEMO, DEMO3

% (c) of 2003 Dec 02
% Last Update: 2003 Dec 17
% Timestamp: <smplslide.m Wed 2003/12/17 15:40:29 OF@OFPC>

switch no,              % which slide to show?
case 1,
    demo3(h_fig,1); 
case 2,
    demo3(h_fig,2); 
case 3,
    demo3(h_fig,3); 
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
case 3,
  set(h_prev,'Enable','on','Callback',CBS_prev);
  set(h_next,'Enable','off','Callback','');
otherwise,
  set(h_prev,'Enable','on','Callback',CBS_prev);
  set(h_next,'Enable','on','Callback',CBS_next);
end

set(h_fig,'Name',['Sample demo -- slide ',int2str(no)]); % add figure name
set(h_fig,'ResizeFcn','adjbutpos(gcf)');                % set resize function
zoom on

return
