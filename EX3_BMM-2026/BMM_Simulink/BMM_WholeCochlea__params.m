
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This scripts assigns a value of 1 to the Input gain element and runs
%%% the passive Whole Cochlea model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YourModel = 'BMM_WholeCochlea';

%% Assign model parameters

mdlWks = get_param(YourModel, 'ModelWorkspace');

%Input gain value
assignin(mdlWks, 'U_inputGain', 1)

%Values in the RLC branch #1
assignin(mdlWks, 'R_1', 150)
assignin(mdlWks, 'C_1', 100e-9)
assignin(mdlWks, 'L_1', 10e-3)
assignin(mdlWks, 'Ls_1', 33e-3)

%Values in the RLC branch #2
assignin(mdlWks, 'R_2', R_values(2))
assignin(mdlWks, 'C_2', C_values(2))
assignin(mdlWks, 'L_2', 10e-3)
assignin(mdlWks, 'Ls_2', 33e-3)

%Values in the RLC branch #3
assignin(mdlWks, 'R_2', R_values(3))
assignin(mdlWks, 'C_2', C_values(3))
assignin(mdlWks, 'L_2', 10e-3)
assignin(mdlWks, 'Ls_2', 33e-3)

%Values in the RLC branch #4
assignin(mdlWks, 'R_3', R_values(4))
assignin(mdlWks, 'C_3', C_values(4))
assignin(mdlWks, 'L_3', 10e-3)
assignin(mdlWks, 'Ls_3', 33e-3)
%Values in the RLC branch #5
assignin(mdlWks, 'R_5', R_values(5))
assignin(mdlWks, 'C_5', C_values(5))
assignin(mdlWks, 'L_5', 10e-3)
assignin(mdlWks, 'Ls_5', 33e-3)

%Values in the RLC branch #6
assignin(mdlWks, 'R_6', R_values(6))
assignin(mdlWks, 'C_6', C_values(6))
assignin(mdlWks, 'L_6', 10e-3)
assignin(mdlWks, 'Ls_6', 33e-3)

%Values in the RLC branch #7
assignin(mdlWks, 'R_7', R_values(7))
assignin(mdlWks, 'C_7', C_values(7))
assignin(mdlWks, 'L_7', 10e-3)
assignin(mdlWks, 'Ls_7', 33e-3)

%Values in the RLC branch #8
assignin(mdlWks, 'R_8', R_values(8))
assignin(mdlWks, 'C_8', C_values(8))
assignin(mdlWks, 'L_8', 10e-3)
assignin(mdlWks, 'Ls_8', 33e-3)

%Values in the RLC branch #9
assignin(mdlWks, 'R_9', R_values(9))
assignin(mdlWks, 'C_9', C_values(9))
assignin(mdlWks, 'L_9', 10e-3)
assignin(mdlWks, 'Ls_9', 33e-3)

%Values in the RLC branch #10
assignin(mdlWks, 'R_10', R_values(10))
assignin(mdlWks, 'C_10', C_values(10))
assignin(mdlWks, 'L_10', 10e-3)
assignin(mdlWks, 'Ls_10', 33e-3)

%Values in the RLC branch #11
assignin(mdlWks, 'R_11', R_values(11))
assignin(mdlWks, 'C_11', C_values(11))
assignin(mdlWks, 'L_11', 10e-3)
assignin(mdlWks, 'Ls_11', 33e-3)

%Values in the RLC branch #3
% ...

%% Run the simulation

sim( YourModel )

%% Make your plots ...

%% Example how to work with the signals from the scope

%branch 4
%t_stim_4  = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - stimulus
t_V0_4    = Scope_Measurement_LIN_Branch4{2}.Values.Time;  % Time vector - Voltage U_i
t_I0_4    = Scope_Measurement_LIN_Branch4{1}.Values.Time;  % Time vector - Current I_i

%Nsignals = Scope_Measurement_LIN_Branch4.numElements;      % Number of signals you get

%Stim_4    = Scope_Measurement_LIN{1}.Values.Data;      % Signal 1 - Input stimulus
V0_4      = Scope_Measurement_LIN_Branch4{2}.Values.Data;      % Signal 1 - Voltage U_i
I0_4      = Scope_Measurement_LIN_Branch4{1}.Values.Data;      % Signal 2 - Current I_i   

%Plot the time-varying signal
figure('Name','Branch4_time','NumberTitle','off')
subplot(2,1,1)
plot(t_V0_4, V0_4)
xlim([0 t_V0_4(end)])
title('Time-varying voltage U_1')

subplot(2,1,2)
plot(t_I0_4, I0_4)
xlim([0 t_I0_4(end)])
xlabel('time (s)')
title('Time-varying current I_1')

% Plot the spectum
figure('Name','Branch4_spec','NumberTitle','off')
subplot(2,1,1)
PlotSpectrum(V0_4, t_V0_4)
title('Spectrum of the voltage U_1')

subplot(2,1,2)
PlotSpectrum(I0_4,t_I0_4)
xlabel('Frequency (Hz)')
title('Spectrum of the current I_1')

%branch6
%t_stim_4  = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - stimulus
t_V0_6    = Scope_Measurement_LIN_Branch6{2}.Values.Time;  % Time vector - Voltage U_i
t_I0_6    = Scope_Measurement_LIN_Branch6{1}.Values.Time;  % Time vector - Current I_i

%Nsignals = Scope_Measurement_LIN.numElements;      % Number of signals you get

%Stim_4    = Scope_Measurement_LIN{1}.Values.Data;      % Signal 1 - Input stimulus
V0_6      = Scope_Measurement_LIN_Branch6{2}.Values.Data;      % Signal 1 - Voltage U_i
I0_6      = Scope_Measurement_LIN_Branch6{1}.Values.Data;      % Signal 2 - Current I_i   

%Plot the time-varying signal
figure('Name','Branch6_time','NumberTitle','off')
subplot(2,1,1)
plot(t_V0_6, V0_6)
xlim([0 t_V0_6(end)])
title('Time-varying voltage U_1')

subplot(2,1,2)
plot(t_I0_6, I0_6)
xlim([0 t_I0_6(end)])
xlabel('time (s)')
title('Time-varying current I_1')

% Plot the spectum
figure('Name','Branch6_spec','NumberTitle','off')
subplot(2,1,1)
PlotSpectrum(V0_6, t_V0_6)
title('Spectrum of the voltage U_1')

subplot(2,1,2)
PlotSpectrum(I0_6,t_I0_6)
xlabel('Frequency (Hz)')
title('Spectrum of the current I_1')

%branch 8
%t_stim_4  = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - stimulus
t_V0_8    = Scope_Measurement_LIN_Branch4{2}.Values.Time;  % Time vector - Voltage U_i
t_I0_8    = Scope_Measurement_LIN_Branch4{1}.Values.Time;  % Time vector - Current I_i

%Nsignals = Scope_Measurement_LIN.numElements;      % Number of signals you get

%Stim_4    = Scope_Measurement_LIN{1}.Values.Data;      % Signal 1 - Input stimulus
V0_8      = Scope_Measurement_LIN_Branch4{2}.Values.Data;      % Signal 1 - Voltage U_i
I0_8      = Scope_Measurement_LIN_Branch4{1}.Values.Data;      % Signal 2 - Current I_i   

%Plot the time-varying signal
figure('Name','Branch8_time','NumberTitle','off')
subplot(2,1,1)
plot(t_V0_8, V0_8)
xlim([0 t_V0_8(end)])

title('Time-varying voltage U_1')

subplot(2,1,2)
plot(t_I0_8, I0_8)
xlim([0 t_I0_8(end)])
xlabel('time (s)')
title('Time-varying current I_1')

% Plot the spectum
figure('Name','Branch8_spec','NumberTitle','off')
subplot(2,1,1)
PlotSpectrum(V0_8, t_V0_8)
title('Spectrum of the voltage U_1')

subplot(2,1,2)
PlotSpectrum(I0_8,t_I0_8)
xlabel('Frequency (Hz)')
title('Spectrum of the current I_1')

%% Plot voltage transfer function (ikke rigtig)

%t_stim_  = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - stimulus
t_Vin    = Scope_Measurement_LIN_Uin{1}.Values.Time;  % Time vector - Voltage U_i

%Stim_    = Scope_Measurement_LIN{1}.Values.Data;      % Signal 1 - Input stimulus
Vin      = Scope_Measurement_LIN_Uin{1}.Values.Data;      % Signal 1 - Voltage U_i 

Vin = Vin(1:end-1);
Vtf_4 = V0_4./ Vin;
Vtf_6 = V0_6 ./ Vin;  % Calculate voltage transfer function for branch 6
Vtf_8 = V0_8 ./ Vin;  % Calculate voltage transfer function for branch 8

%plot the transferfunctions in spectrum
% Plot transfer functions (magnitude spectra) for branches 4,6,8
figure('Name','Branch_TF_spec','NumberTitle','off')

subplot(3,1,1)
PlotSpectrum(Vtf_4, t_V0_4)
title('Magnitude spectrum of V_{out}/V_{in} - Branch 4')
set(gca,'yscale','log')

subplot(3,1,2)
PlotSpectrum(Vtf_6, t_V0_6)
title('Magnitude spectrum of V_{out}/V_{in} - Branch 6')

subplot(3,1,3)
PlotSpectrum(Vtf_8, t_V0_8)
title('Magnitude spectrum of V_{out}/V_{in} - Branch 8')
xlabel('Frequency (Hz)')
%Noget galt, det duer slet ikke


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
