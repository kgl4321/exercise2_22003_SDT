function [sigmaD,sigmaE] = ECfit(vFreq,vBMLD)
% ECfit fit EC model description to BMLD data
%
% syntax: [sigmaD,sigmaE] = ECfit(vFreq,vBMLD)
%
% Fits the EC model for the BMLD experiment in the exercise guide
% (rf. Eqn. 5.1) to the data given in the variables vFreq (in Hz) and vBMLD.
% The parameters of the fitted model (sigmaD and sigmaE) are returned.
%
% See also: ECmodel

% (c) of, 2004 Mar 29
% Last Update: 2004 Mar 29
% Timestamp: <ECfit.m Mon 2004/03/29 15:35:02 OF@OFPC>

x0 = [105*10^-6,0.25];                 % [sigmaD, sigmaE] to start with some reasonable values

% create an inline function which has to be minimized:
f = inline('sum( (ECmodel(vFreq,x(1),x(2)) - vBMLD).^2)','x','vFreq','vBMLD');

% the actual fitting is done by fminsearch:
[x, fval, exitflag] = fminsearch(f,x0,[],vFreq,vBMLD); % find the minimum
if exitflag > 0,                        % function converged:
  sigmaD = x(1);                        % return sigmaD
  sigmaE = x(2);                        % and sigmaE
else                                    % function did not converge
  warning('ECfit:NoSolution',sprintf('%s: No solution found!',mfilename));
  sigmaD = [];                          % warning and return
  sigmaE = [];                          % emtpy vectors
end
