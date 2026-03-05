function adjbutpos(h_fig)
% ADJBUTPOS     ADJust BUTton POSition
%
% used by DFTDEMO and SMPLDEMO

% (c) of, 2003 Dec 02
% Last Update: 2003 Dec 04

% get handles of the buttons
h_prev = findobj(h_fig,'Style','PushButton','String','Previous');
h_next = findobj(h_fig,'Style','PushButton','String','Next');

if ~isempty(h_prev) & ~isempty(h_next),    % only if buttons exist
  winpos = get(h_fig,'Position');          % get size and position of the figure window
  pos_prev = get(h_prev,'Position');       % get size and position of the 'previous' button
  pos_next = get(h_next,'Position');       % get size and position of the 'next' button
  pos_prev(1) = winpos(3)/2 - pos_prev(3); % calculate the new button positions
  pos_prev(1) = pos_prev(1) - pos_prev(3)/2;
  pos_next(1) = winpos(3)/2 + pos_next(3);
  pos_next(1) = pos_next(1) - pos_next(3)/2;
  set(h_prev,'Position',pos_prev);         % and set it
  set(h_next,'Position',pos_next);         % ...
end

return

%EOF
