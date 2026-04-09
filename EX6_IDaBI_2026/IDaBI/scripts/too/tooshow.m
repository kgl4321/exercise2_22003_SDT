 function mc	= tooshow(too, varargin)
%
% function mc	= tooshow(too, viRow, viCol, bShow);
%
% display 'too' label/data table 'too'. 
% A subset of columns can be selected by 'viCol'.
% A subset of rows can be selected by 'viRow'.
% viRow:	Vector of row indices in mcs.
%        (default 1:size(mcs,1))
% viCol:	Vector of column indices in mcs.
%        (default 1:size(mcs,2))
% bShow: if 1, matrix is shown even if nargout~=0.
%           
% see also: mcsshow and too* functions
% 
% author/date: ja/99-10-26
%

cellArgs	= nargdef(varargin, 1:size(too.msDat,1), 1:size(too.msDat,2), nargout==0);
viRow		= cellArgs{1};
viCol		= cellArgs{2};
bShow		= cellArgs{3};

%% patch label header
mcs		= [too.vsLab(viCol); too.msDat(viRow,viCol)];
if nargout,
	mc	= mcsshow(mcs,[],[],bShow);
else
	mcsshow(mcs,[],[],bShow);
	mc	= [];
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

