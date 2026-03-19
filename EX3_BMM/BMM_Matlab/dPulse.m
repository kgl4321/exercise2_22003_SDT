
% dPulse.m - generates pulse vector
%
% Usage: out = dPulse(len, position)
%
% len = output vector length
% position = position of unit pulse (1 = first element of out)
%
% out = output column vector


function out = dPulse(len, position);

out = zeros(len,1);
out(position) = 1;