function F=frameaccel(F,Ls);  
%FRAMEACCEL  Precompute structures
%   Usage: F=frameaccel(F,L);
%
%   F=FRAMEACCEL(F,Ls) precomputes certain structures that makes the basic
%   frame operations FRANA and |frsyn|_ faster (like instantiating the
%   window from a textual description). If you only need to call the
%   routines once, calling FRAMEACCEL first will not provide any total
%   gain, but if you are repeatedly calling these routines, for instance in
%   an iterative algorithm, is will be a benefit.
%
%   Notice that you need to input the signal length Ls, so this routines
%   is only a benefit if Ls stays fixed.
%
%   If FRAMEACCEL is called twice for the same transform length, no
%   additional computations will be done.
%
%   See also: frame, frana, framelength, framelengthcoef
%
%   Url: http://ltfat.sourceforge.net/doc/frames/frameaccel.php

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
  
if strcmp(F.type,'fusion')
    for ii=1:F.Nframes
        F.frames{ii}=frameaccel(F.frames{ii},Ls);
    end;
    return;
end;

% Default values for a lot of transforms
F.L=Ls;
F.isfac=1;

if ~isfield(F,'g')
  % Quick exit, the frame does not use a window. In this case, the frame
  % always has a factorizations
  return;
end;
  
% From this point and on, we are sure that F.g

L=framelength(F,Ls);
  

if (isfield(F,'L') && (L==F.L))
  % Quick return, we have already accelerated
  return
end;

if ~isempty(F.g)
  
  switch(F.type)
   case 'gen'
    info.isfac=~issparse(F.g);  
   case {'dgt','dgtreal'}
    [F.g,F.g_info]  = gabwin(F.g,F.a,F.M,L,F.vars{:});
   case {'dwilt','wmdct'}
    [F.g,F.g_info]  = wilwin(F.g,F.M,L);
   case {'filterbank','ufilterbank'}
    [F.g,F.g_info]  = filterbankwin(F.g,F.a,L);
    F.isfac=F.g_info.isfac;
   case {'filterbankreal','ufilterbankreal'}
    [F.g,F.g_info]  = filterbankwin(F.g,F.a,L,'real');
    F.isfac=F.g_info.isfac;
   case {'nsdgt','unsdgt','nsdgtreal','unsdgtreal'}
    [F.g,F.g_info]  = nsgabwin(F.g,F.a,F.M,L);
    F.isfac=F.g_info.isfac;
  end;
  
end;

F.L=L;

