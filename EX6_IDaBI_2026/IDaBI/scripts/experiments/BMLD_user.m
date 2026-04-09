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

function BMLD_user

global def
global work
global set

% parameters defining the noise:
f1_n = work.exppar1/2;                 % noise starts ones octave below
f2_n = work.exppar1*2;                 % and ends one above the CF

tref = zeros(def.intervallen,2*def.intervalnum);  % allocate memory
for i = 1:2:2*def.intervalnum,
  % generate windowed bandpassed noise
  tmp = real(ifft(scut(fft(randn(def.intervallen,1)),f1_n,f2_n,def.samplerate))) .* set.window;
  % get the correct levels
  tmp = tmp/rms(tmp) * 10^((set.wishlevel)/20);
  tref(:,i  ) = tmp;
  tref(:,i+1) = tmp;
end
tuser_l = tref(:,1) + set.sine_l * 10^((work.expvaract+set.wishlevel)/20);
tuser_r = tref(:,2) + set.sine_r * 10^((work.expvaract+set.wishlevel)/20);

presig=zeros(def.presiglen,2);
postsig=zeros(def.postsiglen,2);
pausesig=zeros(def.pauselen,2);

work.signal=[tuser_l tuser_r tref(:,3:end)];	% left = right (diotic) first two columns must contain the test signal (left right)
work.presig=presig;											% must contain the presignal
work.postsig=postsig;										% must contain the postsignal
work.pausesig=pausesig;										% must contain the pausesignal

% eof
