 function vi	= iunot(viNot, nI)
%
% function vi	= iunot(viNot, nI)
%
% IndexUniqueNot generates indices 1:nI excluding 
% indices 'viNot'. all indices in vi are unique.
%
% author/date: ja/99-10-21
%

vi				= 1:nI;			%% all indices
vi(viNot)	= 0;				%% set indices to exclude 0
vi				= find(vi);		%% none zero values are the new indices

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

