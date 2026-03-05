function deltdemo(h_fig)
% DELTDEMO      FT of delta pulses (DELTa DEMOnstration)
%
% syntax: deltdemo(h_fig)
%
% Show slide with the Fourier transforms of delta pulses in figure h_fig.
%
% see also DFTDEMO

% based on DELTDEM.M from Oct 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2005 Feb 02
% Timestamp: <deltdemo.m Wed 2005/02/02 15:23:26 OF@OFPC>

figure(h_fig);
clf
FontSize=10;
rate   = 10000;			% Samplingfrequenz [Hz]
laenge = 256;			% Laenge des Signals bzw. des Analysefensters
					% in Samples

t = (-laenge/2+1:laenge/2)/rate;		% Zeitachsenvektor 
%t = (0:laenge-1)/rate;		% Zeitachsenvektor 


delt = [1 zeros(1,laenge-1)];                           % erzeuge Deltapuls
shtcs(delt,rate,1,4,7,'Delta pulse',1,2);		% zeige delt und sein Spektrum
delt = [zeros(1,laenge/2-1) 1 zeros(1,laenge/2)];	% erzeuge Deltapuls
subplot(331)
plot(t*1000,delt);
set(gca,'FontSize',FontSize);
axis( [min(t*1000) max(t*1000) 0 1])
xlabel('Time in ms');
ylabel('Amplitude');
title('Delta pulse');

d16 = [1 zeros(1,15)];                                          % Delta-Puls
dtrain=[ d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16 d16];	% erzeuge Pulsfolge
tmp_str = sprintf('Pulse train (%0.0f Hz)',rate/length(d16));   % title
shtcs(dtrain,rate,2,5,8,tmp_str);                               % zeige dtrain und sein Spektrum in den 

d8 = [1 zeros(1,7)];                                            % Delta-Puls
dtrain=[ d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8 d8];      % erzeuge Pulsfolge
dtrain=[ dtrain dtrain];                                        % erzeuge Pulsfolge
tmp_str = sprintf('Pulse train (%0.0f Hz)',rate/(length(d8)));  % title
shtcs(dtrain,rate,3,6,9,tmp_str);                               % zeige dtrain und sein Spektrum in den 

suptitle('Real and Imaginary Part of the Fourier Transform -- Delta Pulse and Pulse Train');
