

N = 44100; % Sampling frequency in Hz
fs = N;
t = 0:1/fs:(N-1)/N; % Time vector





fhigh = 4000;

bw = [3 30 300 3000];
flow = [fhigh-bw(1)  fhigh-bw(2) fhigh-bw(3) fhigh-bw(4)];



for bb = 1:4
    out(:,bb) = bpnoise(N, flow(bb), fhigh, fs);
    env(:,bb) = abs(hilbert(out(:,bb)));
end




%%  GENERATE BANDPASS FILTERED NOISE (PLOT TEMPORAL WAVEFORM AND ENVELOPE)
for bb = 1:4
    figure;
    plot(t,out(:,bb))
    hold on
    plot(t,env(:,bb))
    xlabel("Time (ms)")
    ylabel('Amplitude');
    title(['Temporal plot of bandpass noise at bandwidth ', num2str(bw(bb)), ' Hz']);
    grid on;
end



%% COMPUTE POWER SPECTRUM AND ENVELOPE SPECTRUM


for bb = 1:4
    for aa = 1:1000
        out = bpnoise(N, flow(bb),fhigh,N);
        
        [P1, ~] = onesided_powerspect_kl(out,fs);
        Parray(:,aa,bb) = P1;


        xHilb = hilbert(out);
        env = abs(xHilb);


        pow_X(:,aa,bb) = abs(fft(env)).^2;

    end
end

meanpowX = squeeze(mean(pow_X,2));


for ii = 1:4
    p2 = meanpowX(:,ii) / N^2;           % Two-sided power spectrum
    p1 = p2(1:floor(N/2+1));        % One-sided power spectrum
    p1(2:end-1) = 2*p1(2:end-1);    % double amplitudes (except at bins DC and nyquist)
    PenvArray(:,ii) = p1;
end


%% PLOT POWER SPECTRUM AND ENVELOPE SPECTRUM


% POWER SPECTRUM
f = (0:N/2) * (fs/N);

meanP = mean(Parray,2);

figure;
for bb = 1:4
    meanPdB(:,bb) = 10*log10(meanP(:,bb));
    plot(f,meanPdB(:,bb))
    hold on
end
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
legend("3 Hz", "30 Hz", "300 Hz", "3000 Hz", 'Location', 'northwest');
title("Power spectrum")
xlim([0 4500])
ylim([-50 0])



% ENVELOPE POWER SPECTRUM
figure;
for bb = 1:4
    plot(f,10*log10(PenvArray(:,bb)))
    hold on
end
title("Envelope power spectrum");
xlabel('Frequency (Hz)');
ylabel('Envelope Power (dB)');
legend("3 Hz", "30 Hz", "300 Hz", "3000 Hz", 'Location', 'northeast');
xlim([0 1e4])
ylim([-50 50])
xscale log





%% INTRODUCE A 16 Hz MODULATION


fm = 16;
m = 1;

t = linspace(0,N/fs,N);

for bb = 1:4
    for aa = 1:1000
        
        
        
        
        out = bpnoise(N, flow(bb),fhigh,N);
        modulateout = out .* (1 + m*cos(2*pi*fm.*t)');   % modulation


        
        [P1, ~] = onesided_powerspect_kl(modulateout,fs);
        Parraymodulate(:,aa,bb) = P1;


        xHilb = hilbert(modulateout);
        env = abs(xHilb);


        pow_X(:,aa,bb) = abs(fft(env)).^2;

    end
end

modulate_meanpowX = squeeze(mean(pow_X,2));


for ii = 1:4
    p2 = modulate_meanpowX(:,ii) / N^2;           % Two-sided power spectrum
    p1 = p2(1:floor(N/2+1));        % One-sided power spectrum
    p1(2:end-1) = 2*p1(2:end-1);    % double amplitudes (except at bins DC and nyquist)
    PenvArraymodulate(:,ii) = p1;
end


%% PLOT POWER SPECTRUM AND ENVELOPE SPECTRUM


% POWER SPECTRUM
f = (0:N/2) * (fs/N);

meanPmodulate = mean(Parraymodulate,2);

figure;
for bb = 1:4
    meanPdBmodulate(:,bb) = 10*log10(meanPmodulate(:,bb));
    plot(f,meanPdBmodulate(:,bb))
    hold on
end
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
legend("3 Hz", "30 Hz", "300 Hz", "3000 Hz", 'Location', 'northwest');
title("Power spectrum")
xlim([0 4500])
ylim([-50 0])



% ENVELOPE POWER SPECTRUM
figure;
for bb = 1:4
    plot(f,10*log10(PenvArraymodulate(:,bb)))
    hold on
end
title("Envelope power spectrum (modulated 16 Hz)");
xlabel('Frequency (Hz)');
ylabel('Envelope Power (dB)');
legend("3 Hz", "30 Hz", "300 Hz", "3000 Hz", 'Location', 'northeast');
xlim([0 1e4])
% ylim([-50 50])
xscale log

