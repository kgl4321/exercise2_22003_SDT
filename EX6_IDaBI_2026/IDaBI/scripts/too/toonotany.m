 function too = toonotany(too, vNotAnyOfFlt);
%
% function too = toonotany(too, vNotAnyOfFlt)
%
% Deletes all datasets matching _any_ of 
% the filters in vNotAnyOfFlt. Therefore
%    too = tooor(too, vNotAnyOfFlt, 1);
% is called.
% 
% see also: tooor, tooand, toonotall, too* functions
% 
% author/date: ja/99-10-27
%

too	= tooor(too, vNotAnyOfFlt, 1);

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

