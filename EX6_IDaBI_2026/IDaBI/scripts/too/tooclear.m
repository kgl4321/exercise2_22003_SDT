 function too = tooclear(too);
%
% function too = tooclear(too);
%
% return an empty TOO struct. if 'too' 
% is given, the labels are copied and
% the data is cleared.
% 
% see also: too* functions
% 
% author/date: ja/99-10-21
%

if ~nargin,
	too.vsLab	= [];
	too.nCol		= 0;
end;
too.viID		= [];
too.nDat		= 0;
too.msDat	= [];

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

