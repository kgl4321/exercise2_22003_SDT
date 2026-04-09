 function viUqID	= toostatc(too, Lab)
%
% function viUqID	= toostatc(too, Lab);
%
% returns a vector from which some statistics for the values in
% column 'Lab' can be calculated from. This vector can be understood
% as a vector of IDs, where each ID (>0) stands for a unique entry. 
% Examples:
%   'max(viUqID)' is the number of unique entries in column 'Lab'.
%   'find(viUqID==i)' are the row indices, where all values in column 
%       'Lab' have the same value, i.e. the i-th unique value.
% NOTE: some statistics are printed out if nargout==0.
% Lab:     	 identifies the column, statistics are made
%          	 for. 'Lab' must specify only _one_ column.
%          	 (for more details see TOOGETCI)
% viUqID:    See above and UNIQUE output argument 'J'.
%           
% see also: toouq*, toostat* and too* functions
% 
% author/date: ja/99-10-25
%

if length(Lab)~=1,
	error('TOOSTATC returns statistics for only one column.');
end;

iCol	= toogetci(too, Lab);
if too.nDat,
	[vcsUq, viLastUq, viUqID]	= unique( too.msDat(:,iCol) );
else
	vcsUq		= [];
	viLastUq	= [];
	viUqID	= [];
end;

if ~nargout
	ShowStat(too.vsLab{iCol}, vcsUq, viLastUq, viUqID);
	viUqID = [];
end;

return;

%%-------------------------------------------------------------------------
function ShowStat(vcLab, vcsUq, viLastUq, viUqID)

	vcL	= 'Label';
	vcU	= 'nUnique';
	vcV	= 'Value';
	vcA	= 'iLast';
	vcD	= 'nDuplicated';
	nL		= max([length(vcL) length(vcLab)]);
	nU		= length(vcU);
	nV		= max([length(vcV) size(strvcat(vcsUq),2)]);
	nA		= length(vcA);
	nD		= length(vcD);

	disp(' ');
	vcFmt = sprintf(' %%-%ds %%-%ds %%-%ds %%-%ds %%-%ds ', nL, nU, nV, nA, nD);
	vc		= sprintf(vcFmt,vcL,vcU,vcV,vcA,vcD);
	disp(vc);
	disp([' ' char('-'*ones(1,length(vc)-2))]);

	nTooLastUq	= length(viLastUq);
	vcFmt = sprintf(' %%-%ds %%%dd %%-%ds %%%dd %%%dd ', nL, nU, nV, nA, nD);
	for iUq = 1:length(vcsUq),
		nDublicated	= sum( iUq==viUqID );
		disp(sprintf(vcFmt, vcLab, nTooLastUq, vcsUq{iUq}, viLastUq(iUq), nDublicated));
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

