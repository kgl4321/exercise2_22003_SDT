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

function TItrade_set

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
%   error('condition not recognized')
end

% define signals in structure set
set.wishlevel = str2double(work.userpar1);	% userpar1 is the wishlevel!

%set.sine_l=1/sqrt(2) * sin([0:def.intervallen-1]'*2*pi*500/def.samplerate);
%set.sine_r=1/sqrt(2) * sin([0:def.intervallen-1]'*2*pi*500/def.samplerate + ( work.exppar1/180 * pi ));

%set.hannlen=round(0.05*def.samplerate);

%set.window = hannfl(def.intervallen - 441,set.hannlen,set.hannlen);

if(work.exppar1<0)
    def.varstep{1} = [20 10 4];
    work.stepsize{1} = 20;
else
    def.varstep{1} = [-20 -10 -4];
    work.stepsize{1} = -20;
end

% eof
