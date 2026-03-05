function sigout = lowpassfilt(sigin,cutoff,order,fs)
% LOWPASS Butterworth lowpass filter function
%
% syntax:  sigout = lowpassfilt(sigin,cutoff,order,fs)
%
% Filters the signal 'sigin' at a cut-off frequency 'cutoff', with a
% lowpass filter of the 'order'. The filter coefficients are determined
% using Butterworth digital filter design. The filter order has to be an
% even number.
%
% input:   sigin   signal to be filtered
%          cutoff  cut-off frequency (in Hz)
%          order   filter order (even number!)
%          fs      sampling frequency (in Hz)
%
% output:  sigout  lowpass-filtered signal
%
% see also BUTTER, FILTFILT

% (c) of, 2000 Jun 20
% Last Update: 2005 Feb 02
% Timestamp: <lowpass.m Wed 2005/02/02 13:31:16 OF@OFPC>

if nargin < 4,
  help(mfilename);
  return
end

if ~(cutoff < fs/2),                    % check cut-off frequency against Nyquist frequency
  error('The cut-off frequency has to be below the Nyquist frequency (fs/2)!');
end

if round(order/2) ~= order/2,           % check if order is even
  error('order has to be an even number!');
end

Wn = cutoff/(fs/2);
[b,a] = butter(order/2,Wn);             % only order/2 due to the use
sigout = filtfilt(b,a,sigin);           % of filtfilt!
return
