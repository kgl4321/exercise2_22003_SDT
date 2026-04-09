function [p1,f] = onesided_powerspect_kl(x,fs)

    N = length(x);

    X = fft(x);
    p2 = abs(X).^2 / N^2;           % Two-sided power spectrum
    p1 = p2(1:floor(N/2+1));        % One-sided power spectrum
    p1(2:end-1) = 2*p1(2:end-1);    % double amplitudes (except at bins DC and nyquist)
        
    f = (0:N/2) * (fs/N);

end