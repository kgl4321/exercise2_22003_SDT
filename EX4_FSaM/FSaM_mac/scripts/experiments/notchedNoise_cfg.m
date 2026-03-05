% fletcher_set derived from ...
% example_cfg - example measurement configuration file -
%
% This matlab skript is called by afc_main when starting
% the experiment 'example'.
% example_cfg construdts a structure 'def' containing the complete
% configuration for the experiment.
% To design an own experiment, e.g., 'myexperiment'
% make changes in this file and save it as 'myexperiment_cfg.m'.
% Ensure that none of the entries is missing.
%
% See also help example_set, example_user, afc_main
%

% Copyright (c) 1999 Stephan Ewert, Universitaet Oldenburg.
% $Revision: 0.92 beta$  $Date: 09-03-2004 11:12 $

def=struct(...
'expname','notchedNoise',		...		% name of experiment   
'intervalnum',3,			...		% number of intervals
'ranpos',0,					...		% interval which contains the test signal: 1 = first interval ..., 0 = random interval
'rule',[1 2],				...		% [up down]-rule: [1 2] = 1-up 2-down
'startvar',70,			    ...		% starting value of the tracking variable 
'expvarunit','dB',		    ...		% unit of the tracking variable
'varstep',[8 4 2],	        ...     % [starting stepsize ... minimum stepsize] of the tracking variable
'minvar',0,				...		% minimum value of the tracking variable
'maxvar',90,				...		% maximum value of the tracking variable
'steprule',-1,				...		% stepsize is changed after each upper (-1) or lower (1) reversal
'reversalnum',6,			...		% number of reversals in measurement phase
'exppar1',[0 0.05 0.1 0.2 0.3 0.4],	...		% vector containing experimental parameters (here the masker bandwidth rel CF) for which the exp is performed
'exppar1unit','df/fc',		...		% unit of experimental parameter
'repeatnum',1,				...		% number of repeatitions of the experiment
'parrand',[1],				...		% toggles random presentation of the elements in "exppar" on (1), off(0)
'mouse',1,					...		% enables mouse control (1), or disables mouse control (0)  
'markinterval',1,			...		% toggles visuell interval marking on (1), off(0)
'feedback',1,				...		% visuell feedback after response: 0 = no feedback, 1 = correct/false/measurement phase
'samplerate',48000,		    ...		% sampling rate in Hz
'intervallen',24000,		...		% length of each signal-presentation interval in samples (might be overloaded in 'expname_set')
'pauselen',12000,			...		% length of pauses between signal-presentation intervals in samples (might be overloaded in 'expname_set')
'presiglen',0,				...		% length of signal leading the first presentation interval in samples (might be overloaded in 'expname_set')
'postsiglen',0,			    ...		% length of signal following the last presentation interval in samples (might be overloaded in 'expname_set')
'result_path','',			...		% where to save results
'control_path','',		    ...		% where to save control files
'messages','default',	    ...		% message configuration file
'savefcn','default',		...		% function which writes results to disk
'interleaved',0,			...		% toggles block interleaving on (1), off (0)
'interleavenum',2,		    ...		% number of interleaved runs
'debug',0,					...		% set 1 for debugging (displays all changible variables during measurement)
'dither',0,					...		% 1 = enable +- 0.5 LSB uniformly distributed dither, 0 = disable dither
'bits',16,					...		% output bit depth: 8 or 16
'backgroundsig',0,		    ...		% allows a backgroundsignal during output: 0 = no bgs, 1 = bgs is added to the other signals, 2 = bgs and the other signals are multiplied
'terminate',1,				...		% terminate execution on min/maxvar hit: 0 = warning, 1 = terminate !!not used
'endstop',4,				...
'windetail',1				...
);

def.calScript = 'focusrite';
def.internSoundCommand = 'audioplayer';
def.markIntervalDelay = -0.5;                       % tweak if audioplayer is used, default is 0 ( adds delay to sound to synchronize with visual feedback
% eof
