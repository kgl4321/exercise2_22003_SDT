function swpdemo(h_fig,no)
% SWPDEMO       SWeeP DEMOnstration
%
% syntax: swpdemo(h_fig,no)
%
% Show slide number no of the sweep demonstration in figure h_fig.
%
% see also DFTDEMO

% based on SWEEPDEM.M from Jan 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 May 10
% Timestamp: <swpdemo.m Mon 2004/05/10 14:17:00 OF@OFPC>

figure(h_fig);
clf
rate   = 10000;                                 % Samplingfrequenz [Hz]
len = 512;                                      % Laenge des Signals
wlen = len/4;                                   % bzw. des Analysefensters
% ---- Auf und Ab Sweep periodisch ergaenzt ----------------------------------------
swp1=sweep(1000,2000,rate,len);			% erzeuge Sweep von 1000 bis 2000 Hz
swp2=swp1(end:-1:1);    			% erzeuge Sweep von 2000 bis 1000 Hz

komplex=swp1+swp2;				% ueberlagere einen Auf-
                                                % und einen Ab-Sweep

% ------------- Analyse des Zeitverlaufes eines Sweeps -----------------------------
han=hanning(wlen)';				% Hanningfenster 
han1=[han zeros(1,len-wlen)];			% zu 4 verschiedenen Zeitpunkten
han2=[zeros(1,wlen) han zeros(1,len-2*wlen)];
han3=[zeros(1,2*wlen) han zeros(1,len-3*wlen)];
han4=[zeros(1,len-wlen) han];

switch no,
case 1,
  shtabs(swp1,rate,1,3,'Sweep(1-2kHz)',-40,40);
  shtabs(swp2,rate,2,4,'Sweep(2-1kHz)',-40,40);
  suptitle('Sweep signals and Short-Time Fourier Transform I');
case 2,
  sig=han1.*swp1;					% fenstere fruehes Zeitintervall
  shtabs(sig,rate,1,3,'Sweep windowed at the start',-40,40);
  sig=han2.*swp1;					% fenstere spaeteres Intervall			
  shtabs(sig,rate,2,4,'Sweep windowed later',-40,40);
  suptitle('Sweep signals and Short-Time Fourier Transform II');
case 3,
  sig=han3.*swp1;					% fenster noch spaeteres Intervall
  shtabs(sig,rate,1,3,'Sweep windowed even later',-40,40);
  sig=han4.*swp1;					% fenstere ganz spaetes Intervall
  shtabs(sig,rate,2,4,'Sweep windowed at the end',-40,40);
  suptitle('Sweep signals and Short-Time Fourier Transform III');
case 4,
  % ---- Analyse eines Tonkomplexes am Beispiel zweier ueberlagerter Sweeps ---------
  sig=han1.*komplex;				% fenstere fruehes Zeitintervall
  shtabs(sig,rate,1,3,'Up- and down-sweep windowed at the start',-40,40);
  sig=han2.*komplex;				% fenstere spaeteres Intervall
  shtabs(sig,rate,2,4,'Up- and down-sweep windowed later',-40,40);
  suptitle('Sweep signals and Short-Time Fourier Transform IV');
case 5,
  sig=han3.*komplex;				% fenster noch spaeteres Intervall
  shtabs(sig,rate,1,3,'Up- and down-sweep windowed even later',-40,40);
  sig=han4.*komplex;				% fenstere ganz spaetes Intervall
  shtabs(sig,rate,2,4,'Up- and down-sweep windowed at the end',-40,40);
  suptitle('Sweep signals and Short-Time Fourier Transform V');
case 6,
  % redefine the sweeps to have longer duration
  swp1=sweep(1000,2000,rate,1000);			
  swp2=swp1(end:-1:1);    			
  komplex=swp1+swp2;				
  subplot(2,2,1),sgram(swp1,rate,50),title('Up-sweep spectrogram')
  colorbar off
  subplot(2,2,2),sgram(swp2,rate,50),title('Down-sweep spectrogram')
  colorbar off
  subplot(2,2,3),sgram(komplex,rate,50),title('Up- and down-sweep spectrogram')
  colorbar off
  subplot(2,2,4),sgram(greasy,16000,60),title('Spectrogram of speech sample')
  suptitle('Sweep signals and Short-Time Fourier Transform VI')
end
