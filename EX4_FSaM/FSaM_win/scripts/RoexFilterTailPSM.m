% RoexFilterTailPSM.m - Power spectrum model threshold prediction for notched noise
% experiment assuming single parameter roex filter (roex(p)). Assumes that upper band
% goes to infinity. 
%
% Usage: thres = RoexFilterTailPSM(g,N0dB,fc,p,k)
%
% g      = column vector of deltaf/fc used in experiment
% NOdB   = spectral density of noise
% fc     = center frequency of filter
% p      = slope parameter p or roex(p)
% k      = power spectrum model proportionality constant k
%
% thres  = column vector of predicted threshold values at fRatioLow
%
% See also: RoexFilter, RoexFilterTailPSMFit

% Timestamp: 08-03-2004 15:16

function pw = RoexFilterTailPSM(gn,N0dB,fc,p,k)

N0 = 10^(N0dB/10);			% convert spectral density from dB to power

% pw has to be a threshold (dB) value, thus take 10*log10 of the power-spectrum model output
% insert 10*log10( ps ) here

pw = 10*log10(	);

% eof
