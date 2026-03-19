%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This scripts performs parametric analysis of the model
%%% Basically, it runs a simulations for different input levels controlled
%%% by the parameter U_inputGain. The values are in vector VecSim:
%%% VecSim = [0.01 0.1 0.5 1 1.5 2];
%%% The script runs both with the Whole Cochlea model with only passive
%%% components but also including the non-linear branch.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YourModel   = 'BMM_WholeCochlea';

%% Assign model parameters

mdlWks      = get_param(YourModel, 'ModelWorkspace');


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

%Values in the RLC branch #6
% assignin(mdlWks, 'R_6', ??)
% assignin(mdlWks, 'C_6', ??)
% assignin(mdlWks, 'L_6', 10e-3)
% assignin(mdlWks, 'Ls_6', 33e-3)

%Values in the RLC branch #7
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

%%%% WARNING %%%%
%Run the simulation once the the Whole Cochlea model is completed including
%the non-linear branch with its measuremnt scope (Scope_Measurement_NL)

sim( YourModel )

%% Optional part

%Define the input gain stimulus vector
U_in_vect       = [0.01 0.1 0.5 1 1.5 2];
t               = Scope_Measurement_NL{1}.Values.Time;
MeasurementsNL    = zeros(numel(t), numel(U_in_vect));
% MeasurementsLIN    = zeros(numel(t), numel(U_in_vect));

for ii= 1:length(U_in_vect)
    assignin(mdlWks, 'U_inputGain', U_in_vect(ii))
    sim( YourModel )
    MeasurementsNL(:, ii) = Scope_Measurement_NL{1}.Values.Data;  % Using NL
    % MeasurementsLIN(:, ii) = Scope_Measurement_NL{2}.Values.Data;  % Using LIN
end

%% Plots

% Plot of the Current I_6 frequency response as a function of input gain
figure;
I6_fft_LIN  = PlotSpectrum(MeasurementsLIN, t);
title('Velocity (LIN)')
legend(num2str(U_in_vect'))

% Plot of the normalized Current I_6 frequency response as a function of input gain
figure;
U_in_vect_rep = repmat(U_in_vect, numel(t), 1);
plot(abs(I6_fft_LIN)./U_in_vect_rep);
title('Sensitivity (LIN)')
legend(num2str(U_in_vect'))
set(gca,'xscale','log')
xlim([100 10000])


% Plot of the Current I_6 frequency response as a function of input gain
figure;
I6_fft_NL  = PlotSpectrum(MeasurementsNL, t);
title('Velocity (NL)')
legend(num2str(U_in_vect'))

% Plot of the normalized Current I_6 frequency response as a function of input gain
figure;
U_in_vect_rep = repmat(U_in_vect, numel(t), 1);
plot(abs(I6_fft_NL)./U_in_vect_rep);
title('Sensitivity (NL)')
legend(num2str(U_in_vect'))
set(gca,'xscale','log')
xlim([100 10000])

%%

figure('Color','w')
tiledlayout(2,1)

U_in_vect_rep = repmat(U_in_vect, numel(t), 1);

figure('Color','w','Position',[200 200 700 500])
tiledlayout(2,1)

colors = lines(length(U_in_vect));

nexttile
hold on

I6_fft_LIN = PlotSpectrum(MeasurementsLIN, t);

for k = 1:length(U_in_vect)

    % Velocity (solid)
    plot(abs(I6_fft_LIN(:,k)), ...
        'Color',colors(k,:), ...
        'LineWidth',2.5)

    % Sensitivity (dotted)
    plot(abs(I6_fft_LIN(:,k))./U_in_vect(k), ...
        ':', ...
        'Color',colors(k,:), ...
        'LineWidth',2.5)

end

title('Branch 6 – Linear System','FontSize',14)
ylabel('Magnitude','FontSize',13)

set(gca,...
    'XScale','log',...
    'FontSize',12,...
    'LineWidth',1.4)

xlim([100 10000])
% grid on

lg = legend(num2str(U_in_vect'),'Location','best');
lg.FontSize = 11;
% title(lg,'U_{in}')

nexttile
hold on

I6_fft_NL = PlotSpectrum(MeasurementsNL, t);

for k = 1:length(U_in_vect)

    % Velocity
    plot(abs(I6_fft_NL(:,k)), ...
        'Color',colors(k,:), ...
        'LineWidth',2.5)

    % Sensitivity
    plot(abs(I6_fft_NL(:,k))./U_in_vect(k), ...
        ':', ...
        'Color',colors(k,:), ...
        'LineWidth',2.5)

end

title('Branch 6 – Nonlinear System','FontSize',14)
xlabel('Frequency (Hz)','FontSize',13)
ylabel('Magnitude','FontSize',13)

set(gca,...
    'XScale','log',...
    'FontSize',12,...
    'LineWidth',1.4)

xlim([100 10000])
% grid on

lg = legend(num2str(U_in_vect'),'Location','best');
lg.FontSize = 11;
% title(lg,'U_{in}')


%%

figure;
plot(t,MeasurementsLIN./U_in_vect_rep)
xlim([0 0.01])

figure;
plot(t,MeasurementsNL./U_in_vect_rep)
xlim([0 0.01])


%%

U_in_vect = [0.01 0.1 0.5 1 1.5 2];
Ngain = length(U_in_vect);
max_vals_LIN = zeros(1,Ngain);
max_vals_NL = zeros(1,Ngain);

N = length(t);
dt = t(2)-t(1);
Fs = 1/dt;

f = (0:N-1)*(Fs/N);


f_targets = [0.9e3 1.4e3];
Ntargets = length(f_targets);

vals_LIN = zeros(Ngain,Ntargets);
vals_NL = zeros(Ngain,Ntargets);

for tt = 1:Ntargets
[~, target_idx] = min(abs(f-f_targets(tt)));

% vals_LIN(:,tt) = abs(I6_fft_LIN(target_idx,:))';
vals_NL(:,tt) = abs(I6_fft_NL(target_idx,:))';

end

for ii = 1:Ngain
    % max_vals_LIN(ii) = max(abs(I6_fft_LIN(:,ii)));
    [max_vals_NL(ii), max_idx] = max(abs(I6_fft_NL(:,ii)));
end

% vals_NL(:,Ntargets+1) = max_vals_NL';


% figure;
% plot(U_in_vect, max_vals_LIN, '-o')
% hold on
% plot(U_in_vect, max_vals_NL, '-o')
% legend("Linear", "Non-linear")
% xlabel("Input gain")
% ylabel("Current (velocity)")
% % 
% figure;
% % plot(U_in_vect, vals_LIN, '-o')
% % hold on
% plot(U_in_vect, vals_NL, '-o')
% % legend('LIN: f = 0.9kHz', 'NL: f = 0.9kHz', 'LIN: f = 1.3kHz', 'NL: f = 1.3kHz')
% 


% figure;
% plot(U_in_vect, vals_NL, '-o')
% hold on
% plot(U_in_vect, max_vals_NL, '-o')
% freq_labels = string(f_targets) + " Hz";
% max_label = sprintf("Max value (%d Hz)", max_idx);
% labels = [freq_labels, max_label];
% legend(labels)



figure('Color','w')

plot(U_in_vect, vals_NL, '-o', ...
    'LineWidth',2.5, ...
    'MarkerSize',8)
hold on

plot(U_in_vect, max_vals_NL, '-s', ...
    'LineWidth',2.5, ...
    'MarkerSize',8)

freq_labels = string(f_targets) + " Hz";
max_label = sprintf("Max value (%d Hz)", max_idx);
labels = [freq_labels, max_label];

legend(labels, ...
    'FontSize',12, ...
    'Location','northwest')

xlabel('Input gain','FontSize',14, 'FontWeight', 'bold')
ylabel('Magnitude','FontSize',14, 'FontWeight', 'bold')

set(gca, ...
    'FontSize',13, ...
    'LineWidth',1.5)

% grid on



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Sigspectrum = PlotSpectrum(signal,t)
signal  = addZeroPadding(signal,t); % ensure 1 second of the signal
fs      = length(signal);           % samples of 1 second of the signal
fHz     = (0:1:fs-1)';              % Frequency vector for ploting

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
