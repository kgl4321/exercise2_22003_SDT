% revision 1.00.1 beta, 07/01/04

function lowPassModel_init

% this file is used to initialize model parameters

global def
global work
global simwork

% Some filter coefficients used in example_preproc

% 4-6 kHz four-pole Butterworth Bandpass (missing)

f_cut = 64;
% MODIFY THE PARAMETER ABOVE ------^^^^^^^^^-------
% It designates the cutoff of the low pass filter

% The function "folp" calculates the coefficients for a first order low pass filter
[simwork.lp_b,simwork.lp_a] = folp(f_cut,def.samplerate);
%eof
