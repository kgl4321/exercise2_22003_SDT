 function viCol = toogetci(too, Lab, bNot);
%
% function viCol = toogetci(too, Lab, bNot);
%
% Get column indices for columns with labels 'Lab' (bNot==0).
% NOTE:  viCol contains unique indices only, invalid labels are
%        ignored.
%
% Lab:   Defines the columns to be selected. 'Lab' can be
%        a single string, a single number or an array of cells.
%        If 'Lab' or 'Lab{i}' is a string, the column index
%        of column with that label is selected.
%        If 'Lab' or 'Lab{i}' is a number, this number is
%        selected.
% bNot:  if 1, the selected indices are returned.
%        if 0, all indices but not the selected indices are returned.
%        (default 'bNot=0').
% 
% see also: too* functions
% 
% author/date: ja/99-99-22
%

%% set defaults
if nargin < 3, 
	bNot = 0; 
end;

%% ensure 'Lab' is of type cell
if ~iscell(Lab),
	if size(Lab,1)~=1,
		error('TOOGETCI: If "Lab" is no cell array, "size(Lab,1)==1" is required');
	end;
	Lab	= {Lab};
end;

%% make indices
viCol	= [];
for j = 1:length(Lab(:)),
	if isstr(Lab{j})
		%% Lab{j} is of type string
		for	i = 1:too.nCol,
			if strcmp(Lab(j), too.vsLab(i)),
				viCol	= iuappend(viCol, i);
				i		= too.nCol;
			end;
		end;
	elseif iscell(Lab{j})
		%% ignore cells in cell array 'Lab'
		warning('Cell in Cell is not supported by TOOGETCI');
	elseif 0 < Lab{j} & Lab{j} <= too.nCol,
		%% Lab{j} is of type index
		viCol	= iuappend(viCol, Lab{j});
	else
		%% ignore all others
		warning('Param Lab contains invalid column selector.');
	end;
end;

if bNot,
	viCol	= iunot(viCol, too.nCol);
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

