 function miUqID = toostat(too, varargin)
%
% function miUqID = toostat(too, Lab);
%
% Calls TOOSTATC for each columns specified by 'Lab'
% and fills the matrix 'miUqID' with the results.
% Note that miUqID has the same size as too.msDat.
% miUqID(:,i) are set zero, if column i was _not_ 
% selected by 'Lab'.
% Lab:  See TOOGETCI.
% NOTE: some statistics are printed out if nargout==0.
% 
% see also: toouq*, toostat* and too* functions
% 
% author/date: ja/99-10-25
%

cellArgs	= NArgDef(varargin, []);
Lab		= cellArgs{1};

%% select all columns if 'Lab' is empty.
if isempty(Lab),
	viCol	= 1:too.nCol;
else
	viCol	= toogetci(too,Lab);
end;

%% call TOOSTATC
if nargout,
	miUqID	= zeros(too.nDat,too.nCol);
	for iCol = viCol,
		[miUqID(:,iCol)]	= toostatc(too, iCol);
	end;
else
	miUqID	= [];
	for iCol = viCol,
		toostatc(too, iCol);
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

