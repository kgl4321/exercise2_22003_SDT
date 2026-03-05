function h_subpl = shtabs(sig,rate,sigfig,specfig,ttl,dbmin,dbmax,ttladd)
% SHTABS SHow Timesignal and ABsout value Spectrum
%
% H_SUBPL = SHTABS(SIG, RATE, SIGFIG, SPECFIG, TTL, DBMIN, DBMAX)
% zeigt dass Zeitsignal SIG und dessen Absolutbetragsspektrum bezogen
% auf die Samplingfrequenz RATE [Hz]. SIGFIG gibt das Fenster an, in dem
% das Zeitsignal dargestellt werden soll. SPECFIG gibt das Fenster an,
% in dem das Spektrum dargestellt werden soll. TTL [string] gibt den
% Titel fuer das Zeitsignal an. Der Titel des Spektrums ist dann
% automatisch 'FFT{TTL}'. Die Angabe eines Titels ist optional. Ist
% DBMIN angegeben, so wird die Betragsachse bis minimal DBMIN skaliert,
% Ist DBMAX angegeben, so wird die Betragsachse bis maximal BMAX skaliert.
% Ansonsten erfolgt die Skalierung automatisch.
% Die Handles für die Subplots werden in dem Spalten-Vektor H_SUBPL
% zurückgegeben.

% based on SHTABS.M from Jan 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 May 10
% Timestamp: <shtabs.m Mon 2004/05/10 13:46:40 OF@OFPC>

if nargin < 8 || isempty(ttladd)
    ttladd = ''; %don't add anything to the title
end

h_subpl = zeros(2,1);                           % initialize vector for the handles
t = (0:length(sig)-1)/(rate/1000);              % time vector in ms
f=rate*(0:(length(sig)-1))/length(sig);         % corrected frequency vector (DC component added)

h_subpl(1) = subplot(2,2,sigfig);
plot(t,sig);
a = axis;
axis([0 1000*length(sig)/rate a(3) a(4)]);
xlabel('Time in ms');
ylabel('Amplitude');
if exist('ttl','var') & ~isempty(ttl),
	title([ttl ttladd]);
end

h_subpl(2) = subplot(2,2,specfig);
y=fft(sig);
spec=20*log10(max(abs(y),realmin));
plot(f(1:length(f)/2),spec(1:length(f)/2));
a=axis;
if exist('dbmin','var') & ~isempty(dbmin),
  a(3) = dbmin;
end
if exist('dbmax','var') & ~isempty(dbmax),
  a(4) = dbmax;
end
axis([a(1) rate/2 a(3) a(4)]);
xlabel('Frequency in Hz');
ylabel('Absolute value in dB');
if exist('ttl','var') & ~isempty(ttl),
	title( ['abs(FFT\{' ttl '\})' ttladd]);
end
