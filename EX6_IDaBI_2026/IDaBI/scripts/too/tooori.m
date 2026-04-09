 function viRow = tooori(too, vOrFlt, bNot);
%
% function viRow = tooori(too, vOrFlt, bNot)
%
% Returns the indices of datasets which match 
% filters given in 'vOrFlt'. The filters are 
% applied like logical operator _or_. 
% Each entry 'vOrFlt(i)' must be a cell array 
% with 2 entries, like:
%       'vOrFlt(i) = {Lab, Key}'
% Here 'Lab' and 'Key' are the parameters passed to toogetri.
% example:
%       tooand(too, {{'Lab1','Val1'} , {'Lab2', [10 20 30]});
%       will return all data sets that have value 'Val1' in
%       column 'Lab1' _or_ one of the values 10, 20 or 30 at
%       label 'Lab2'.
% bNot: if 0, the selected indices are returned.
%       if 1, all indices but not the selected indices are returned,
%       it is all indices which not match _none_ of the vOrFlt.
%       (default 'bNot=0').
% 
% see also: tooandi, toogetri, too* functions
% 
% author/date: ja/99-10-21
%

%% set defaults, check params
viRow	= [];
if nargin < 3, bNot = 0;	end;
if ~too.nDat,	return;		end;

for iOrFlt = 1:length(vOrFlt),
	OrFlt		= vOrFlt{iOrFlt};
	viRow		= iuappend(viRow, toogetri(too, OrFlt{1}, OrFlt{2}));
end;

if bNot,
	viRow	= iunot(viRow, too.nDat);
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

