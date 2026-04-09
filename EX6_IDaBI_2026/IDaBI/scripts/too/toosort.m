 function [too, viRow] = toosort(too, varargin);
%
% function [too, viRow] = toosort(too, Lab);
%
% Sort 'too' data by columns specified in 'Lab'.
% Function is simmilar to matlabs SORTROWS function.
% Lab:   If 'Lab' is empty, all columns are selected.
%        See TOOGETCI.
% too:	sorted too struct
% viRow:	second parameter returned by SORTROWS
% 
% see also: sortrows and too* functions
% 
% author/date: ja/99-10-25
%

cellArgs		= nargdef(varargin, []);
Lab			= cellArgs{1};

%% select all columns if 'Lab' is empty.
if isempty(Lab),
	viCol	= 1:too.nCol;
else
	viCol	= toogetci(too,Lab);
end;

[too.msDat, viRow]	= sortrows(too.msDat, viCol);

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

