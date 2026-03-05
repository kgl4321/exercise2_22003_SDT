function gf=filterbankresponse(g,a,L,varargin)
%FILTERBANKRESPONSE  Response of filterbank as function of frequency
%   Usage:  gf=filterbankresponse(g,a,L);
%      
%   FILTERBANKRESPONSE(g,a,L) computes the total response in frequency of
%   a filterbank specified by g and a for a signal length of
%   L. This corresponds to summing up all channels. The output is a
%   usefull tool to investigate the behaviour of the windows, as peaks
%   indicate that a frequency is overrepresented in the filterbank, while
%   a dip indicates that it is not well represented.
%
%   In mathematical terms, this function computes the diagonal of the
%   Fourier transform of the frame operator.
%
%   FILTERBANKRESPONSE(g,a,L,'real') does the same for a filterbank
%   intended for positive-only filterbank.
%
%   See also: filterbank, filterbankbounds
%
%   Url: http://ltfat.sourceforge.net/doc/filterbank/filterbankresponse.php

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
  
definput.flags.ctype={'complex','real'};
definput.flags.plottype={'plot','noplot'};
[flags,kv]=ltfatarghelper({},definput,varargin);

gf=zeros(L,1);
M=numel(g);
  
for m=1:M
  gf=gf+abs(fft(middlepad(g{m},L))).^2;
end;
  
if flags.do_real
  gf=gf+involute(gf);   
end;

if flags.do_plot
  plotfft(gf,'lin');
end;
