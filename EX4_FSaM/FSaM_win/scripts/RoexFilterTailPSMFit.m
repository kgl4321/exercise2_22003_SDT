% RoexFilterTailPSMFit.m - Fits single parameter roex(p) to experimental notched-noise
% data.
%
% Usage: [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc)
%
% xdata  = column vector of deltaf/fc used in experiment
% thres  = column vector of threshold values at xdata
% NOdB   = spectral density of noise
% fc     = center frequency of filter
%
% p      = fitted slope parameter p of roex(p)
% k      = fitted power spectrum model proportionality constant k
%
% See also: RoexFilter, RoexFilterTailPSM

% Timestamp: 10-03-2004 14:00

function [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc)

x0 = [25,0.5];                          % start with some reasonable values

% create an inline function which has to be minimized:
f = inline('sum( (RoexFilterTailPSM(xdata,N0,fc,x(1),x(2)) - thres).^2)','x','N0','fc','xdata','thres');

% the actual fitting is done by fminsearch:
[x, fval, exitflag] = fminsearch(f,x0,[],N0dB,fc,xdata,thres); % find the minimum
if exitflag > 0,                        % function converged:
  p = x(1);                            % return p
  k = x(2);                         % and k
else                                    % function did not converge
  warning(sprintf('%s: No solution found!',mfilename));
  p = [];                              % warning and return
  k = [];                           % emtpy vectors
end
