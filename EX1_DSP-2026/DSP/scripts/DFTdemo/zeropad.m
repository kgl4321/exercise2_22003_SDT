function y = zeropad(sig,siglen,winlen);
% ZEROPAD - haenge Nullen vor und an Signalvektor (ZEROPADing)
%
%	Y = ZEROPAD(SIG,SIGLEN,WINLEN) liesst aus dem Vektor SIG
%	die ersten SIGLEN Samples aus und ergaenzt sie symmetrisch
% 	mit Nullen zu einem Vektor der Laenge WINLEN.
% 	Y enthaelt den Signalvektor.

% based on ZEROPAD.M from Jan 98, (c) Medizinische Physik, University of Oldenburg
% (c) of, 2003 Dec 02
% Last Update: 2003 Dec 02

if siglen > length(sig),
	error ('Signalausschnitt ist laenger als Signal!');
end;
if siglen > winlen,
	error ('Signalausschnitt ist laenger als Fenster!');
end;


y=[zeros(1,floor((winlen-siglen)/2)) sig(1,1:siglen)];
y=[y zeros(1,winlen-length(y))];

