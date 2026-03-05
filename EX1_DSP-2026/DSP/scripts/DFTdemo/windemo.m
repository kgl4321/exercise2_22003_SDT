function windemo(h_fig,no)
% WINDEMO       Windowing effects of the FFT (WINdow DEMOnstration)
%
% syntax: windemo(h_fig,no)
%
% Show slide number no of the windowing demonstration in figure h_fig.
%
% see also DFTDEMO

% based on WINDEM.M from Jan 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2004 May 10

figure(h_fig);
clf
rate   = 10000;                         % Samplingfrequenz [Hz]
laenge = 256;                           % Laenge des Signals bzw. des
                                        % Analysefensters in Samples
xl_f   = [0 5000];                      % limits of the frequency axes
h_sp   = zeros(2,2);                    % initialize the matrix for the handles to the
                                        % subplots

switch no,
case 1,
  % -------------- Rechteckfenster und Spaltfunktion --------------------------
  rect=[zeros(1,100) boxcar(56)' zeros(1,100)]; % erzeuge Rechteckfenster
  h_sp(:,1) = shtabs(rect,rate,1,3,'rect',-20,40); % zeige rect und sein Spektrum in den 
                                                % linken Fenstern
  f=17;                                         % Frequenz
  x=f*2*pi*((1:laenge)/laenge-0.5)+1e-50;       % erzeuge `um Null symmetrischen Vektor´
  sinc=sin(x)./x;                               % erzeuge Spaltfunktion
  h_sp(:,2) = shtabs(sinc,rate,2,4,'sinc');     % stelle sinc mit Spektrum dar
  suptitle('Windowing Effects -- Rectangular and Sinc Function');
case 2,
  % ------ Hanning und Hammingfenster -----------------------------------
  han=hanning(laenge)';				% erzeuge Hanningfenster
  h_sp(:,1) = shtabs(han,rate,1,3,'Hanning',-150);
  ham=hamming(laenge)';				% erzeuge Hammingfenster
  h_sp(:,2) = shtabs(ham,rate,2,4,'Hamming',-150);
  suptitle('Windowing Effects -- Hanning and Hamming Window');
case 3,
  % ------ Hanning und Hammingfenster mit Zeropadding -------------------
  han=hanning(laenge)';				% erzeuge Hanningfenster
  han0=zeropad(han,length(han),laenge+64);	% ergaenze Hanning vorne und hinten mit 
						% 32 Nullen
  h_sp(:,1) = shtabs(han0,rate,1,3,'Hanning with padded zeros',-150);
  ham=hamming(laenge)';				% erzeuge Hammingfenster
  ham0=zeropad(ham,length(ham),laenge+64);	% das gleiche mit Hamming
  h_sp(:,2) = shtabs(ham0,rate,2,4,'Hamming with padded zeros',-150);
  suptitle('Windowing Effects -- Hanning and Hamming Window with Zero Padding I');
case 4,
  % ------ Hanning und Hammingfenster mit Zeropadding -------------------
  han=hanning(laenge)';				% erzeuge Hanningfenster
  han01=zeropad(han,length(han),laenge+1024);	% ergaenze Hanning vorne und hinten mit 
						% 1024 Nullen
  h_sp(:,1) = shtabs(han01,rate,1,3,'Hanning with more padded zeros',-150);
  ham=hamming(laenge)';				% erzeuge Hammingfenster
  ham01=zeropad(ham,length(ham),laenge+1024);	% das gleiche mit Hamming
  h_sp(:,2) = shtabs(ham01,rate,2,4,'Hamming with more padded zeros',-150);
  suptitle('Windowing Effects -- Hanning and Hamming Window with Zero Padding II');
case 5,
  % ------ Hanning und Hammingfenster mit Zeropadding -------------------
  han=hanning(laenge)';				% erzeuge Hanningfenster
  han01=zeropad(han,length(han),laenge+4096);	% ergaenze Hanning vorne und hinten mit 
						% 1024 Nullen
  h_sp(:,1) = shtabs(han01,rate,1,3,'Hanning with even more padded zeros',-150);
  ham=hamming(laenge)';				% erzeuge Hammingfenster
  ham01=zeropad(ham,length(ham),laenge+4096);	% das gleiche mit Hamming
  h_sp(:,2) = shtabs(ham01,rate,2,4,'Hamming with even more padded zeros',-150);
  suptitle('Windowing Effects -- Hanning and Hamming Window with Zero Padding III');
case 6
  h_sp = windemoAdd;
case 7,
  % ------- Fensterung eines Signals mit periodisch fortgesetztem Hann(mm)ing ----------
  rate = rate * 50;
  laenge = laenge * 50;
  t=(0:laenge-1)/rate;				% Zeitachsenvektor 
  w = 40*2*pi*rate/laenge;                      % Winkelfrequenz
  sig=hanning(laenge)' .* sin(w*t);		% Fensterung durch Multiplikation 
						% im Zeitbereich
  tmp_str = sprintf('Hanning-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,1) = shtabs(sig,rate,1,3,tmp_str,-100);
  subplot(h_sp(1,1));
  hold on;                                      % zeichene Hanning in rot zusaetzlich
  plot(1000*t,hanning(laenge)','r')';           % zum Signalplot
  hold off;
  sig=hamming(laenge)' .* sin(w*t);
  tmp_str = sprintf('Hamming-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,2) = shtabs(sig,rate,2,4,tmp_str,-100);
  subplot(h_sp(1,2));
  hold on;                                      % zeichene Hamming in rot zusaetzlich
  plot(1000*t,hamming(laenge)','r')';           % zum Signalplot
  hold off;
  suptitle('Windowing Effects -- Application of Windows to a Signal I');
case 8,
  % ---------------- Fensterung eines Signals mit Hann(mm)ing -----------------------
  rate = rate * 50;
  laenge = laenge * 50;
  pad = laenge*4;
  t1=(0:laenge+pad-1)/rate;			% anderer Zeitachsenvektor 
  w = 40*2*pi*rate/laenge;                      % Winkelfrequenz
  han=hanning(laenge)';				% erzeuge Hanningfenster
  han0=zeropad(han,length(han),laenge+pad);	% ergaenze Hanning vorne und hinten mit 
  sig=han0 .* sin(w*t1);
  tmp_str = sprintf('Hanning-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,1) = shtabs(sig,rate,1,3,tmp_str,-100);
  ham=hamming(laenge)';				% erzeuge Hammingfenster
  ham0=zeropad(ham,length(ham),laenge+pad);	% das gleiche mit Hamming
  sig=ham0 .* sin(w*t1);
  tmp_str = sprintf('Hamming-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,2) = shtabs(sig,rate,2,4,tmp_str,-100);
  subplot(h_sp(1,1));                           % zeichne Hanning
  hold on;                                      % zusaetzlich zum
  plot(1000*t1,han0,'r')';                      % Signalplot
  hold off;
  subplot(h_sp(1,2));                           % genauso Hamming
  hold on;
  plot(1000*t1,ham0,'r')';
  hold off;
  suptitle('Windowing Effects -- Application of Windows to a Signal II');
case 9,
  % ------- Fensterung mit Rechteckfenster --------------------------------
  rate = rate * 50;
  laenge = laenge * 50;
  pad = laenge*4;
  t1=(0:laenge+pad-1)/rate;                     % anderer Zeitachsenvektor 
  w = 40*2*pi*rate/laenge;                      % Winkelfrequenz
  rect=[ zeros(1,pad/2) boxcar(laenge)' zeros(1,pad/2)]; % erzeuge Rechteckfenster
  sig=rect.* sin(w*t1);                         % fenstere
  tmp_str = sprintf('rect-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,1) = shtabs(sig,rate,1,3,tmp_str,-100);
  % ------- Fensterung eines Signals mit Hamming (von voriger Folie) ------
  ham=hamming(laenge)';                         % erzeuge Hammingfenster
  ham0=zeropad(ham,length(ham),laenge+pad);     % das gleiche mit Hamming
  sig=ham0 .* sin(w*t1);
  tmp_str = sprintf('Hamming-windowed sine (%0.0f Hz)',w/(2*pi));
  h_sp(:,2) = shtabs(sig,rate,2,4,tmp_str,-100);
  subplot(h_sp(1,2));                           % add Hamming window
  hold on;                                      % to the plot
  plot(1000*t1,ham0,'r')';
  hold off;
  suptitle('Windowing Effects -- Application of Windows to a Signal III');
end
switch no,
%case {6,7,8},
%  f = w/(2*pi);
%  set(h_sp(2,:),'Xlim',f+[-1000 1000]);         % adjust the frequency axes
otherwise,
  set(h_sp(2,:),'Xlim',xl_f);                   % adjust the frequency axes
end
