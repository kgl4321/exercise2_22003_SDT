% RoexFilter.m - Single parameter roex filter (roex(p))
%
% Usage: w = RoexFilter(g,p)
%
% g = column vector of deltaf/fc used in experiment
% p = slope parameter p or roex(p)
%
% w = filter weighting curve at g
%
% See also: RoexFilterPSM, RoexFilterPSMFit

% Timestamp: 08-03-2004 15:09

function w = RoexFilter(g,p)
% insert roex here


% eof