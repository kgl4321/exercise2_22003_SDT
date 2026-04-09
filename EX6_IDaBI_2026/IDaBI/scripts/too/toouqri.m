 function viRow = toouqri(too, varargin);
%
% function viRow = toouqri(too, Lab);
%
% Returns row indices in too.msDat, so that 
% too.msDat(viRow,:) are the data sets, which
% do not have same entries in all the columns
% specified 'Lab'. If repetitions are encountered,
% the data set with the highest index is selected.
% Lab:   If 'Lab' is empty, all columns are selected.
%        See TOOGETCI.
% viRow: row indices in too.msDat(viRow,:)
% 
% see also: toouq*, toostat* and too* functions
% 
% author/date: ja/99-10-25
%

cellArgs		= NArgDef(varargin, []);
Lab			= cellArgs{1};
miUqID		= toostat(too, Lab);
[B,viRow,J]	= unique(miUqID, 'rows');
viRow			= sort(viRow);		%% unsort, what UNIQUE had sorted

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

