function vBMLD = ECmodel(vFreq,sigmaD,sigmaE)
% ECmodel  calculates the BMLD (N0S0 - N0Spi) according to the EC model
%
% syntax: vBMLD = ECmodel(vFreq, sigmaD, sigmaE)
%
% Calculates the BMLD of a N0S0 and and N0Spi configuration according
% to the EC model (see Eqn. 5.1 of the exercise guide).
%
% input:  vFreq   center frequency of the auditory filter with the
%                 target signal; can be given as a vector (in Hz!)
%         sigmaD  standard deviation of the random jitter in time (in s)
%         sigmaE  standard deviation of the random jitter in amplitude
%
% output: vBMLD   the binaural masking level difference in dB; if vFreq
%                 is a vector, this is also a vector

