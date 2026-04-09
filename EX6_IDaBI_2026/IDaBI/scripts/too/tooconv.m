 function too = tooconv(too, varargin);
%
% function too = tooconv(too, vcType, viCols)
%
% Converts data columns of a table of observations (TOO) from
% cell format to other formats.
% 
% see also: too* functions
% 
% author/date: ja/99-99-22
%

%cellArgs	= NArgDef(varargin, 1:too.nDat, 1:too.nCol);
%viRows	= cellArgs{1};
%viCols	= cellArgs{2};

too.nCol		= length(viCols);
too.nDat		= length(viRows);
too.msDat	= too.msDat(viRows, viCols);
too.vsLab	= too.vsLab(viCols);
too.viID		= too.viID(viRows);

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

