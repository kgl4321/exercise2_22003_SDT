% modulationDetection2 - based on example_cfg configuration file -
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
% make changes in this file and save it as 'myexperiment_user.m'.
% Ensure that the referenced elements of structure 'work' are existing.
%
% See also help example_cfg, example_set, afc_main

function modulationDetection2_user

global def
global work
global set


% The experiment is meant to be 3-interval 3-alternative forced choice, so we need 3 signals.
% One signal holds the target amplitude modulation.
% work.expvaract holds the current value of the tracking variable of the experiment.

tref1 = real(ifft(scut(fft(randn(def.intervallen,1)),0, def.samplerate/2,def.samplerate))) ;
tref1 = real(ifft(scut(fft(tref1),set.lowercutoff, set.uppercutoff,def.samplerate))) ;

tref2 = real(ifft(scut(fft(randn(def.intervallen,1)),0, def.samplerate/2,def.samplerate))) ;
tref2 = real(ifft(scut(fft(tref2),set.lowercutoff, set.uppercutoff,def.samplerate))) ;

tuser = real(ifft(scut(fft(randn(def.intervallen,1)),0, def.samplerate/2,def.samplerate))) ;
tuser = real(ifft(scut(fft(tuser),set.lowercutoff, set.uppercutoff,def.samplerate))) ;
tuser = tuser.*(1 + (10^(work.expvaract/20) * set.modsine));    % holds the target signal

tref1 = tref1/rms(tref1)*10^(set.level/20);
tref2 = tref2/rms(tref2)*10^(set.level/20);
tuser = tuser/rms(tuser)*10^(set.level/20);

% Hanning windows
tref1 = tref1 .* set.window;
tref2 = tref2 .* set.window;
tuser = tuser .* set.window;

% pre-, post- and pausesignals (all zeros)

presig = zeros(def.presiglen,2);
postsig = zeros(def.postsiglen,2);
pausesig = zeros(def.pauselen,2);

% make required fields in work

work.signal = [tuser tuser tref1 tref1 tref2 tref2];	% left = right (diotic) first two columns holds the test signal (left right)
work.presig = presig;											% must contain the presignal
work.postsig = postsig;											% must contain the postsignal
work.pausesig = pausesig;										% must contain the pausesignal

% eof