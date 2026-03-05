% fletcher_user derived from
% example_user - stimulus generation function of experiment 'example' -
%
% This function is called by afc_main when starting
% the experiment 'example'. It generates the stimuli which
% are presented during the experiment.
% The stimuli must be elements of the structure 'work' as follows:
%
% work.signal = def.intervallen by 2 times def.intervalnum matrix.
%               The first two columns must contain the test signal
%               (column 1 = left, column 2 = right) ...
% 
% work.presig = def.presiglen by 2 matrix.
%               The pre-signal. 
%               (column 1 = left, column 2 = right).
%
% work.postsig = def.postsiglen by 2 matrix.
%                The post-signal. 
%               ( column 1 = left, column 2 = right).
%
% work.pausesig = def.pausesiglen by 2 matrix.
%                 The pause-signal. 
%                 (column 1 = left, column 2 = right).
% 
% To design an own experiment, e.g., 'myexperiment',
% make changes in this file and save it as 'myexperiment_set.m'.
% Ensure that the referenced elements of structure 'work' are existing.
%
% See also help example_cfg, example_set, afc_main

function notchedNoise_user

global def
global work
global set

% generate bandpass noise using bpnoise ( spectral cut )
tref1 = (bpnoise( def.intervallen, 0, set.lbucf, def.samplerate) +  bpnoise( def.intervallen, set.ublcf, set.ubucf, def.samplerate)).* set.window;
tref2 = (bpnoise( def.intervallen, 0, set.lbucf, def.samplerate) +  bpnoise( def.intervallen, set.ublcf, set.ubucf, def.samplerate)).* set.window;
tuser = (bpnoise( def.intervallen, 0, set.lbucf, def.samplerate) +  bpnoise( def.intervallen, set.ublcf, set.ubucf, def.samplerate)).* set.window;

% get the levels right
tref1 = tref1/rms(tref1) * 10^(set.wishlevel/20) * set.levelscale;
tref2 = tref2/rms(tref2) * 10^(set.wishlevel/20) * set.levelscale;
tuser = tuser/rms(tuser) * 10^(set.wishlevel/20) * set.levelscale;

% add the signal to the target interval
tuser = tuser + ( set.sine .* set.window * 10^(work.expvaract/20));

% fill some zeros
presig=zeros(def.presiglen,2);
postsig=zeros(def.postsiglen,2);
pausesig=zeros(def.pauselen,2);

% everything in the required fields for afc
work.signal=[tuser tuser*0 tref1 tref1*0 tref2 tref2*0];	% first two columns must contain the test signal (left right)
work.presig=presig;						% must contain the presignal
work.postsig=postsig;						% must contain the postsignal
work.pausesig=pausesig;						% must contain the pausesignal

% eof