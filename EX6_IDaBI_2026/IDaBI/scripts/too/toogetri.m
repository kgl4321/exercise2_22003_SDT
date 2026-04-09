 function viRow = toogetri(too, Lab, Key, bNot);
%
% function viRow = toogetri(too, Lab, Key, bNot);
%
% Returns the row indices where the columns 'Lab' 
% match the corresponding key in 'Key' (bNot==0).
% NOTE:  viRow contains unique indices only.
%
% Lab:   Defines the column in which the key is used as a filter.
%        (see toogetci). NOTE: only one Column can be selected !
% Key:   cell string vector (exclusive) or a (vertical) vector of 
%        numbers. 
%        If Key contains numbers and has two columns, like [a c], 
%        data b is selected when a <= b <= c.
% viRow: row indices matching 'Key' at column 'Lab'.
% bNot:  if 0, the selected indices are returned.
%        if 1, all indices but not the selected indices are returned.
%        (default 'bNot=0').
% 
% see also: too* functions
% 
% author/date: ja/99-99-22
%

%% set defaults, check params
viRow	= [];
if nargin < 4, bNot = 0;	end;
if ~too.nDat,	return;		end;

iCol	= toogetci(too, Lab);
if length(iCol) > 1,
	error('TOOGETRI: param "Lab" must specify exactly one column');
end;
if isempty(iCol),
	warning(sprintf('TOOGETRI: column with label %s not found', Lab));
	return;
end;
vsDat	= too.msDat(:,iCol);

%% ensure Key to be of type cell
if isstr(Key),
	Key	= cellstr(Key);
end;

%% select rows
if ~iscellstr(Key)
	%% compare numbers
	vDat	= cnvx2n(vsDat);
	for i = 1:size(Key,1),
		for iRow = 1:too.nDat,
			if size(Key,2)==2,
				if Key(i,1)<=vDat(iRow) & vDat(iRow)<=Key(i,2),
					viRow	= iuappend(viRow, iRow);
				end;
			else
				if vDat(iRow) == Key(i),
					viRow	= iuappend(viRow, iRow);
				end;
			end;
		end;
	end;
else
	%% compare strings
	for i = 1:length(Key(:)),
		for iRow = 1:too.nDat,
			if strcmp(vsDat(iRow), Key(i)),
				viRow	= iuappend(viRow, iRow);
			end;
		end;
	end;
end;

if bNot,
	viRow	= iunot(viRow, too.nDat);
end;

viRow	= viRow';

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

