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

function TItrade_user

global def
global work
global set


%noiseburst  = randn(def.intervallen-441,1).*set.window;
%leftsignal  = [zeros(440-work.exppar1,1); noiseburst; zeros(1+work.exppar1,1)];
%rightsignal = [zeros(440,1); noiseburst; zeros(1,1)];

% build the click stimuli:
% reverse the direction for ILD<0
refclk = [zeros(1100+work.expvaract/2,1); ones(5,1); zeros(1100-work.expvaract/2,1)];
varclk = [zeros(1100-work.expvaract/2,1); ones(5,1); zeros(1100+work.expvaract/2,1)];

% build the click trains:
refsig = repmat(refclk,floor(def.intervallen/length(refclk)),1);
varsig = repmat(varclk,floor(def.intervallen/length(varclk)),1);

% get the correct levels
refsig = refsig/rms(refsig) * 10^((work.exppar1/2 + set.wishlevel)/20);
varsig = varsig/rms(varsig) * 10^((-work.exppar1/2 + set.wishlevel)/20);

presig=zeros(def.presiglen,2);
postsig=zeros(def.postsiglen,2);
pausesig=zeros(def.pauselen,2);

if(work.exppar1 >=0)
    work.signal = [varsig refsig refsig varsig];
else
    work.signal=[refsig varsig varsig refsig];
end

work.presig=presig;					% must contain the presignal
work.postsig=postsig;					% must contain the postsignal
work.pausesig=pausesig;					% must contain the pausesignal

% eof
