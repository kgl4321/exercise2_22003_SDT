 function too = toomerge(too, tooAppend);
%TOOMERGE merge two TOO structs into one.
%
% function too = toomerge(too, tooAppend);
%
% Merges 'tooAppend' into 'too'. 
% Restrictions:
% - too.nCol==tooAppend.nCol and tooAppend.vsLab(i)==too.vsLab(i) will
%   be checked to prevent merging of data sets which doesn't match.
% - The enumeration of 'tooAppend' ('tooAppend.viID') will be destroyed,
%   i.e. it will be changed to 
%          tooAppend.viID = tooAppend.viID + max(too1.viID)
% 
% see also: tooread(), too* functions
% 
% author/date: ja/99-10-18
% changes:		none
%

if too.nCol~=tooAppend.nCol,
	error('TOOMERGE: mismatch in number of columns');
end;

for i=1:too.nCol,
	if ~strcmp(too.vsLab{i}, tooAppend.vsLab{i}),
		error('TOOMERGE: mismatch in column labels');
	end;
end;

tooAppend.viID = tooAppend.viID + max(too.viID);
too.nDat			= tooAppend.nDat + too.nDat;
too.viID			= [too.viID(:) ; tooAppend.viID(:)	];
too.msDat		= [too.msDat	; tooAppend.msDat		];

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

