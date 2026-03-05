function Ft=frametight(F);
%FRAMETIGHT  Construct the canonical tight frame
%   Usage: F=frametight(F);
%          F=frametight(F,L);
%
%   Ft=frame(F) returns the canonical tight frame of F.
%
%   See also: frame, framepair, framedual
%
%   Url: http://ltfat.sourceforge.net/doc/frames/frametight.php

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
Ft=F;

% Handle the windowed transforms
switch(F.type)
  case {'dgt','dgtreal','dwilt','wmdct','filterbank','ufilterbank',...
        'nsdgt','unsdgt','nsdgtreal','unsdgtreal'}
    
    Ft.g={'tight',F.g};
    
  case {'filterbankreal','ufilterbankreal'}
    Ft.g={'realtight',F.g};  
    
  case 'gen'
    [U,sv,V] = svd(F.g,'econ');    
    Ft.g=U*V'; 
        
  case 'fusion'
    Ft.w=1./F.w;
    for ii=1:F.Nframes
        Ft.frames{ii}=frametight(F.frames{ii});
    end;
end;

