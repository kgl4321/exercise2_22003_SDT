

N = 44100; % Sampling frequency in Hz
fs = N;
t = 0:1/fs:(N-1)/N; % Time vector





fhigh = 4000;


flow = [fhigh-3  fhigh-30 fhigh-300 fhigh-3000];



for bb = 1:4
    out(:,bb) = bpnoise(N, flow(bb), fhigh, fs);
    env(:,bb) = abs(hilbert(out(:,bb)));
end




%%
for bb = 1:4
    figure;
    plot(t,out(:,bb))
    hold on
    plot(t,env(:,bb))
    xlabel("Time (ms)")
    ylabel('Amplitude');
    title(['Temporal plot of bandpass noise at ', num2str(flow(bb)), ' Hz']);
    grid on;
end



%%


for bb = 1:4
    for aa = 1:1000
        out = bpnoise(N, flow(bb),fhigh,N);
        
        X = fft(out);
    
        % Two-sided power spectrum
        % P2 = abs(X).^2 / N^2;
        P2 = abs(X).^2;
        
        % Single-sided power spectrum
        P1 = P2(1:floor(N/2+1));
        P1(2:end-1) = 2*P1(2:end-1);   % double non-DC bins
        Parray(:,aa,bb) = P1;


        xHilb = hilbert(out);
        env(:,aa,bb) = abs(xHilb);

        % Two-sided power spectrum
        P2 = abs(env(:,aa,bb)).^2 / N^2;
        
        % Single-sided power spectrum
        P1 = P2(1:floor(N/2+1));
        P1(2:end-1) = 2*P1(2:end-1);   % double non-DC bins
        PenvArray(:,aa,bb) = P1;

    end
end
%%

% Frequency vector
f = (0:N/2) * (fs/N);

meanP = mean(Parray,2);

figure;
for bb = 1:4
    
    plot(f,meanP(:,bb))
    hold on
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    legend("3 Hz", "30 Hz", "300 Hz", "3000 Hz");

end




%%

% Frequency vector
f = (0:N/2) * (fs/N);

meanPenv = mean(PenvArray,2);
meanP = mean(Parray,2);

for bb = 1:4
    figure;
    plot(f,meanPenv(:,bb))
    title(sprintf('Power Spectrum of Bandpass Noise at %d Hz', flow(bb)));
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    % if bb == 1
    %     xlim([3800 4050])
    % else
    %     xlim([0 4500])
    % end
    

end



