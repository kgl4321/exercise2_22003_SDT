 function too = toowrite(vcFName, too, varargin);
%
% function too = toowrite(vcFName, too, bHead, Description, cSeperator)
%
% Write table of observations (TOO) to ascii text file 'vcFName'.
% 'cSeperator' is used to seperate columns (default '\t').
% if bHead=1, labels too.vsLab are written into first row of 'vcFName'
% (default), otherwise labels are not written into the header.
% If ~isempty(Description) a discription is written as a comment into 
% the first line of the file. If ischar(Description) the string
% 'vcDescription' is used for the description. If Description=1
% toowrite() generates a description (default is Description=[]).
% 
% see also: tooread(), too* functions
% 
% author/date: ja/99-99-22
%

cellArgs		= NArgDef(varargin, 1, [], '\t');
bHead			= cellArgs{1};
Description	= cellArgs{2};
cSep			= cellArgs{2};

%% open file
fid	= fopen(vcFName,'w');
if ~fid,
	error(sprintf('Can not open file "%s".', vcFName));
end;

%% write description
if ~isempty(Description),
	if ischar(Description),
		fprintf(fid,'%% %s\n',Description);
	else
		v	= fix(clock);
		fprintf(fid,'%% TOOFile: "%s", written on %d-%02d-%02d-%02d-%02d-%02d\n',vcFName,v(1),v(2),v(3),v(4),v(5),v(6));
	end;
end;

%% setup data
if bHead,
	mc	= [too.vsLab; too.msDat];
else
	mc	= too.msDat;
end;
[nRow, nCol]	= size(mc);

%% write data
for i=1:nRow,
	fprintf(fid,char(mc(i,1)));
	for j=2:nCol,
		fprintf(fid,'\t%s',char(mc(i,j)));
	end;
	fprintf(fid,'\n');
end;

%% close file
fclose(fid);
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

