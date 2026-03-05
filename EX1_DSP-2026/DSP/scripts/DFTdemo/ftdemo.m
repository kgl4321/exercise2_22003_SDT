function ftdemo(h_fig)
% FTDEMO        FT of sine and cosine (Fourier Transformation DEMOnstration)
%
% syntax: ftdemo(h_fig)
%
% Show slide with the Fourier transform demonstration in figure h_fig.
%
% see also DFTDEMO

% based on FTDEM.M from Oct 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 Jan 06
% Timestamp: <ftdemo.m Tue 2004/01/06 16:51:30 OF@OFPC>

figure(h_fig);
clf
FontSize=10;
rate	= 10000*10;		% Samplingfrequenz [Hz]
laenge	= 512*10;		% Laenge des Signals bzw. des Analysefensters
				% in Samples
t = (0:laenge-1)/rate;		% Zeitachsenvektor
xl_f = [-2000 2000];            % limits for the frequency axes

% ------- FT von Sinus und Kosinus mit ganzer Anzahl von Perioden ---------------

w=9*2*pi*rate/laenge;			% lege Winkelfrequenz fest
					% auf si auf MATLAB Command Window aus 

sig=sin(w*t);				% generiere Sinussignal (Vektor)
freq = w/(2*pi);                        % frequency of the sine
tmp_str = sprintf('Sine (%0.0f Hz)',freq);
shtcs(sig,rate,1,4,7,tmp_str);          % zeige Signal und FFT an
					% der Sinus links oben (subplot 1)
					% sein Spektrum links unten (subplot 4 und 7)

sig=cos(w*t);				% generiere Cosinussignal
tmp_str = sprintf('Cosine (%0.0f Hz)',freq);
shtcs(sig,rate,2,5,8,tmp_str);          % zeige Signal und FFT an

w = w*4;                                % andere Winkelfrequenz
sig=sin(w*t);				% generiere Sinussignal mit anderer Frequenz
freq = w/(2*pi);                        % frequency of the sine
tmp_str = sprintf('Sine (%0.0f Hz)',freq);
shtcs(sig,rate,3,6,9,tmp_str);          % zeige Signal und FFT an

% no adjust the limits of the x axes
for i = [4:6 7:9],
  subplot(3,3,i);
  xlim(xl_f);
end

suptitle('Real and Imaginary Part of the Fourier Transform -- Sine and Cosine');
