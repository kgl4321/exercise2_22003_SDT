function y = sweep(start,ende,rate,len);
% SWEEP - generate a linear frequency sweep
%
% Y = SWEEP(START,END,RATE,LEN) generiert einen Sweep mit der 
% Startfrequenz START [Hz], der Endfrequenz END [Hz] und der
% Laenge LEN [samples]. Die Frequenz des Sweeps steigt linear
% mit der Zeit an.
% RATE [Hz] gibt die Samplefrequenz an.
% Y enthaelt den Signalvektor.

% based on SWEEP.M from Nov 93, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2003 Dec 02

t=0:1/rate:1.1*len/rate;
t=t(1,1:len);
y=sin(2*pi*(start*t+(ende-start)/2*t.*t/(len/rate)));
