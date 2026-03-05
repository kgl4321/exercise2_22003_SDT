%% add paths (last modified johk 04/02/2016)
%Scripts and wav-files for DSP exercise
addpath(genpath([fileparts(which(mfilename)), filesep, 'scripts']))
addpath([fileparts(which(mfilename)), filesep, 'wav-files'])

%LTFAT Toolbox
addpath(genpath([fileparts(which(mfilename)), filesep, 'ltfat']))

%% call functions
ltfatstart %start ltfat toolbox