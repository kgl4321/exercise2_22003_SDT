 function too = tooread(varargin);
%TOOREAD read table from ascii file(s), excel, statistic, data, analyse
%
% function too = tooread(vsFName, bHead)
%
% Read table of observations (TOO) from ascii text file(s) 'vsFName'.
% Each line must have the same number of columns, empty lines
% and comment lines starting (!) with '%' are allowed. Column
% seperators are ' \b\r\n\t'.
% If 'vsFName' is a vector of cell strings, i.e. a list of filenames,
% tooread is called for each file and then merged into 'too'.
% If bHead=1 (default), the first line (empty lines and comment lines
% are ignored) is used for the labels of the too struct, otherwise
% lebels are generated automatically. All other lines hold one data
% set for one observation. 
% See too.txt for an example.
% See tootest() for an example on the too functions.
%
% TOO struct definition:
% too.vsLab : vector of cells containing column labels
% too.viID  : unique id for each data set
% too.nCol  : number of data columns (variables)
% too.nDat  : number of data sets
% too.msDat : matrix of cells containing data
% 
% see also: tooread(), too* functions
% 
% author/date: ja/99-09-22
% changes:		ja/99-10-18: multiple filenames now allowed
%

cellArgs		= NArgDef(varargin, [], 1);
vsFName		= cellArgs{1};
bHead			= cellArgs{2};
if isempty(vsFName),
	error('TOOREAD: no filenames');
end;

%% setup too in a nice order
too	= tooclear;

%% recursive selfcall for filenames in cell strings
if iscell(vsFName),
	too	= tooread(vsFName{1}, bHead);
	for i=2:length(vsFName),
		too	= toomerge(too, tooread(vsFName{i},bHead) );
	end;
	return;
end;

%% if we reach this point, vsFName will be a character string !
vcFName	= vsFName;

%% get number of columns and create scan format string
vc			= textread(vcFName,'%s\n',1,'whitespace','\n','commentstyle','matlab');
too.nCol	= getstrfn(strvcat(vc));

%% read data / labels
ms				= textread(vcFName, '%s ', 'commentstyle','matlab');
too.msDat	= cell(too.nCol,size(ms,1)/too.nCol);
too.msDat(:)= ms;
too.msDat	= too.msDat';
too.nDat		= size(too.msDat,1);

%% create labels
if bHead,
	too.vsLab	= too.msDat(1,:);
	too.msDat	= too.msDat(2:too.nDat,:);
	too.nDat		= too.nDat - 1;
else
    too.vsLab = cell(1,too.nCol);
	for i = 1:too.nCol,
		too.vsLab(i)	= cellstr(sprintf('var%d',i	));
	end;
end;

too.viID	= (1:too.nDat)';

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

