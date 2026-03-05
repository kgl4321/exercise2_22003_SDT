function sigQuantized = quantization(y, R, b)


stepSize = R / (2^b - 1);
sigDelta = y ./ stepSize;


Lmax = R/2;
Lmin = -Lmax;

sigRound = floor(sigDelta + 1/2);
sigQuantized = sigRound * stepSize;

sigQuantized(sigQuantized > Lmax) = Lmax;
sigQuantized(sigQuantized < Lmin) = Lmin;


end




%% ANSWERS TO QUESTIONS

%  Is there an optimal way to select 𝑅 given
% some input signal? Is it in practice always possible to
% use this optimal 𝑅?

% YES USE MAX AND MIN OF Y SIGNAL




% POINT OF THIS EXERCISE -> WHEN YOU GAIN A SIGNAL OUTSIDE THE DYNAMIC
% RANGE OF QUANTIZER YOU WILL OBSERVE CLIPPING.