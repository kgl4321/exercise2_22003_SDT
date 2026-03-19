% GAMMATONE FILTER SOLUTION

f1 = 300;
f2 = 500;
f3 = 1200;

fc_vals = [f1 f2 f3];

durImp = 0.05;     % In seconds
fs = 32e3;      % In hz


numF = length(fc_vals);
gArray = [];


for ii = 1:numF

[gArray(:,ii), t] = gammaIR(durImp,fc_vals(ii), fs);

end
%% PLOTS


figure;
plot(t,gArray)


gArray_fft = fft(gArray);
N = length(t);

f = (0:N-1)*(fs/N);
half = 1:floor(N/2);

figure;
plot(f(half), abs(gArray_fft(half,:)))
xlim([0 2000])


%% Analytical signal of the filter banks (find envelope)

env = abs(hilbert(gArray));

figure;
plot(t,gArray)
hold on
plot(t,env)



