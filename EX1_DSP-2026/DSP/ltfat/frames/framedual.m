function Fd=framedual(F);
%FRAMEDUAL  Construct the canonical dual frame
%   Usage: F=framedual(F);
%          F=framedual(F,L);
%
%   Fd=frame(F) returns the canonical dual frame of F.
%
%   See also: frame, framepair, frametight
%
%   Url: http://ltfat.sourceforge.net/doc/frames/framedual.php

% Copyright (C) 2005-2012 Peter L. Søndergaard.
% This file is part of LTFAT version 1.2.0
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
  
if nargin<1
  error('%s: Too few input parameters.',upper(mfilename));
end;

% Default operation, work for a lot of frames
Fd=F;

% Handle the windowed transforms
switch(F.type)
  case {'dgt','dgtreal','dwilt','wmdct','filterbank','ufilterbank',...
        'nsdgt','unsdgt','nsdgtreal','unsdgtreal'}
    
    Fd.g={'dual',F.g};
    
  case {'filterbankreal','ufilterbankreal'}
    Fd.g={'realdual',F.g};  
    
  case 'gen'
    Fd.g=pinv(F.g)';
        
  case 'fusion'
    Fd.w=1./(F.Nframes*F.w);
    for ii=1:F.Nframes
        Fd.frames{ii}=framedual(F.frames{ii});
    end;
end;

