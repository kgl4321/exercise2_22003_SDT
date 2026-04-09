 function nField = GetStringFieldNumber(vcString);
%
% function nField = GetStringFieldNumber(vcString);
%
% Return the number of fields in 'vcString' which are
% delimited by whitespces.
%
% author / date : jens-e. appell / 2.98
%

nField	= 0;

% find start of field
v					= [~isspace(vcString)];
v					= [0 v] - [v 0];
nField			= length(find(v == -1));

return;
%%========================================================================
%%
%%	Copyright (C) 1998   	Jens-E. Appell, Carl-von-Ossietzky-Universitat
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
%%========================================================================

