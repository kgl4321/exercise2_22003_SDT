function gausdemo(h_fig)
% GAUSDEMO      FT of Gaussian functions (GAUSs DEMOnstration)
%
% syntax: gausdemo(h_fig)
%
% Show slide with the Fourier transforms of Gaussian functions in figure h_fig.
%
% see also DFTDEMO

% based on GAUSDEM.M from Oct 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2005 Feb 02
% Timestamp: <gausdemo.m Wed 2005/02/02 15:14:45 OF@OFPC>

figure(h_fig);
clf
FontSize=10;
rate   = 10000;			% Samplingfrequenz [Hz]
laenge = 16384;			% Laenge des Signals bzw. des Analysefensters
					% in Samples
t = (-laenge/2+1:laenge/2)/rate;		% Zeitachsenvektor 
%t = (0:laenge-1)/rate;		% Zeitachsenvektor 


invt = [t(t>=0) t(t<0)];
invgaus=exp(-0.5*(10*invt).^2);                         % erzeuge Gaussfenster
gaus=exp(-0.5*(10*t).^2);                               % erzeuge Gaussfenster
shtcs(invgaus,rate,1,4,7,'Gaussian pulse',1,30);        % show gauss pulse and its spectrum
subplot(331)
plot(t,gaus);
set(gca,'FontSize',FontSize);
axis([-0.5 0.5 -1 1])
xlabel('Time in s');
ylabel('Amplitude');
title('Gaussian pulse');
subplot(334)
axis([-10 10 -2500 2500])
subplot(337)
axis([-10 10 -2500 2500])

w=9*2*pi*rate/laenge;                                   % lege Winkelfrequenz fest
invsig=sin(5*w*invt).*invgaus;                          % generiere Sinussignal (Vektor)
sig = sin(5*w*t).*gaus;
shtcs(invsig,rate,2,5,8,'Gaussian-modulated sine');     % show gaus-modulated sine and its spectrum
subplot(332)
plot(t,sig);
set(gca,'FontSize',FontSize);
axis([-0.5 0.5 -1 1])
xlabel('Time in s');
ylabel('Amplitude');
title('Gaussian-modulated sine');
subplot(335)
axis([-50 50 -1250 1250])
subplot(338)
axis([-50 50 -1250 1250])

puls = gaus(find( (t>-0.4096) & (t<=0.4096)));
gaustrain = -[puls puls].*sin(2*w*t);
invgtrain = [gaustrain(4097:16384) gaustrain(1:4096)];
shtcs(invgtrain,rate,3,6,9,'sin \cdot (Gaussian pulse train)');        % show time signal and its spectrum
subplot(336)
xlabel('Time in s');
ch = get(gca,'Children');               % Quick and dirty workaround:
YData = get(ch,'YData');
set(ch,'YData',zeros(size(YData)));     % set all the data to zero!
axis([-20 20 -2500 2500])
subplot(339)
axis([-20 20 -2500 2500])

suptitle('Real and Imaginary Part of the Fourier Transform -- Gaussian Pulse and related Functions');
