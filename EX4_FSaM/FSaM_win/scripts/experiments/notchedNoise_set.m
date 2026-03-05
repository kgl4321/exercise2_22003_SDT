% fletcher_set derived from
% example_set - setup function of experiment 'example' -
%
% This function is called by afc_main when starting
% the experiment 'example'. It makes defines elements
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

function notchedNoise_set

global def
global work
global set

% make condition dependend entries in structure set

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
   error('condition not recognized')
end

% define some constants in structure set
set.wishlevel = 40;	% spectrum level in dB SPL
set.midfreq = 2000;	% signal frequency to examine
set.ubucf = 4000;	% upper cutoff freq of upper band


set.lbucf = set.midfreq * ( 1 - work.exppar1 ); % lower band upper cutoff freq of masker noise;
set.ublcf = set.midfreq * ( 1 + work.exppar1 ); % upper band lower cutoff freq of masker noise;

currbw = 2*(set.ubucf - set.ublcf);		% current bw of both band
set.levelscale = sqrt(currbw);			% ensure a constant spectrum level

% calculate some signals
set.sine = sqrt(2) * sin([0:def.intervallen-1]'*2*pi*set.midfreq/def.samplerate);

% calculate onset/offset ramps
set.hannlen=round(0.05*def.samplerate);		% ramps have 50ms duration
set.window = hannfl(def.intervallen,set.hannlen,set.hannlen);

% eof