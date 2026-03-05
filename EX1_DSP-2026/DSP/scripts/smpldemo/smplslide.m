function smplslide(h_fig,no)
%SMPLSLIDE      show a specific slide of the demonstration of sampling effects
%
% syntax:  smplslide(h_fig,no)
%
% Show slide number no in figure number h_fig.
%
% See also SMPLDEMO, DEMO1, DEMO2

% (c) of 2003 Dec 02
% Last Update: 2003 Dec 17
% Timestamp: <smplslide.m Wed 2003/12/17 15:40:29 OF@OFPC>

switch no,              % which slide to show?
case 1,
    demo1(h_fig,1); 
case 2,
    demo1(h_fig,2); 
case 3,
    demo1(h_fig,3); 
case 4,
    demo1(h_fig,4); 
case 5,
    demo1(h_fig,5); 
case 6,
    demo1(h_fig,6); 
case 7,
    demo1(h_fig,7); 
case 8,
    demo2(h_fig,1); 
case 9,
    demo2(h_fig,2); 
case 10,
    demo2(h_fig,3); 
case 11,
    demo2(h_fig,4); 
case 12,
    demo2(h_fig,5); 
case 13,
    demo2(h_fig,6); 
case 14,
    demo2(h_fig,7); 
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
case 14,
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
