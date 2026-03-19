% modulationDetection1 - based on example_cfg configuration file -
%
% This function is called by afc_main when starting
% the experiment 'example'. It defines elements
% of the structure 'set'. The elements of 'set' are used 
% by the function 'example_user.m'.
% 
% If an experiments can be started with different experimental 
% conditions, e.g, presentation at different sound preasure levels,
% one might switch between different condition dependent elements 
% of structure 'set' here.
%
% For most experiments it is also suitable to pregenerate some 
% stimuli here.
% 
% To design an own experiment, e.g., 'myexperiment',
% make changes in this file and save it as 'myexperiment_set.m'.
% Ensure that this function does exist, even if absolutely nothing 
% is done here.
%
% See also help example_cfg, example_user, afc_main

function modulationDetection1_set

global def
global work
global set

% make condition dependent entries in structure set

% modified to make work.condition more error tolerant
work.condition = lower(work.condition);
switch work.condition
case 'group'
case 'group1'
case 'group2'
case 'group3'
case 'group4'
case 'group5'
case 'group6'
case 'group7'
case 'group8'
case 'group9'
case 'group10'
case 'group11'
case 'group12'
case 'group13'
case 'group14'
case 'group15'
case 'group16'
otherwise
   error('condition not recognized: group name must be written as ''groupX''')
end

switch work.userpar1
case '3'
case '30'
case '31'
case '300'
case '314'
case '3000'
otherwise
   error('illegal bandwidth')
end

bandwidth = str2num(work.userpar1);


% define signals in structure set
% fm = work.exppar1

set.modsine = sin([0:def.intervallen-1]'*2*pi*work.exppar1/def.samplerate);
set.hannlen = round(0.05*def.samplerate);
set.window = hannfl(def.intervallen,set.hannlen,set.hannlen);
set.level = 70; %dB SPL


set.lowercutoff = 4000 - bandwidth;
set.uppercutoff = 4000;

% eof