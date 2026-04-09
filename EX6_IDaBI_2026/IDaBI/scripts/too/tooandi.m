 function viRow = tooandi(too, vAndFlt, bNot);
%
% function viRow = tooandi(too, vAndFlt, bNot)
%
% Returns the indices of subsets which match 
% filters given in 'vAndFlt'. The filters are 
% applied like logical operator _and_. 
% Each entry 'vAndFlt(i)' must be a cell array 
% with 2 entries, like:
%      'vAndFlt(i) = {Lab, Key}'
% Here 'Lab' and 'Key' are the parameters passed to toogetri.
% NOTE: Logical operator _or_ within one column can be applied, 
%       by using a set of possible data in parameter 'Key', like:
%       'vAndFlt(i) = {'Lab2', [10 20 30]}.
% example:
%       tooand(too, {{'Lab1','Val1'} , {'Lab2', [10 20 30]});
%       will return all data sets that have value 'Val1' in
%       column 'Lab1' _and_ one of the values 10, 20 or 30 at
%       label 'Lab2'.
% bNot: if 0, the selected indices are returned.
%       if 1, all indices but not the selected indices are returned,
%       it is all indices which not match _all_ of the vAndFlt.
%       (default 'bNot=0').
% 
% see also: tooori, toogetri, too* functions
% 
% author/date: ja/99-10-21
%

%% set defaults, check params
viRow	= [];
if nargin < 3, bNot = 0;	end;
if ~too.nDat,	return;		end;

tooTmp	= too;
for iAndFlt = 1:length(vAndFlt),
	AndFlt	= vAndFlt{iAndFlt};
	vi			= toogetri(tooTmp, AndFlt{1}, AndFlt{2});
	if isempty(vi),
		tooTmp	= tooclear(tooTmp);
		break;
	else
		tooTmp	= tooselec(tooTmp, vi);
	end;
end;

viRow	= [];
for i=1:tooTmp.nDat,
	viRow	= [viRow ; find(tooTmp.viID(i)==too.viID)];
end;

if bNot,
	viRow	= iunot(viRow, too.nDat);
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

