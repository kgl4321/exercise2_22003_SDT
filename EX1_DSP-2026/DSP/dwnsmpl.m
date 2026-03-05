function [XdownSampled, fsDown] = dwnsmpl(WavFile, N)


[X, fs] = audioread(WavFile);


Nx = length(X);
XdownSampled = zeros(Nx,1);


fsDown = fs/N;
XdownSampled(1:N:end) = X(1:N:end);

end


