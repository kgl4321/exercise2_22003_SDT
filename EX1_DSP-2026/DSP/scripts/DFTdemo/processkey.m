function processkey(h_fig)
% PROCESSKEY processes a key press inside DFTDEMO
%
% used by DFTDEMO and SMPLDEMO

% Author:    : of
% Created    : 2005 Mar 09
% Last Update: 2005 Mar 11
% Timestamp  : <processkey.m Fri 2005/03/11 12:15:59 OF@OFPC>

ascVal = double(get(h_fig,'CurrentCharacter'));  % get ASCII value of character
h_nxt = findobj(h_fig,'String','Next');
h_prv = findobj(h_fig,'String','Previous');

if ~isempty(ascVal),
  switch ascVal,
  case {32, 29, 31, 43, 13, 78, 110},
    if strcmp(lower(get(h_nxt,'Enable')),'on'),
      evalstr = get(h_nxt,'Callback');
      eval(evalstr);
    end

  case { 8, 28, 30, 45, 80, 112},
    if strcmp(lower(get(h_prv,'Enable')),'on'),
      evalstr = get(h_prv,'Callback');
      eval(evalstr);
    end

  case {27, 81, 88, 113, 120}
    close(h_fig);
  end
end
