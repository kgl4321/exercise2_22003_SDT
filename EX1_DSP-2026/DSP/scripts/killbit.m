function y = killbit(x,anz);
% y = killbit(x,anz) :
% Loescht die in 'anz' gegebene Anzahl Bits des Vektors x und schreibt
% das Ergebnis nach y. Es wird davon ausgegangen, dass das Signal mit 16
% Bit Aufloesung vorliegt.
% Intern wird eine Multiplikation mit 2^(15-anz) durchgefuehrt, gerundet
% und eine Division mit 2^anz ausgefuehrt.
faktor = 2^(15-anz);
y = floor(x * faktor);
y = y / faktor;
