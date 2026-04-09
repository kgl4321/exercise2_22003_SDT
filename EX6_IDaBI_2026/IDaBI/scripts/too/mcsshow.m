 function mc = mcsshow(mcs, varargin);
%
% function mc = mcsshow(mcs, viRow, viCol, bShow);
%
% Show (nargout==0) or generate matrix of characters 
% (nargout>0) from cell string matrix 'mcs'. 
% mcs:   Matrix of cell strings.
% viRow:	Vector of row indices in mcs.
%        (default 1:size(mcs,1))
% viCol:	Vector of column indices in mcs.
%        (default 1:size(mcs,2))
% bShow: if 1, matrix is shown even if nargout~=0.
% 
% author/date: ja/99-10-26
%

cellArgs	= nargdef(varargin, 1:size(mcs,1), 1:size(mcs,2), nargout==0);
viRow		= cellArgs{1};
viCol		= cellArgs{2};
bShow		= cellArgs{3};

mcs		= mcs(viRow,viCol);
vcSpace	= ' '*ones(length(viRow),1);
mc			= [];
for i=1:size(mcs,2)
	mc	= [mc vcSpace strvcat(mcs(:,i))];
end;

if bShow,
	if size(mc,1),
		disp(mc);
	else
		warning('MCSSHOW: No Data to display !');
	end;
end;

if ~nargout,
	mc	= [];
end;

return
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

