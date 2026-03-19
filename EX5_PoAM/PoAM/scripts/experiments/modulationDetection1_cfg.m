% modulationDetection1 - based on example_cfg configuration file -
%
% This matlab skript is called by afc_main when starting
% the experiment 'modulationdetection'.
% modulationdetection_cfg constructs a structure 'def' containing the complete
% configuration for the experiment.
% To design an own experiment, e.g., 'myexperiment'
% make changes in this file and save it as 'myexperiment_cfg.m'.
% The default values of all parameters are defined in 'default_cfg.m'
%
% See also help example_set, example_user, afc_main
%

% Copyright (c) 1999-2000 Stephan Ewert, Universitaet Oldenburg.
% $Revision: 0.93 beta$  $Date: 2000/08/14 10:01:37 $
% This file was modified by Thomas Ulrich Christiansen 2004/03/09


def=struct(...
'expname','modulationDetection1',		...		% name of experiment   
'intervalnum',3,			...		% number of intervals
'ranpos',0,					...		% interval which contains the test signal: 1 = first interval ..., 0 = random interval
'rule',[1 2],				...		% [up down]-rule: [1 2] = 1-up 2-down
'startvar',-6,				...		% starting value of the tracking variable
'expvarunit','dB',		...		% unit of the tracking variable
'varstep',[4 2 1],			...      % [starting stepsize ... minimum stepsize] of the tracking variable
'minvar',-100,				...		% minimum value of the tracking variable
'maxvar',0,					...		% maximum value of the tracking variable
'steprule',-1,				...		% stepsize is changed after each upper (-1) or lower (1) reversal
'reversalnum',6,			...		% number of reversals in measurement phase
'exppar1',[8 16 32 64 128 256],...	% vector containing experimental parameters for which the exp is performed
'exppar1unit','Hz',		...		% unit of experimental parameter
'repeatnum',2,				...		% number of repeatitions of the experiment
'parrand',1,				...		% toggles random presentation of the elements in "exppar" on (1), off(0)
'mouse',1,					...		% enables mouse control (1), or disables mouse control (0)  
'markinterval',1,			...		% toggles visuell interval marking on (1), off(0)
'feedback',1,				...		% visuell feedback after response: 0 = no feedback, 1 = corrsay ect/false/measurement phase
'samplerate',44100,		...		% sampling rate in Hz
'intervallen',22050,		...		% length of each signal-presentation interval in samples (might be overloaded in 'expname_set')
'pauselen',22050,			...		% length of pauses between signal-presentation intervals in samples (might be overloaded in 'expname_set')
'presiglen',100,			...		% length of signal leading the first presentation interval in samples (might be overloaded in 'expname_set')
'postsiglen',100,			...		% length of signal following the last presentation interval in samples (might be overloaded in 'expname_set')
'result_path','',			...		% where to save results
'control_path','',		...		% where to save control files
'messages','default',	...		% message configuration file
'savefcn','default',		...		% function which writes results to disk
'interleaved',0,			...		% toggles block interleaving on (1), off (0)
'interleavenum',3,		...		% number of interleaved runs
'debug',0,					...		% set 1 for debugging (displays all changible variables during measurement)
'dither',0,					...		% 1 = enable +- 0.5 LSB uniformly distributed dither, 0 = disable dither
'bits',16,					...		% output bit depth: 8 or 16
'backgroundsig',0,		...		% allows a backgroundsignal during output: 0 = no bgs, 1 = bgs is added to the other signals, 2 = bgs and the other signals are multiplied
'terminate',1,				...		% terminate execution on min/maxvar hit: 0 = warning, 1 = terminate !!not used
'endstop',3,				...
'windetail',1,				...
'loadafcext',0,			...
'afcextname','pics'		...
);

% def.calScript = 'studentcomputer';
def.calScript = 'focusrite';
% eof
