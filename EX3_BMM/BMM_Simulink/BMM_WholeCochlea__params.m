
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This scripts assigns a value of 1 to the Input gain element and runs
%%% the passive Whole Cochlea model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YourModel = 'BMM_WholeCochlea';

%% Assign model parameters

mdlWks = get_param(YourModel, 'ModelWorkspace');

%Input gain value
assignin(mdlWks, 'U_inputGain', 1)

% %Values in the RLC branch #1
% assignin(mdlWks, 'R_1', 150)
% assignin(mdlWks, 'C_1', 100e-9)
% assignin(mdlWks, 'L_1', 10e-3)
% assignin(mdlWks, 'Ls_1', 33e-3)

%Values in the RLC branch #2
% assignin(mdlWks, 'R_2', ??)
% assignin(mdlWks, 'C_2', ??)
% assignin(mdlWks, 'L_2', 10e-3)
% assignin(mdlWks, 'Ls_2', 33e-3)

%Values in the RLC branch #3
% ...


C0 = 100e-9;
R = 150;
L = 10e-3;

C = [];

for i = 1:11
    C(i) = C0*exp((i-1) / 2.8854);
end

delta = R * sqrt(C(1)/L);


R = [];

for i = 1:11
    R(i) = delta / sqrt(C(i)/L);
end




for k = 1:11
    assignin(mdlWks, sprintf('R_%d', k), R(k));
    assignin(mdlWks, sprintf('C_%d', k), C(k));
    assignin(mdlWks, sprintf('L_%d', k), L);
    assignin(mdlWks, sprintf('Ls_%d', k),33e-3);
end




%% Run the simulation

sim( YourModel )

%% Make your plots ...

tStim  = Scope_Measurement_LIN{7}.Values.Time;  % Time vector - stimulus
t      = Scope_Measurement_LIN{1}.Values.Time;  % Time vector - output signals

Stim    = Scope_Measurement_LIN{7}.Values.Data;      % Signal 1 - Input stimulus
% Stim    = Stim(1:end-1);
V4      = Scope_Measurement_LIN{2}.Values.Data;      % Signal 1 - Voltage U_i
V6      = Scope_Measurement_LIN{4}.Values.Data;      % Signal 2 - Current I_i   
V8      = Scope_Measurement_LIN{6}.Values.Data;      % Signal 1 - Voltage U_i
I4      = Scope_Measurement_LIN{1}.Values.Data;      % Signal 2 - Current I_i   
I6      = Scope_Measurement_LIN{3}.Values.Data;      % Signal 1 - Voltage U_i
I8      = Scope_Measurement_LIN{5}.Values.Data;      % Signal 2 - Current I_i   

%Plot the time-varying signal
figure
subplot(2,1,1)
plot(t, V4, 'LineWidth', 1.5)
hold on 
plot(t, V6, 'LineWidth', 1.5)
plot(t, V8, 'LineWidth', 1.5)
xlim([0 0.01])
title('Time-varying voltage U_1')

subplot(2,1,2)
plot(t, I4, 'LineWidth', 1.5)
hold on 
plot(t, I6, 'LineWidth', 1.5)
plot(t, I8, 'LineWidth', 1.5)
xlim([0 0.01])
title('Time-varying current I_1')

% ONLY GIVES CORRECT PLOTS IF YOU DONT HAVE NL PART AS WELL ON
% Plot the spectum
figure
subplot(2,1,1)
PlotSpectrum(V4, t)
hold on
PlotSpectrum(V6, t)
PlotSpectrum(V8, t)
title('Spectrum of the voltage U_1')

subplot(2,1,2)
PlotSpectrum(I4, t)
hold on
PlotSpectrum(I6, t)
PlotSpectrum(I8, t)
xlabel('Frequency (Hz)')
title('Spectrum of the current I_1')

%%

figure()
subplot(2,1,1)
hold on

plot(t, V4, 'LineWidth',2.5)
plot(t, V6, 'LineWidth',2.5)
plot(t, V8, 'LineWidth',2.5)

xlim([0 0.01])

% title('Time-varying Voltage','FontSize',14)
ylabel('Amplitude (a.u.)','FontWeight','bold','FontSize',13)

set(gca,...
    'FontSize',12,...
    'LineWidth',1.5)

legend('V4','V6','V8','Location','best','Box','off')

subplot(2,1,2)
hold on

plot(t, I4, 'LineWidth',2.5)
plot(t, I6, 'LineWidth',2.5)
plot(t, I8, 'LineWidth',2.5)

xlim([0 0.01])

% title('Time-varying Current','FontSize',14)
ylabel('Amplitude (a.u.)','FontWeight','bold','FontSize',13)
xlabel('Time (s)','FontWeight','bold','FontSize',13)

set(gca,...
    'FontSize',12,...
    'LineWidth',1.5)

legend('I4','I6','I8','Location','best','Box','off')


%%

figure

tile = tiledlayout(2,1);
tile.TileSpacing = 'compact';
tile.Padding = 'compact';

% -------- Voltage --------
ax1 = nexttile;

PlotSpectrum(V4, t)
hold on
PlotSpectrum(V6, t)
PlotSpectrum(V8, t)

ylabel('|H_V(f)|','FontSize',16, 'FontWeight', 'bold')
legend('V4','V6','V8','FontSize',12,'Location','best')

set(gca,'FontSize',14,...      % tick labels
        'LineWidth',1.2,...    % axis thickness
        'Box','on')

% -------- Current --------
ax2 = nexttile;

PlotSpectrum(I4, t)
hold on
PlotSpectrum(I6, t)
PlotSpectrum(I8, t)

xlabel('Frequency (Hz)','FontSize',16, 'FontWeight', 'bold')
ylabel('|H_I(f)|','FontSize',16, 'FontWeight', 'bold')

legend('I4','I6','I8','FontSize',12,'Location','best')

set(gca,'FontSize',14,...
        'LineWidth',1.2,...
        'Box','on')

linkaxes([ax1 ax2],'x')




%%

N = length(t);
Stim = Stim(1:N);


dt = t(2) - t(1);
Fs = 1/dt;
N  = length(t);

X  = fft(Stim);

Y4 = fft(V4);
Y6 = fft(V6);
Y8 = fft(V8);

eps_val = 1e-12;
H4 = Y4 ./ (X + eps_val);
H6 = Y6 ./ (X + eps_val);
H8 = Y8 ./ (X + eps_val);

f = (0:N-1)*(Fs/N);
half = 1:floor(N/2);

figure

loglog(f(half), abs(H4(half)), 'LineWidth',1.5)
hold on
loglog(f(half), abs(H6(half)), 'LineWidth',1.5)
loglog(f(half), abs(H8(half)), 'LineWidth',1.5)

% grid on
xlabel('Frequency (Hz)')
ylabel('|H_V(f)|')
% title('Voltage Transfer Function')
xlim([1e2 3e3])

legend('V4','V6','V8', 'Location', 'southwest')


%%
% FFT of the currents
Y4I = fft(I4);
Y6I = fft(I6);
Y8I = fft(I8);

% Avoid division by zero
eps_val = 1e-12;

% Transfer functions for current
H4I = Y4I ./ (X + eps_val);
H6I = Y6I ./ (X + eps_val);
H8I = Y8I ./ (X + eps_val);

% Frequency axis
f = (0:N-1)*(Fs/N);
half = 1:floor(N/2);

figure
set(gcf,'Color','w')

t = tiledlayout(2,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';

% -------- Voltage spectrum --------
ax1 = nexttile;

loglog(f(half), abs(H4(half)), 'LineWidth',1.8)
hold on
loglog(f(half), abs(H6(half)), 'LineWidth',1.8)
loglog(f(half), abs(H8(half)), 'LineWidth',1.8)

ylabel('|H_V(f)|','FontSize',16, 'FontWeight', 'bold')
legend('V4','V6','V8','Location','southwest','FontSize',12)

xlim([1e2 3e3])

set(gca,'FontSize',14,...     % tick labels
        'LineWidth',1.3,...   % axis thickness
        'Box','on')

% -------- Current spectrum --------
ax2 = nexttile;

loglog(f(half), abs(H4I(half)), 'LineWidth',1.8)
hold on
loglog(f(half), abs(H6I(half)), 'LineWidth',1.8)
loglog(f(half), abs(H8I(half)), 'LineWidth',1.8)

xlabel('Frequency (Hz)','FontSize',16, 'FontWeight', 'bold')
ylabel('|H_I(f)|','FontSize',16, 'FontWeight', 'bold')

xlim([1e2 3e3])
ylim([1e-5 1e-2])

legend('I4','I6','I8','Location','southwest','FontSize',12)

set(gca,'FontSize',14,...
        'LineWidth',1.3,...
        'Box','on')

% Link x axes
linkaxes([ax1 ax2],'x')



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%


function PlotSpectrum(signal,t)
signal  = addZeroPadding(signal,t); % ensure 1 second of the signal
fs      = length(signal);           % samples of 1 second of the signal
fHz     = 0:1:fs-1;                 % Frequency vector for ploting

Sigspectrum = fft(signal)./length(signal);

plot(repmat(fHz,1,size(Sigspectrum,2)),abs(Sigspectrum), 'LineWidth', 1.5);
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
