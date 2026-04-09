 function too = toouq(too, varargin);
%
% function too = toouq(too, Lab);
%
% Reduces data set 'too' to have unique data sets
% at columns specified 'Lab'. When repetitions are
% found, the data set with the highest index is selected.
% Lab:   If 'Lab' is empty, all columns are selected.
%        See TOOUQRI.
% 
% see also: toouq*, toostat* and too* functions
% 
% author/date: ja/99-10-25
%

cellArgs		= NArgDef(varargin, []);
Lab			= cellArgs{1};

too			= tooselec(too, toouqri(too, Lab));

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

