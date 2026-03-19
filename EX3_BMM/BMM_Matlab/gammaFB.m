% [OUT, cfs] = gammaFB(in, lowf, uppf, fs)
%
% Calculates gammatone filters for given center frequencies and filters the
% input signal. The impulse responses of the filters are normalized such
% that the peak of the magnitude frequency response is 1 / 0dB.
%
% ----------------------------     INPUTS:     ------------------------------
% in            ...input signal vector
% lowf          ...scalar specifying the lowest filter center frequency
% uppf          ...scalar specifying the highest filter center frequency
% fs            ...sampling rate
%
% ----------------------------     OUTPUTS:     ------------------------------
% OUT           ...length(in) X length(cfs) matrix containing temporal outputs
%                   of the filterbank
% CFS			...center frequencies of the filterbank, in erbs

function [OUT, ERBS] = gammaFB(in,flow, fhigh, fs)

%% Define
in = in(:);
N = length(in);
T = N/fs;

%% Calculate gammatone filters in the time domain
ERBS = freqtoerb([flow, fhigh]); % ERB number of lowest and high frequencies
ERBS = ERBS(1):ERBS(2);			 % ERBs vector, with a spacing of 1 ERB
fc = erbtofreq(ERBS);			 % Conversion from ERB to Hz
fc = fc(:)';
Num_filt = length(fc);      % number of gammatone filters
n = 4;                      % order of filter
ERB = 24.7 + 0.108*fc;      % rectangular bandwidth of the auditory filter
bw = ERB*0.887;             % -3dB bandwidths of gammatone filters
b = 1.018*ERB;              % parameter determining the duration of the IR (bandwidth)
a = 6./(-2*pi*b).^4;
t = (0:1/fs:T-1/fs)';       % Time vector

tm = repmat(t,1,Num_filt);  % speed up calculation using repmat instead of loop
am = repmat(a,N,1);
bm = repmat(b,N,1);
fcm = repmat(fc,N,1);
Env = (tm.^(n-1))./am.*exp(-2*pi*tm.*bm) / (fs/2); % /(fs/2) so transfer functions peak at 1
IR = Env.*cos(2*pi*tm.*fcm);

[unused, idx_peak] = max(Env);
t_peak = idx_peak/fs;

%% Filter input signal in the frequency domain
OUT = ifft( fft(IR).*repmat(fft(in),1,Num_filt),N,1,'symmetric' );


