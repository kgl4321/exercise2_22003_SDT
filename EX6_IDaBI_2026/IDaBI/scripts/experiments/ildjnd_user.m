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

function ildjnd_user

global def
global work
global set

tref1 = real(ifft(scut(fft(randn(def.intervallen,1)),250,4000,def.samplerate))) .* set.window;
tref2 = real(ifft(scut(fft(randn(def.intervallen,1)),250,4000,def.samplerate))) .* set.window;
tuser = real(ifft(scut(fft(randn(def.intervallen,1)),250,4000,def.samplerate))) .* set.window;

%Ref1
tref1_l = tref1; 
tref1_r = tref1;
trms_l = rms(tref1_l);
trms_r = rms(tref1_r);
tref1_l = tref1_l/trms_l * 10^((work.exppar1)/20);
tref1_r = tref1_r/trms_r * 10^((work.exppar1)/20);

%Ref2
tref2_l = tref2; 
tref2_r = tref2;
trms_l = rms(tref2_l);
trms_r = rms(tref2_r);
tref2_l = tref2_l/trms_l * 10^((work.exppar1)/20);
tref2_r = tref2_r/trms_r * 10^((work.exppar1)/20);

%Target (% introduce ild)
tuser_l = tuser;							
tuser_r = tuser;
trms_l = rms(tuser_l);
trms_r = rms(tuser_r);
tuser_l = tuser_l/trms_l * 10^((work.exppar1 + 0.5*work.expvaract)/20);
tuser_r = tuser_r/trms_r * 10^((work.exppar1 - 0.5*work.expvaract)/20);

presig=zeros(def.presiglen,2);
postsig=zeros(def.postsiglen,2);
pausesig=zeros(def.pauselen,2);

work.signal=[tuser_l tuser_r tref1_l tref1_r tref2_l tref2_r];	% left = right (diotic) first two columns must contain the test signal (left right)
work.presig=presig;											% must contain the presignal
work.postsig=postsig;										% must contain the postsignal
work.pausesig=pausesig;										% must contain the pausesignal

% eof
