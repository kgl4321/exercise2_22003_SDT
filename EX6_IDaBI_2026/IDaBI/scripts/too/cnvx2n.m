 function N = cnvx2n(X, varargin);
%CNVX2N convert strings, cell strings to numbers
%
%  function N = CNVX2N(X,cFind,cReplace);
%
% Convert matrix 'X' of type cell string or char
% to matrix of numbers 'N'. If characters have to be
% replaced (example: german ',' to matlab '.'), they
% can be spcified by 'cFind' and 'cReplace'.
% (default: replacement ',' by '.')
%  
% example:  N = cnvx2n({'1.1' '2.2';'3.3' '4.4'})
%           N = cnvx2n(['1,12 2,2';'3   4,4 '],',','.')
%
% see also: cnvn2cs, cnvn2vc, cnvx2n
% 
% author/date: ja/99-99-22
%

cellArgs	= NArgDef(varargin, ',', '.');
cFind		= cellArgs{1};
cReplace	= cellArgs{2};

%% convert cell strings to character strings
nRow	= size(X,1);
if			iscellstr(X),
	X		= strvcat(X);
elseif	ischar(X),
	;
else
	error('Type of X is unsupported');
end;

%% make replacement
X(find(X==cFind))	= cReplace;

%% get number, and patch to dimensions we had before
v		= str2num(X);
N		= zeros(nRow, length(v(:)) / nRow);
N(:)	= v(:);

return;
%%-------------------------------------------------------------------------
%%
%%	Copyright (C) 1999   	Jens-E. Appell, Carl-von-Ossietzky-Universitat
%%	
%%	Permission to use, copy, and distribute this software/file and its
%%	documentation for any purpose without permission by the author
%%	is strictly forbidden.
%%
%%	Permission to modify the software is granted, but not the right to
%%	distribute the modified code.
%%
%%	This software is provided "as is" without expressed or implied warranty.
%%
%%
%%	AUTHOR
%%
%%		Jens-E. Appell
%%		Carl-von-Ossietzky-Universitat
%%		Fachbereich 8, AG Medizinische Physik
%%		26111 Oldenburg
%%		Germany
%%
%%		e-mail:		jens@medi.physik.uni-oldenburg.de
%%
%%-------------------------------------------------------------------------

