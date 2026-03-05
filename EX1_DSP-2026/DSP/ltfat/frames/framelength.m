function L=framelength(F,Ls);
%FRAMELENGTH  Frame length from signal
%   Usage: L=framelength(F,Ls);
%
%   FRAMELENGTH(F,Ls) returns the length of the frame F, such that
%   F is long enough to expand a signal of length Ls.
%
%   If the frame length is longer than the signal length, the signal will be
%   zero-padded by FRANA.
%
%   If instead a set of coefficients are given, call FRAMELENGTHCOEF.
%
%   See also: frame, framelengthcoef
%
%   Url: http://ltfat.sourceforge.net/doc/frames/framelength.php

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
  
% Default value, the frame works for all input lengths
L=Ls;
  
switch(F.type)
  case {'dgt','dgtreal'}
    L = dgtlength(Ls,F.a,F.M,F.vars{:});
  case {'dwilt','wmdct'}
    L = longpar('dwilt',Ls,F.M);
  case {'gen'}
    L = size(F.g,1);
  case {'filterbank','ufilterbank','filterbankreal','ufilterbankreal'}
    L = filterbanklength(Ls,F.a);
  case {'fusion'}
    % This is highly tricky: Get the minimal transform length for each
    % subframe, and set the length as the lcm of that.
    Lsmallest=1;
    for ii=1:F.Nframes
        Lsmallest=lcm(Lsmallest,framelength(F.frames{ii},1));
    end;
    L=ceil(Ls/Lsmallest)*Lsmallest;
    
    % Verify that we did not screw up the assumptions.
    for ii=1:F.Nframes
        if L~=framelength(F.frames{ii},L)
            error(['%s: Cannot determine a frame length. Frame no. %i does ' ...
                   'not support a length of L=%i.'],upper(mfilename),ii,L);
        end;
    end;
end;
