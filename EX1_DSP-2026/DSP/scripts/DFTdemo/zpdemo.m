function zpdemo(h_fig)
% ZPDEMO        Zero Padding DEMOnstration
%
% syntax: zpdemo(h_fig)
%
% Show slide with the zero padding demonstration in figure h_fig.
%
% see also DFTDEMO

% based on WINDEM.M from Jan 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 May 10

figure(h_fig);
clf
rate   = 10000;				% Samplingfrequenz [Hz]
laenge = 256;				% Laenge des Signals bzw. des
					% Analysefensters in Samples
t = (0:laenge-1)/rate;			% Zeitachsenvektor

% ---- je eine Periode von Sinus und Cosinus mit Nullen ergaenzt ----------------------
w=5*2*pi*rate/laenge;					% Winkelfrequenz
sig=sin(w*t);						% Sinus generieren,
sig=sig(1:ceil(2*pi*rate/w));				% eine Periode rausschneiden 
sig=[zeros(1,floor(128-length(sig)/2)) sig zeros(1,floor(128-length(sig)/2))];
                                                      % mit Nullen ergaenzen
shtabs(sig,rate,1,3,'rect-windowed sine',-40); 	% darstellen
sig=cos(w*t);						% nochmal mit Cosinus
sig=sig(1:ceil(2*pi*rate/w));				% eine Periode rausschneiden 
sig=[zeros(1,floor(128-length(sig)/2)) sig zeros(1,floor(128-length(sig)/2))];		% 
                                                      % mit Nullen ergaenzen
shtabs(sig,rate,2,4,'rect-windowed cosine',-40);
  suptitle('Windowing Effects -- Application of Windows to a Signal IV');
