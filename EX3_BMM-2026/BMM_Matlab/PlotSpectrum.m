function [Sigspectrum, fs] =  PlotSpectrum(signal,t, plotting)
signal  = addZeroPadding(signal,t); % ensure 1 second of the signal
fs      = length(signal);           % samples of 1 second of the signal
fHz     = 0:1:fs-1;                 % Frequency vector for ploting

Sigspectrum = fft(signal)./length(signal);
if plotting
    plot(repmat(fHz,1,size(Sigspectrum,2)),abs(Sigspectrum));
    xlim ([100 10000])
    % ylim([])
    set(gca,'xscale','log')
end
end