
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This scripts assigns a value of 1 to the Input gain element and runs
%%% the passive Single Element Cochlea model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YourModel = 'BMM_SingleElement';

%% Assign model parameters

mdlWks = get_param(YourModel, 'ModelWorkspace');

%Input gain value
assignin(mdlWks, 'U_inputGain', 1)

%Values in the RLC branch #1
assignin(mdlWks, 'R_1', 150)
assignin(mdlWks, 'C_1', 100e-9)
assignin(mdlWks, 'L_1', 10e-3)
assignin(mdlWks, 'Ls_1', 33e-3)

%% Run the simulation

sim( YourModel )

%% Example how to work with the signals from the scope

t_stim  = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - stimulus
t_V0    = Scope_Measurement_LIN{2}.Values.Time;  % Time vector - Voltage U_i
t_I0    = Scope_Measurement_LIN{3}.Values.Time;  % Time vector - Current I_i

Nsignals = Scope_Measurement_LIN.numElements;      % Number of signals you get

Stim    = Scope_Measurement_LIN{1}.Values.Data;      % Signal 1 - Input stimulus
V0      = Scope_Measurement_LIN{2}.Values.Data;      % Signal 1 - Voltage U_i
I0      = Scope_Measurement_LIN{3}.Values.Data;      % Signal 2 - Current I_i   

%Plot the time-varying signal
figure
subplot(2,1,1)
plot(t_V0, V0)
xlim([0 t_V0(end)])
title('Time-varying voltage U_1')

subplot(2,1,2)
plot(t_I0, I0)
xlim([0 t_I0(end)])
xlabel('time (s)')
title('Time-varying current I_1')

% Plot the spectum
figure
subplot(2,1,1)
PlotSpectrum(V0, t_V0)
title('Spectrum of the voltage U_1')

subplot(2,1,2)
PlotSpectrum(I0,t_I0)
xlabel('Frequency (Hz)')
title('Spectrum of the current I_1')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%


function PlotSpectrum(signal,t)
signal  = addZeroPadding(signal,t); % ensure 1 second of the signal
fs      = length(signal);           % samples of 1 second of the signal
fHz     = 0:1:fs-1;                 % Frequency vector for ploting

Sigspectrum = fft(signal)./length(signal);

plot(repmat(fHz,1,size(Sigspectrum,2)),abs(Sigspectrum));
xlim ([100 10000])
set(gca,'xscale','log')
end


function signal = addZeroPadding(signal, t)

if max(t)<1
    fs = length(t)/max(t);
    sample = 1/fs;
    t_zp = (t+sample:sample:1)';
    %t = [t ; t_zp];
    signal = [signal ; zeros(length(t_zp),1)];
end

end
