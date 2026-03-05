function rectdemo(h_fig)
% RECTDEMO      FT of rectangular functions (RECTangular DEMOnstration)
%
% syntax: rectdemo(h_fig)
%
% Show slide with the Fourier transforms of rectangular functions in figure
% h_fig.
%
% see also DFTDEMO

% based on RECTDEM.M from Oct 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2005 Feb 02
% Timestamp: <rectdemo.m Wed 2005/02/02 14:48:31 OF@OFPC>

figure(h_fig);
clf
FontSize=10;
rate   = 10000;			% Samplingfrequenz [Hz]
laenge = 16384;			% Laenge des Signals bzw. des Analysefensters
				% in Samples
t = (-laenge/2+1:laenge/2)/rate;	% Zeitachsenvektor 
%t = (0:laenge-1)/rate;		% Zeitachsenvektor 


% -------------- Rechteckfenster und Spaltfunktion --------------------------
 
rect=[ boxcar(10)' zeros(1,16365) boxcar(9)'];	% erzeuge Rechteckfenster
shtcs(rect,rate,1,4,7,'rect',2,30);		% zeige rect und sein Spektrum in den 
rect = [zeros(1,8182) boxcar(19)' zeros(1,8183)];
subplot(331)
plot(t*1000,rect);
set(gca,'FontSize',FontSize);
axis( [-10 10 0 2])
xlabel('Time in ms');
ylabel('Amplitude');
title('rect');

rect=[ boxcar(5)' zeros(1,16375) boxcar(4)']*2;	% erzeuge Rechteckfenster
shtcs(rect,rate,2,5,8,'rect',2,30);		% zeige rect und sein Spektrum in den 
rect = [zeros(1,8187) boxcar(9)' zeros(1,8188)]*2;
subplot(332)
plot(t*1000,rect);
set(gca,'FontSize',FontSize);
axis( [-10 10 0 2])
xlabel('Time in ms');
ylabel('Amplitude');
title('rect');

rect=[ zeros(1,40) boxcar(19)' zeros(1,16325) ];	% erzeuge Rechteckfenster
shtcs(rect,rate,3,6,9,'rect',2,30);		% zeige rect und sein Spektrum in den 
rect = [zeros(1,8232) boxcar(19)' zeros(1,8133)];
subplot(333)
plot(t*1000,rect);
set(gca,'FontSize',FontSize);
axis( [-10 10 0 2])
xlabel('Time in ms');
ylabel('Amplitude');
title('rect');

suptitle('Real and Imaginary Part of the Fourier Transform -- Rectangular Function');
