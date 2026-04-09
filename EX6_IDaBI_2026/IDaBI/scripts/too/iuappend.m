 function vi	= iuappend(vi, viAppend)
%
% function vi	= iuappend(vi, viAppend)
%
% IndexUniqueAppend appends indices 'viAppend' 
% to indices 'vi' avoiding duplicated indices.
%
% author/date: ja/99-10-21
%

for i=1:length(viAppend)
	iAppend	= viAppend(i);
	if			isempty(vi)
		vi	= iAppend;
	elseif	isempty(find(vi==iAppend))
		%% avoid duplicated indices
		vi	= [vi iAppend];
	end;
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

