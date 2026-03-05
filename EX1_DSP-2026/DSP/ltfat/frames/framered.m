function red=framered(F);
%FRAMERED  Redundancy of a frame
%   Usage  red=framered(F);
%
%   FRAMERED(F) computes the redundancy of a given frame F. If the
%   redundancy is larger than 1 (one), the frame transform will produce more
%   coefficients than it consumes. If the redundancy is exactly 1 (one),
%   the frame is a basis.
%
%   Examples:
%   ---------
%
%   The following simple example shows how to obtain the redundancy of a
%   Gabor frame:
%
%     F=frame('dgt','gauss',30,40);
%     framered(F)
%
%   The redundancy of a basis is always one:
%
%     F=frame('wmdct','gauss',40);
%     framered(F)
%
%   See also: frame, frana, framebounds
%
%   Url: http://ltfat.sourceforge.net/doc/frames/framered.php

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

% Default value: works for all the bases.
red=1;

switch(F.type)
  case 'gen'
    red=size(F.g,2)/size(F.g,1);
  case 'dgt'
    red=F.M/F.a;
  case 'dgtreal'
    red=F.M/F.a;
  case {'ufilterbank','filterbank'}
    red=sum(1./F.a);
  case {'ufilterbankreal','filterbankreal'}
    red=2*sum(1./F.a);
  case 'fusion'
    red=sum(cellfun(@framered,F.frames));
end;

  
