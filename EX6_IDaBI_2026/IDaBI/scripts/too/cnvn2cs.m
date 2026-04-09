 function CS = cnvn2cs(N, varargin)
%CNVN2CS convert numbers to cell strings 
%
%  function CS = cnvn2cs(N,cFind,cReplace);
%
% Convert matrix 'N' of numbers to matrix of cell strings 'CS'. 
% If characters have to be replaced (example: german ',' to 
% matlab '.'), they can be spcified by 'cFind' and 'cReplace'.
% (default: no replacement)
% 
% example:  CS = cnvn2cs([1.1 2.2;3.3 4.4])
%           CS = cnvn2cs([1.1 2.2;3.3 4.4],'.',',')
%
% see also: cnvn2cs, cnvn2vc, cnvx2n
% 
% author/date: ja/99-09-22
%

cellArgs	= NArgDef(varargin, 'x', 'x');
cFind		= cellArgs{1};
cReplace	= cellArgs{2};

%% convert / replace
CS	= cells(size(N,1),size(N,2));
for i=1:length(N(:))
	vc							= num2str(N(i));
	vc(find(vc==cFind))	= cReplace;
	CS(i)						= cellstr(vc);
end;

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

