function calmixer
% CALMIXER  sets the windows sound mixer to calibrated values
%
% see also SND_PC_INI, SND_MIXER_INFO

% (c) of, 2004 Feb 04
% Last Update: 2004 Feb 05
% Timestamp: <calmixer.m Thu 2004/02/05 14:11:34 OF@OFPC>

dBval = -25;
factor = 10.^(dBval/20);
snd_pc_snd_ini(factor);
