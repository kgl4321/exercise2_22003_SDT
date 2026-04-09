 function too = tooand(too, vAndFlt, bNot);
%
% function too = tooand(too, vAndFlt, bNot)
%
% Calls TOOANDI and returns the corresponding
% TOO data subset.
% 
% see also: tooandi, too* functions
% 
% author/date: ja/99-10-27
%

%% set defaults, check params
if nargin < 3, bNot = 0;	end;

viRow = tooandi(too, vAndFlt, bNot);

if isempty(viRow),
	too	= tooclear(too);
else
	too	= tooselec(too, viRow);
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

