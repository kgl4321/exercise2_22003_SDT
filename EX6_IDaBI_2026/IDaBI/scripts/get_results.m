function too_data = get_results(expname, vp, group)
% get_results   reads in AFC dat files into a too structure
%
% too_data = get_results(vp, condition, stim)
%
% Reads in the data from an AFC dat file and puts it into a too
% (Table Of Objects) structure.
%
% see also: afc_main, tooread, toogetri, tooselec, toogetc

% (c) of, 2004 Mar 12
% Last Update: 2004 Mar 22
% Timestamp: <get_results.m Mon 2004/03/22 17:22:38 OF@OFPC>

filename = strcat(expname,'_',vp,'_',group,'.dat');
fid = fopen(filename,'rb');            % open file
cline = fgetl(fid);                    % get the comment line
fclose(fid);                           % close file
if strcmp(cline(1),'%');               % is it really a comment line?
  cline = cline(2:end);                % yes: remove the % char
  cline = cline(min(find(~isspace(cline))):end);  % and remove trailing spaces
else
  error('First line is not a comment line');
end

too_data = tooread(filename,0);        % read in data without header
for i = 1:too_data.nCol,
  tmp = sscanf(cline,'%[^ ]s');        % get the i-th label
  cline = cline(length(tmp)+1:end);    % remove the label
  if ~isempty(findstr(tmp,'exp')),     % label starts with exp?
    while isempty(findstr(tmp,'[')) | isempty(findstr(tmp,']')),  % while '[' or ']' is missing
      tmp2 = sscanf(cline,'%[ ]s');    % read all following spaces
      tmp = [tmp tmp2];                % add them to the label
      cline = cline(length(tmp2)+1:end);  % and remove from the line
      tmp2 = sscanf(cline,'%[^ ]s');   % read in up to the next space
      tmp = [tmp tmp2];                % add to the label
      cline = cline(length(tmp2)+1:end);  % and remove from the line
    end
  end
  if ~isempty(tmp),                    % if not empty:
    too_data.vsLab{i} = tmp;           % set the label
  end
  cline = cline(min(find(~isspace(cline))):end);  % with trailing spaces
end
