function sicodemo(h_fig,no)
% SICODEMO      FFT of sine and cosine (SIne COsine DEMOnstration)
%
% syntax: sicodemo(h_fig,no)
%
% Show slide number no of the sine and cosine demonstration in figure h_fig.
%
% see also DFTDEMO

% based on SICODEM.M from Feb 99, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 May 10
% Timestamp: <sicodemo.m Mon 2004/05/10 13:39:06 OF@OFPC>

figure(h_fig);
clf
rate	= 10000;		% Samplingfrequenz [Hz]
laenge	= 256;			% Laenge des Signals bzw. des Analysefensters
				% in Samples
t = (0:laenge-1)/rate;		% Zeitachsenvektor
t2 = (0:10*laenge-1)/rate;		% Zeitachsenvektor with longer duration
dBmin = -250; %negative ylim for fft
dBmax = 50; %positive ylim for fft
dBmin2 = -20; %negative ylim for fft
dBmax2 = 70; %positive ylim for fft


switch no,
case 1,
  % ------- DFT von Sinus und Kosinus mit ganzer Anzahl von Perioden ---------------
  w=9*2*pi*rate/laenge;			% lege Winkelfrequenz fest
  sig=sin(w*t);				% generiere Sinussignal (Vektor)
  shtabs(sig,rate,1,3,'9 periods of a sine in the analysis window',dBmin,dBmax);
                                        % zeige Signal und FFT an
                                        % der Sinus links oben (subplot 1)
                                        % sein Spektrum links unten (subplot 3)
  sig=cos(w*t);				% generiere Cosinussignal
  shtabs(sig,rate,2,4,'9 periods of a cosine in the analysis window',dBmin,dBmax);
                                        % zeige Signal und FFT an
  suptitle('Fourier Transforms of Periodic Signals -- Sine and Cosine');
case 2,
  % --- DFT von Sinus mit nicht ganzer Anzahl von Perioden ----
  % Sinusoid with  9 periods of slide before
  w=9*2*pi*rate/laenge;			% lege Winkelfrequenz fest
  sig=sin(w*t);				% generiere Sinussignal (Vektor)
  shtabs(sig,rate,1,3,'9 periods of a sine in the analysis window',dBmin2,dBmax);
                                        % zeige Signal und FFT an
                                        % der Sinus links oben (subplot 1)
                                        % sein Spektrum links unten (subplot 3)
  w=7.7*2*pi*rate/laenge;
  sig=sin(w*t);
  shtabs(sig,rate,2,4,'7.7 periods of a sine in the analysis window',dBmin2,dBmax);
%   sig=cos(w*t);
%   shtabs(sig,rate,2,4,'7.7 periods of a cosine in the analysis windows',-20);
%                                         % hier wird im Bild rechts unten
%                                         % die Skalierung der Betragsachse
%                                         % etwas veraendert, Minimum auf 
%                                         % -80 dB um besser vergleichen zu
%                                         % koennen
  suptitle('Fourier Transforms of Periodic Signals -- Integer Number of Periods');
case 3,
% ------- zwei ueberlagerte Sinusse (Sini?) -------------
  w1=300*2*pi;
  w2=3000*2*pi;
  sig=sin(w1*t)+0.3*sin(w2*t);		% ueberlagere zwei Sinusse		
  ttladd = '   with T(t1) = 25.6 ms';
  shtabs(sig,rate,1,3,'sin(300 \cdot 2\pit_1) + 0.3sin(3000 \cdot 2\pit_1)',dBmin2,dBmax2,ttladd);
  ttladd = '   with T(t2) = 256 ms';
  sig=sin(w1*t2)+0.3*sin(w2*t2);		% ueberlagere zwei Sinusse		
  shtabs(sig,rate,2,4,'sin(300 \cdot 2\pit_2) + 0.3sin(3000 \cdot 2\pit_2)',dBmin2,dBmax2,ttladd);
  suptitle('Fourier Transforms of Periodic Signals -- Summation of Sinusoids');
case 4,
% ------- Rauschen -------------
  sig=1*rand(1,length(t))-1;		% generiere Rauschen
  shtabs(sig,rate,1,3,'Noise 1',dBmin2,dBmax);		
  sig=1*rand(1,length(t))-1;		% generiere Rauschen
  shtabs(sig,rate,2,4,'Noise 2',dBmin2,dBmax);
  suptitle('Fourier Transforms of Periodic Signals -- 2 Observations of Noise');
end
