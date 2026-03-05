function shtcs(sig,rate,sigfig,realfig,imagfig,ttl,ymaxtime,ymaxspec)
% SHTCS SHow Timesignal and Complex Spectrum
%
% SHTCS(SIG,RATE,SIGFIG,REALFIG,IMAGFIG,TTL) zeigt dass Zeitsignal SIG
% und dessen komplexes Spektrum bezogen auf die Sampling-
% frequenz RATE [Hz]. SIGFIG gibt das Fenster an, in dem das Zeit-
% signal dargestellt werden soll. REALFIG und IMAGFIG geben das Fenster an,
% in dem der Real- und Imaginaerteil des Spektrums dargestellt werden sollen.
% TTL [string] gibt den Titel fuer das Zeitsignal an.
% Die Angabe eines Titels ist optional.
% YMAXTIME und YMAXSPEC geben die Skalierung der y-Achse bei den beiden
% Spektren an. Die Angabe ist optional.

% based on SHTCS.M from Oct 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 Jan 07
% Timestamp: <shtcs.m Wed 2004/01/07 08:40:19 OF@OFPC>


FontSize=10;
t = (0:length(sig)-1)/(rate/1000);              % time vector in ms
f=rate*(-length(sig)/2:length(sig)/2-1)/length(sig);

subplot(3,3,sigfig);
plot(t,sig);
set(gca,'FontSize',FontSize);
a = axis;
if nargin > 6,
  a(4)=ymaxtime;
end
axis([0 1000*length(sig)/rate a(3) a(4)]);
xlabel('Time in ms');
ylabel('Amplitude');
if nargin > 5
  title(ttl);
end

subplot(3,3,realfig);
y=fft(sig);
y=fftshift(y);
realspec = real(y);
imagspec = imag(y);
plot(f,realspec);
set(gca,'FontSize',FontSize);
a=axis;
amplmax = max(abs([realspec,imagspec]));
if nargin > 7
  amplmax = ymaxspec;
end
axis([a(1) a(2) -amplmax amplmax]);
xlabel('Frequency in Hz');
ylabel('Amplitude');
if nargin > 5
  title( ['real(FFT\{' ttl '\})']);
end

subplot(3,3,imagfig);
plot(f,imagspec);
set(gca,'FontSize',FontSize);
a=axis;
axis([a(1) a(2) -amplmax amplmax]);
xlabel('Frequency in Hz');
ylabel('Amplitude');
if nargin > 5
  title( ['imag(FFT\{' ttl '\})']);
end
