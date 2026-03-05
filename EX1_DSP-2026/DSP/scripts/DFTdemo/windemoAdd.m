function [h_subpl] = windemoAdd();
h_subpl = zeros(2,1);                           % initialize vector for the handles
fs = 10000;
f1 = 0: fs/256 : fs/2-2*fs/256;
f2 = 0: fs/320 : fs/2-2*fs/320;
f3 = 0: fs/1280 : fs/2-2*fs/1280;
f4 = 0: fs/4352 : fs/2-2*fs/4352;

x1 = hanning(256);
x2 = [zeros(32,1) ; x1 ; zeros(32,1)];
x3 = [zeros(512,1) ; x1 ; zeros(512,1)];
x4 = [zeros(2048,1) ; x1 ; zeros(2048,1)];
X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));
X4 = abs(fft(x4));
X1 = 20*log10(X1(1:end/2-1));
X2 = 20*log10(X2(1:end/2-1));
X3 = 20*log10(X3(1:end/2-1));
X4 = 20*log10(X4(1:end/2-1));

y1 = hamming(256);
y2 = [zeros(32,1) ; y1 ; zeros(32,1)];
y3 = [zeros(512,1) ; y1 ; zeros(512,1)];
y4 = [zeros(2048,1) ; y1 ; zeros(2048,1)];
Y1 = abs(fft(y1));
Y2 = abs(fft(y2));
Y3 = abs(fft(y3));
Y4 = abs(fft(y4));
Y1 = 20*log10(Y1(1:end/2-1));
Y2 = 20*log10(Y2(1:end/2-1));
Y3 = 20*log10(Y3(1:end/2-1));
Y4 = 20*log10(Y4(1:end/2-1));

h_subpl(1) = subplot(2,1,1);
plot(f1,X1,'bo:','MarkerSize',6,'linewidth',1)
hold on
% plot(f2,X2,'mx:','MarkerSize',6,'linewidth',1)
% plot(f3,X3,'rd:','MarkerSize',6,'linewidth',1)
plot(f4,X4,'k-','linewidth',1)
axis([0 5000 -150 50])
xlabel('Frequency in Hz')
ylabel('Absolute value in dB')
title('abs(FFT(Hanning))')
% legend('figure 9','figure 10','figure 11','figure 12')
legend('figure 9','figure 12 (zero-padding)')

h_subpl(2) = subplot(2,1,2);
plot(f1,Y1,'bo:','MarkerSize',6,'linewidth',1)
hold on
% plot(f2,Y2,'mx:','MarkerSize',6,'linewidth',1)
% plot(f3,Y3,'rd:','MarkerSize',6,'linewidth',1)
plot(f4,Y4,'k-','linewidth',1)
axis([0 5000 -150 50])
xlabel('Frequency in Hz')
ylabel('Absolute value in dB')
title('abs(FFT(Hamming))')
% legend('figure 9','figure 10','figure 11','figure 12')
legend('figure 9','figure 12 (zero-padding)')
% suptitle('Windowing Effects -- Summary of previous 4 Hanning and Hamming Windows');
suptitle('Windowing Effects -- Summary of Hanning and Hamming Windows (with and without zero-padding)');

