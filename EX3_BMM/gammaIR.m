function [g,t] = gammaIR(durImp, fc, fs)

t = 0:1/fs:durImp;


n = 4;                  % Order of filter
ERB = 24.7 + 0.108 *fc;
b = 1.108*ERB;              % determines duration of impulse response
a = 6 / ((-2*pi*b)^4);  % Integral for 4th order filter

phi = 0;

g = a^-1 * t.^(n-1) .* exp(-2*pi*b*t) .* cos(2*pi*fc*t + phi);



end
