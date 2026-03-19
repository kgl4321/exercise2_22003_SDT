
function [carrier,envelope,envspectrum] = PoAM22(duration,bandwidth,modulation)

fs = 48000;
t = 0:1/fs:duration-1/fs;
fcut = 4000;
f = 0:1/duration:fs-1/duration;

carrier = bpnoise(duration*fs,fcut-bandwidth,fcut,fs);
envelope = abs(hilbert(carrier));
envspectrum = periodogram(envelope,[],length(envelope),'twosided');

modcarrier = carrier.*(1+cos(2*pi*16*t))';
modenvelope = abs(hilbert(modcarrier));
modenvspectrum = periodogram(modenvelope,[],length(modenvelope),'twosided');

switch modulation
    case 'n'
        figure
        subplot(3,1,1)
        plot(t,carrier,'-b')
        set(gca,'Xlim',[0 2],'Ylim',[min(carrier)-.2 max(carrier)+.2])
        xlabel('Time (s)')
        ylabel('Amplitude')
        subplot(3,1,2)
        plot(t,envelope,'-r','linewidth',2)
        set(gca,'Xlim',[0 2],'Ylim',[min(carrier)-.2 max(carrier)+.2])
        xlabel('Time (s)')
        ylabel('Amplitude')
        subplot(3,1,3)
        semilogx(f,envspectrum,'-g','linewidth',2);
        set(gca,'Xlim',[1 3000])
        xlabel('Frequency (Hz)')
        ylabel('Power')
    case 'y'
        figure
        subplot(3,1,1)
        plot(t,modcarrier,'-b')
        set(gca,'Xlim',[0 2],'Ylim',[min(modcarrier)-.2 max(modcarrier)+.2])
        xlabel('Time (s)')
        ylabel('Amplitude')
        subplot(3,1,2)
        plot(t,modenvelope,'-r','linewidth',2)
        set(gca,'Xlim',[0 2],'Ylim',[min(modcarrier)-.2 max(modcarrier)+.2])
        xlabel('Time (s)')
        ylabel('Amplitude')
        subplot(3,1,3)
        semilogx(f,modenvspectrum,'-g','linewidth',2);
        set(gca,'Xlim',[1 3000])
        xlabel('Frequency (Hz)')
        ylabel('Power')
end
