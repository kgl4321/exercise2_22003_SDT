
% rng(42)
% sig = randn(1000,1);
% plot(sig)

fs = 1000;
f = 10;
t_vector = 1:1/fs:2;

A = 2;

sig = A* sin(2*pi*f*t_vector);

plot(t_vector,sig)



%%


% maxSig = max(sig);
% minSig = min(sig);
% DR = maxSig - minSig;

R = 1;
b = 2;


stepSize = R / (2^b - 1);


display(stepSize)




sigDelta = sig / stepSize;

sigRound = floor(sigDelta) + 1/2;
sigQuantized = sigRound * stepSize;



G = 0.5;

sigGain = sigQuantized * G;

% display([sig(1:10), sigQuantized(1:10)])

% figure;
% subplot(3,1,1)
% plot(sig)
% title('Raw randn signal')
% subplot(3,1,2)
% plot(sigQuantized);
% xlabel('Sample Index');
% ylabel('Quantized Signal Amplitude');
% title('Quantized Signal Plot');
% subplot(3,1,3)
% plot(sigGain);
% xlabel('Sample Index');
% ylabel('Quantized Signal Amplitude');
% title('Gain Signal Plot');




%% QUANTIZATION

% sig2 = audioread('Birthday.wav');

fs = 1000;
f = 10;
t_vector = 1:1/fs:2-1/fs;

A = 2;

sig = A * sin(2*pi*f*t_vector);


sigQ = quantization(sig,2,2);

sigError = sig - sigQ;




figure;
plot(t_vector, sig)
hold on
plot(t_vector, sigQ)
hold on
plot(t_vector, sigError)
legend('Raw sine', 'sigQ', 'sigError')







%% NYQUIST EXERCISE (no antialiasing)


[x, fs] = audioread('sweep.wav');

% Downsample factor
N = 5; % sort of works as a sampling frequency for this homemade sampling setup (higher value -> lower sampling freq)

x_ds = zeros(1,length(x));

% Downsample
x_ds(1:N:end) = x(1:N:end);



% sound(x_ds, fs)
sound(x, fs);





%% NYQUIST (with anti-aliasing)

fs_new = fs/N; % Find the actual sampling frequency of our handcrafted signal

fc = fs_new / 2; % Define the cutoff frequency for the anti-aliasing filter (nyquist sampling rate)
display(fc)

% Apply anti-aliasing filter
x_anti_alias = lowpassfilt(x, fc, 16, fs);

x_ds_anti_alias = zeros(1,length(x));

% Downsample
x_ds_anti_alias(1:N:end) = x_anti_alias(1:N:end);




sound(x_ds_anti_alias, fs)


%% NYQUIST (also with reconstruction filter)

% Apply reconstruction filter
x_ds_reconstruction_filt = lowpassfilt(x_ds_anti_alias, fc, 16, fs);


sound(x_ds_reconstruction_filt, fs)


%% NYQUIST SPECTROGRAM OF FILTERED SIGNALS

dynrange = 39; % dynamic range of 39 dB


figure;
subplot(4,1,1)
sgram(x, fs, dynrange)
subplot(4,1,2)
sgram(x_ds, fs, dynrange)
subplot(4,1,3)
sgram(x_ds_anti_alias, fs, dynrange)
subplot(4,1,4)
sgram(x_ds_reconstruction_filt, fs, dynrange)




%% DFT EXERCISES


fs = 10e3;
t_vector = 0:1/fs:10e-3;


f0 = 1e3;
x = sin(2*pi*f0*t_vector);

figure;
plot(t_vector, x)
title(['Sine wave of f0 = ', num2str(f0)])
xlabel('Time (s)')
ylabel('x(t)')


%% 
x_1gap = x(1:2:end);
t_vector_1gap = t_vector(1:2:end);
x_4gap = x(1:4:end);
t_vector_4gap = t_vector(1:4:end);


figure;
plot(t_vector_1gap, x_1gap)
hold on
plot(t_vector_4gap, x_4gap)


%%

fs = 10e3;
t_vector = 0:1/fs:1;

f1 = 250;
f2 = 260;

x1 = sin(2*pi*f1*t_vector);
x2 = sin(2*pi*f2*t_vector);

x = x1 + x2;

figure;
plot(t_vector .* 1000, x)
title(['Combined sines of f1 = ', num2str(f1),' Hz and f2 = ' num2str(f2),' Hz'])
xlabel('Time (ms)')
ylabel('x(t)')


%%


t_vector = 0:1/fs:0.1;

f0 = 100;
A = 1;
theta = pi;

x1 = A*sin(2*pi*f0*t_vector + theta);
x2 = A*cos(2*pi*2*f0*t_vector + theta);


figure;
plot(t_vector, x1)
hold on
plot(t_vector, x2);
xlabel('Time (s)')
legend(['sin @ f0 = ', num2str(f0), ' Hz'], ['cos @ f0 = ', num2str(2*f0), 'Hz'])




%%

n = length(x1);

% f_vector = (0:n-1)*(fs/n);
f_vector = (-n/2:n/2-1) * (fs/n);

X1 = fft(x1);
X1 = fftshift(X1);
X2 = fft(x2);
X2 = fftshift(X2);


X1_real = real(X1);
X1_im = imag(X1);

X2_real = real(X2);
X2_im = imag(X2);


figure;
subplot(2,1,1)
plot(f_vector, X1_real)
hold on
plot(f_vector, X2_real)
title('Real Parts of FFT')
xlabel('Frequency (Hz)')
ylabel('Real Amplitude')
legend('Real part of x1', 'Real part of x2')
subplot(2,1,2)
plot(f_vector, X1_im)
hold on
plot(f_vector, X2_im)
title('Imaginary Parts of FFT')
xlabel('Frequency (Hz)')
ylabel('Imaginary Amplitude')
legend('Imaginary part of x1', 'Imaginary part of x2')


%%
x = x1 + x2;
N = length(x);

X = fft(x);

% Two-sided power spectrum
P2 = abs(X).^2 / N;

% Single-sided power spectrum
P1 = P2(1:floor(N/2+1));
P1(2:end-1) = 2*P1(2:end-1);   % double non-DC bins

% Frequency vector
f = (0:N/2) * (fs/N);

% Plot
figure;
subplot(2,1,1)
plot(t_vector, x)
xlabel('Time (s)')
ylabel('x(t)')

subplot(2,1,2)
plot(f, P1)
xlabel('Frequency (Hz)')
ylabel('Power')
grid on;



%% FT OF STOCHASTIC SIGNALS EXERCISE

rng(42)

N = 1e3;
xNoise = randn(N, 1);

fs = 10e3;
f_vector = (0:N/2) * (fs/N);

Xnoise = fft(xNoise);

P2noise = abs(Xnoise).^2 / N;
P1noise = P2noise(1:floor(N/2+1));
P1noise(2:end-1) = 2*P1noise(2:end-1);


P1_log = 20*log10(P1noise);



N2 = 1e5;
f_vector2 = (0:N2/2) * N2;

xNoise2 = randn(N2, 1);

Xnoise2 = fft(xNoise2);

P2noise2 = abs(Xnoise2).^2 / (fs*N2);
P1noise2 = P2noise2(1:floor(N2/2+1));
P1noise2(2:end-1) = 2*P1noise2(2:end-1);


P1_log_x2 = 20*log10(P1noise2);

figure;
subplot(3,1,1)
plot(f_vector, P1noise)
xlabel('Frequency (Hz)')
ylabel('Power')
grid on
subplot(3,1,2)
plot(f_vector, P1_log)
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
title(['Power spectrum of noise with samples N = ', num2str(N)])
grid on;
subplot(3,1,3)
plot(f_vector2, P1_log_x2)
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on;
title(['Power spectrum of noise with samples N = ', num2str(N2)])




%%

fs = 10e3;
L = 100e-3; % duration of sweep
t_vector = 0:1/fs:L;

f1 = 200;
f2 = 1e3;


k = (f2 - f1) / L;
xlin = sin(2*pi*f1*t_vector + pi*k*t_vector.^2);

N = length(xlin);
f_vector = (0:N/2) * (fs/N);

Xlin = fft(xlin);

P2lin = abs(Xlin).^2 / N;
P1lin = P2lin(1:floor(N/2+1));
P1lin(2:end-1) = 2*P1lin(2:end-1);


P1_log = 20*log10(P1lin);


figure;
subplot(2,1,1)
plot(t_vector, xlin)
xlabel('Time (s)')
ylabel('xlin(t)')
subplot(2,1,2)
plot(f_vector, P1_log)
xlabel('Frequecy (Hz)')
ylabel('Power - Abs value in dB')
grid on

figure;
dynrange = 39;
sgram(xlin, fs, dynrange)


%%

% Rectangular window
N = length(xlin);
window_size = 1:floor(N/5);
hop_length = 800;
% 
% xlin_rect = xlin(hop_length+window_size);
% t_vector_windowed = t_vector(hop_length+window_size);

rectWindow = ones(window_size(end),1);
% rectWindow = [rectWindow', zeros(N - length(rectWindow), 1)'];
rectWindow = [zeros(N - length(rectWindow), 1)', rectWindow'];
xlin_rect = xlin .* rectWindow;


% Hann window
hannWindow = hann(window_size(end));
% hannWindow = [hannWindow' zeros(length(xlin) - length(hannWindow), 1)'];
hannWindow = [zeros(length(xlin) - length(hannWindow), 1)', hannWindow'];
xlin_hann = xlin .* hannWindow;  % Apply Hann window to the signal



% Power spectrum
N_win = length(xlin_rect);
f_vector_win = (0:N_win/2) * (fs/N_win);

Xlin_rect = fft(xlin_rect);

P2lin_win = abs(Xlin_rect).^2 / N_win;
P1lin_win = P2lin_win(1:floor(N_win/2+1));
P1lin_win(2:end-1) = 2*P1lin_win(2:end-1);

P1_log_win = 20*log10(P1lin_win);


% Plots
figure;
subplot(2,1,1)
% plot(t_vector_windowed, xlin_rect)
plot(t_vector, xlin_rect)
xlabel('Time (s)')
ylabel('xlin(t)')
subplot(2,1,2)
plot(f_vector_win, P1_log_win)
xlabel('Frequecy (Hz)')
ylabel('Power - Abs value in dB')
grid on



% Power spectrum
N_win = length(xlin_hann);
f_vector_win = (0:N_win/2) * (fs/N_win);

Xlin_hann = fft(xlin_hann);

P2lin_win = abs(Xlin_hann).^2 / N_win;
P1lin_win = P2lin_win(1:floor(N_win/2+1));
P1lin_win(2:end-1) = 2*P1lin_win(2:end-1);

P1_log_win = 20*log10(P1lin_win);


% Plots
figure;
subplot(2,1,1)
plot(t_vector, xlin_hann)
xlabel('Time (s)')
ylabel('xlin(t)')
subplot(2,1,2)
plot(f_vector_win, P1_log_win)
xlabel('Frequecy (Hz)')
ylabel('Power - Abs value in dB')
grid on

