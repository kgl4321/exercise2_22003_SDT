 function too = tooselec(too, varargin);
%
% function too = tooselec(too, viRow, viCol)
%
% Copy a subset of 'too' to a new table of observations.
% viRow, viCol are the row and column indices to be selected.
% if viRow (viCol) is empty, all rows (columns) are taken.
% 
% see also: too* functions
% 
% author/date: ja/99-09-22
%

cellArgs		= NArgDef(varargin, 1:too.nDat, 1:too.nCol);
viRow			= cellArgs{1};
viCol			= cellArgs{2};

too.nCol		= length(viCol);
too.nDat		= length(viRow);
too.msDat	= too.msDat(viRow, viCol);
too.vsLab	= too.vsLab(viCol);
too.viID		= too.viID(viRow);

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

