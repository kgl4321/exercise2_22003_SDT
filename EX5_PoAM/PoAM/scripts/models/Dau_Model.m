% P_mod = Dau_Model(in,fs,fc,Q)
%
% This is an implementation of the modulation filterbank model proposed by
% Dau et al. (JASA, 1999). The implementation is not a strict reproduction 
% of the original model in the sense that the filter bandwidth and the 
% Q value can be chosen arbitrarily. The basic idea behind the model is 
% that human modulation detection performance is well-described by the 
% signal-to-noise ratio at the output of a bandpass filter tuned to the 
% modulation frequency under investigation. 
%
% The model extracts the hilbert envelope of modulated signal and carrier
% signal, downsamples both to a sampling rate of 2 kHz, calculates the
% envelope power spectra, multiplies them with the bandpass filter power
% transfer function, and integrates the ac-coupled power at the output of
% the filter.
% 
% © Johannes Zaar, November 2013
% Centre for Applied Hearing Research
% Technical University of Denmark
% 
%
% INPUTS:
% in            ...modulated signal
% fs            ...sampling rate
% fc            ...center frequency of bandpass filter
% Q             ...Q of bandpass filter (Q = fc/delta_f)
%
% OUTPUTS:
% P_mod         ...integrated modulation power of modulated signal at the
%                  output of the filter

function P_mod = Dau_Model(in,fs,fc,Q)

in = in(:);

% extract envelope
env = abs(hilbert(in));

% downsample to fs_new = 2 kHz => anti-alias LP at 1 kHz
fs_new = 2000;
env = resample(env,fs_new,fs);

% define length, make sure it's an integer number
N = length(env);                % number of samples
if mod(N,2) ~= 0                    % if number of samples is odd, reduce length by one sample
    N = N-1;
    env = env(1:N);
end

%% Calculation of envelope power spectra
X = abs(fft(env)).^2/N;             % envelope power spectrum of target envelope
X = X(1:N/2+1);                     % positive frequencies only
X(2:end) = 2*X(2:end);              % needs to be double the power (except for DC)

%% calculation of squared bandpass filter transfer function
f_pos = max(0:fs_new/N:fs_new/2,eps);                % vector containing positive frequencies
f = [f_pos -f_pos(end-1:-1:2)].';           % vector containing all frequencies
TF = abs(1./(1+ (1j*Q*(f./fc - fc./f)))).^2;% squared bandpass filter transfer function
TF = TF(1:N/2+1);

%% calculation of modulation power at the filter output, integrated across frequency
DC = X(1)/N/2;
P_mod = sum(X(2:end).*TF(2:end))/N/DC;
P_mod = max(P_mod,0.001);