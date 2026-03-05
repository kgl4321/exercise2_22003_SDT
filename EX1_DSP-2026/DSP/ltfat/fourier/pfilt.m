function h=pfilt(f,g,varargin)
%PFILT  Apply filter with periodic boundary conditions
%   Usage:  h=pfilt(f,g);
%           h=pfilt(f,g,a,dim);
%
%   PFILT(f,g) applies the filter g to the input f. If f is a
%   matrix, the filter is applied along each column.
%
%   PFILT(f,g,a) does the same, but downsamples the output keeping only
%   every a'th sample (starting with the first one).
%
%   PFILT(f,g,a,dim) filters along dimension dim. The default value of
%   [] means to filter along the first non-singleton dimension.
%
%   The coefficients obtained from filtering a signal f by a filter g are
%   defined by
%
%               L-1
%      c(n+1) = sum f(l+1)  g(an-l+1)
%               l=0
%
%
%   where an-l is computed modulo L.
%
%   See also: pconv
%
%   Url: http://ltfat.sourceforge.net/doc/fourier/pfilt.php

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

  
% Assert correct input.
if nargin<2
  error('%s: Too few input parameters.',upper(mfilename));
end;

definput.keyvals.a=1;
definput.keyvals.dim=[];
[flags,kv,a,dim]=ltfatarghelper({'a','dim'},definput,varargin);

L=[];

[f,L,Ls,W,dim,permutedsize,order]=assert_sigreshape_pre(f,L,dim,'PFILT');

if ~isstruct(g)
    [g,info] = comp_fourierwindow(g,L,'PFILT');
    
    h=squeeze(comp_ufilterbank_fft(f,g,a));

    % FIXME: This check should be removed when comp_ufilterbank_fft{.c/.cc}
    % have been fixed.
    if isreal(f) && isreal(g)
        h=real(h);
    end;

else
    N=L/a;
    G=middlepad(g.filter(L),L);

    for w=1:W
        F=fft(f(:,w));
        h(:,w)=ifft(sum(reshape(F.*G,N,a),2))/a;
    end;
    
    % Insert check for window being
    if isreal(f) && g.isreal
        h=real(h);
    end;
        
end;



permutedsize(1)=size(h,1);
  
h=assert_sigreshape_post(h,dim,permutedsize,order);


