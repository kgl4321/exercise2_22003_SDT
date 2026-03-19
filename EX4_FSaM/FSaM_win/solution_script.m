
clear
clc

cd("C:\Users\kgl07\OneDrive\Skrivebord\exercises_22003\exercise2_22003_SDT\EX4_FSaM\FSaM_win")

startup

% OBS! Run this line from the data folder (function only searches within
% \Exercises_22003\exercise2_22003_SDT\data EX4
cd("C:\Users\kgl07\OneDrive\Skrivebord\exercises_22003\exercise2_22003_SDT\data EX4")

[x1_fletch,y1_fletch,y1std_fletch] = pldata('fletcher', 'eh', 'group1');
figure;
[x2_fletch,y2_fletch,y2std_fletch] = pldata('fletcher', 'kl', 'group1');

%%



% [B,I] = sort(x1_fletch);
% y = y1_fletch(I);
% ystd = y1std_fletch(I);

figure
set(gcf,'Color','w')

t = tiledlayout(1,2);
t.TileSpacing = 'compact';
t.Padding = 'compact';

% --- Subject 1 ---
ax1 = nexttile;
errorbar(log10(x1_fletch),y1_fletch,y1std_fletch,'o','LineWidth',3,'MarkerSize',6)
ylim([50 72])
xticks(log10(sort(x1_fletch)))
xticklabels(string(sort(x1_fletch)))
xlabel('Noise bandwidth in Hertz (\Deltaf)')
ylabel('P_s (dB SPL)')
title('Subject 1')

% --- Subject 2 ---
ax2 = nexttile;
errorbar(log10(x2_fletch),y2_fletch,y2std_fletch,'o','LineWidth',3,'MarkerSize',6)
ylim([50 72])
xticks(log10(sort(x2_fletch)))
xticklabels(string(sort(x2_fletch)))
xlabel('Noise bandwidth in Hertz (\Deltaf)')
title('Subject 2')

% Make axes identical
linkaxes([ax1 ax2],'xy')

% Paper formatting
set([ax1 ax2],'FontSize',25,'LineWidth',1)

% 
% folderName = "plots\";
% saveDir = "C:\Users\kgl07\OneDrive\Skrivebord\exercises_22003\exercise2_22003_SDT\EX4_FSaM\FSaM_win\";
% 
% if ~exist(saveDir + folderName, 'dir')
%     mkdir(saveDir + folderName)
% end
% 
% 
% saveas(gcf,saveDir + folderName + "measurements_Fletcher_plot.png")

%%

% K = Ps / N0 * deltaF
deltaF = 800;   % Critical bandwidth

sel_val_idx = x1_fletch == deltaF; 
Ps = 10^(y1_fletch(sel_val_idx)/10);


N0dB = 40;
N0 = 10^(N0dB/10);

K = Ps / (N0*deltaF);
fprintf("Subject 1 K-value: %.4f\n", K)

% K = Ps / N0 * deltaF
deltaF = 400;   % Critical bandwidth

sel_val_idx = x2_fletch == deltaF;
Ps = 10^(y2_fletch(sel_val_idx)/10);


N0dB = 40;
N0 = 10^(N0dB/10);

K = Ps / (N0*deltaF);
fprintf("Subject 2 K-value: %.4f\n", K)



%% NOTCHED-NOISE EXPERIMENT

cd("C:\Users\kgl07\OneDrive\Skrivebord\exercises_22003\exercise2_22003_SDT\data EX4")
[x1_nn,y1_nn,y1std_nn] = pldata('notchedNoise', 'eh', 'group1');
figure;
[x2_nn,y2_nn,y2std_nn] = pldata('notchedNoise', 'kl', 'group1');


% I tried to plot the data points on a linear scale to see if the points
% approximated a rounded exponential filter (which is does when the
% log-scaled plot is flat for the narrow notched measurements).
y1Test = 10.^(y1_nn/10);
[B ,I] = sort(x1_nn);
figure;
plot(B,y1Test(I), '-o')


y2Test = 10.^(y2_nn/10);
[B ,I] = sort(x2_nn);
figure;
plot(B,y2Test(I), '-o')

%%

figure
set(gcf,'Color','w')

t = tiledlayout(1,2);
t.TileSpacing = 'compact';
t.Padding = 'compact';

% --- Subject 1 ---
ax1 = nexttile;
errorbar(x1_nn,y1_nn,y1std_nn,'o','LineWidth',3,'MarkerSize',6)
% ylim([50 72])
% xticks(sort(x1_nn))
% xticklabels(string(sort(x1_nn)))
xlabel("Relative Notch Width (\Deltaf/f_c)")
ylabel('P_s (dB SPL)')
title('Subject 1')

% --- Subject 2 ---
ax2 = nexttile;
errorbar(x2_nn,y2_nn,y2std_nn,'o','LineWidth',3,'MarkerSize',6)
% ylim([50 72])
% xticks(sort(x2_nn))
% xticklabels(string(sort(x2_nn)))
xlabel("Relative Notch Width (\Deltaf/f_c)")
title('Subject 2')

% Make axes identical
linkaxes([ax1 ax2],'xy')

% Paper formatting
set([ax1 ax2],'FontSize',25,'LineWidth',1)


% folderName = "plots\";
% saveDir = "C:\Users\kgl07\OneDrive\Skrivebord\exercises_22003\exercise2_22003_SDT\EX4_FSaM\FSaM_win\";
% 
% if ~exist(saveDir + folderName, 'dir')
%     mkdir(saveDir + folderName)
% end
% 
% 
% saveas(gcf,saveDir + folderName + "data_notchednoise.png")



%% FIT AND PLOT THRESHOLD PREDICTIONS FOR NOTCHED NOISE EXPERIMENT

subs_data = cell(2,1);

subs_data{1} = [x1_nn,y1_nn,y1std_nn, x1_fletch,y1_fletch,y1std_fletch];
subs_data{2} = [x2_nn,y2_nn,y2std_nn, x2_fletch,y2_fletch,y2std_fletch];

sel_sub = 1;

% g = column vector of deltaf/fc used in experiment
gn = [0 0.05 0.1 0.2 0.3 0.4]';
N0dB = 40;
fc = 2e3;   % Central frequency of target tone in Hz
thres = subs_data{sel_sub}(:,2);
xdata = subs_data{sel_sub}(:,1);


[p, k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc,"notchednoise");
% fprintf("K value: %s\n", num2str(k))


pw = RoexFilterTailPSM(gn,N0dB,fc,p,k,"notchednoise");
% fprintf("NN: %s\n",string(pw))

[~,I] = sort(xdata);

sorted_y_nn = subs_data{sel_sub}(:,2);
sorted_y_nn = sorted_y_nn(I);

sorted_ystd_nn = subs_data{sel_sub}(:,3);
sorted_ystd_nn = sorted_ystd_nn(I);


%%
figure
set(gcf,'Color','w')

t = tiledlayout(1,2);
t.TileSpacing = 'compact';
t.Padding = 'compact';

ax = gobjects(2,1);   % store axes handles

for sel_sub = 1:2

    ax(sel_sub) = nexttile;
    hold on

    thres = subs_data{sel_sub}(:,2);
    xdata = subs_data{sel_sub}(:,1);

    [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc, "notchednoise");
    pw = RoexFilterTailPSM(gn,N0dB,fc,p,k, "notchednoise");

    [~,I] = sort(xdata);

    sorted_y_nn = subs_data{sel_sub}(:,2);
    sorted_y_nn = sorted_y_nn(I);

    sorted_ystd_nn = subs_data{sel_sub}(:,3);
    sorted_ystd_nn = sorted_ystd_nn(I);

    errorbar(gn,sorted_y_nn,sorted_ystd_nn,'o','LineWidth',3,'MarkerSize',6)
    plot(gn,pw,'-s','LineWidth',3,'MarkerSize',6)

    title(sprintf("Subject %d",sel_sub))
    set(ax(sel_sub),'FontSize',25,'LineWidth',1)

    xlabel("Relative Notch Width (\Deltaf/f_c)")
    legend(["Empirical data", "Prediction"], 'Location', 'best')


end

linkaxes(ax,'xy')   % link both x and y axes
ylabel(t,"P_s (dB SPL)", 'FontSize',25)


% if ~exist(saveDir + folderName, 'dir')
%     mkdir(saveDir + folderName)
% end
% 
% filename = "predicted_thresholds_notched.png";
% saveas(gcf,saveDir + folderName + filename)



%%



w = RoexFilter(gn,p);   % Filter weights for Roex

% wdB = 20*log10(w);
figure;
plot(gn,w, '-o')
hold on
plot(-gn,w, '-o')
title("Rounded Exponential Filter (Notched Noise)")


% Use the values for p and k you calculated from the
% notched-noise data to predict the data obtained earlier
% in the Fletcher experiment.


%%
figure;
w_array = [];

g_w = linspace(0,0.4,1000)';

for sel_sub = 1:1

    hold on
    thres = subs_data{sel_sub}(:,2);
    xdata = subs_data{sel_sub}(:,1);


    [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc, "notchednoise");
    pw = RoexFilterTailPSM(g_w,N0dB,fc,p,k, "notchednoise");
    w = RoexFilter(g_w,p);

    plot(g_w,w, '-')
    plot(-g_w,w, '-')
   
end

% title("Rounded Exponential Filter (Notched Noise)")


%%
% 
% % SWITCH THE EQUATION IN FILE 'RoexFilterTailPSM.m' TO FLETCHER'S
% pwFletch = RoexFilterTailPSM(gn,N0dB,fc,p,k);
% 
% [B,I] = sort(subs_data{sel_sub}(:,4));
% sorted_y_fletch = subs_data{sel_sub}(:,5);
% sorted_y_fletch = sorted_y_fletch(I);
% 
% sorted_ystd_fletch = subs_data{sel_sub}(:,6);
% sorted_ystd_fletch = sorted_ystd_fletch(I);
% 
% figure;
% % errorbar(y1_fletch,y1std_fletch,'o','LineWidth',3,'MarkerSize',6)
% errorbar(log10(B), sorted_y_fletch,sorted_ystd_fletch,'o','LineWidth',3,'MarkerSize',6)
% hold on
% plot(log10(B), pwFletch, '-s', 'LineWidth',3,'MarkerSize',6)
% xticks(log10(B))
% xticklabels(string(sort(B)))
% xlabel("Noise bandwidth in Hertz (\Deltaf)")
% ylabel("P_s (dB SPL)")
% legend(["Empirical data", "Prediction"], 'Location', 'best')
% title(sprintf("Subject %s", num2str(sel_sub)))
% set(gcf, 'FontSize', 25)
% 
% 
% % if ~exist(saveDir + folderName, 'dir')
% %     mkdir(saveDir + folderName)
% % end
% % 
% % filename = "prediction_fletchers.png";
% % saveas(gcf,saveDir + folderName + filename)


%%


% SWITCH THE EQUATION IN FILE 'RoexFilterTailPSM.m' TO FLETCHER'S
pwFletch = RoexFilterTailPSM(gn,N0dB,fc,p,k,"fletcher");

[B,I] = sort(subs_data{sel_sub}(:,4));
sorted_y_fletch = subs_data{sel_sub}(:,5);
sorted_y_fletch = sorted_y_fletch(I);

sorted_ystd_fletch = subs_data{sel_sub}(:,6);
sorted_ystd_fletch = sorted_ystd_fletch(I);


figure
set(gcf,'Color','w')

x = log10(B);

errorbar(x, sorted_y_fletch, sorted_ystd_fletch,'o','LineWidth',2,'MarkerSize',8,'CapSize',8)
hold on
plot(x, pwFletch, '-s', 'LineWidth',2,'MarkerSize',8)

xticks(x)
xticklabels(string(B))   % show actual bandwidth values
ylim([50 72])

xlabel("Noise bandwidth \Deltaf (Hz)")
ylabel("P_s (dB SPL)")

legend(["Empirical data","Model prediction"],'Location','best')
title(sprintf("Subject %d", sel_sub))
set(gca,'FontSize',25)



% if ~exist(saveDir + folderName, 'dir')
%     mkdir(saveDir + folderName)
% end
% 
% filename = sprintf("prediction_fletchers%s.png",num2str(sel_sub));
% saveas(gcf,saveDir + folderName + filename)

%%

figure
set(gcf,'Color','w')

t = tiledlayout(1,2);
t.TileSpacing = 'compact';
t.Padding = 'compact';

ax = gobjects(2,1);   % store axes handles

for sel_sub = 1:2

    ax(sel_sub) = nexttile;
    hold on

    thres = subs_data{sel_sub}(:,2);
    xdata = subs_data{sel_sub}(:,1);

    [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc, "notchednoise");
    pw = RoexFilterTailPSM(gn,N0dB,fc,p,k, "notchednoise");
    
    fprintf("K value subject %d: %s\n", sel_sub, num2str(k))
    fprintf("p value subject %d: %s\n", sel_sub, num2str(p))

    pwFletch = RoexFilterTailPSM(gn,N0dB,fc,p,k,"fletcher");

    [B,I] = sort(subs_data{sel_sub}(:,4));
    sorted_y_fletch = subs_data{sel_sub}(:,5);
    sorted_y_fletch = sorted_y_fletch(I);
    
    sorted_ystd_fletch = subs_data{sel_sub}(:,6);
    sorted_ystd_fletch = sorted_ystd_fletch(I);
    
    
    x = log10(B);
    
    errorbar(x, sorted_y_fletch, sorted_ystd_fletch,'o','LineWidth',2,'MarkerSize',8,'CapSize',8)
    hold on
    plot(x, pwFletch, '-s', 'LineWidth',2,'MarkerSize',8)
    ylim([50 72])

    

    title(sprintf("Subject %d",sel_sub))
    set(ax(sel_sub),'FontSize',25)

    xticks(x)
    xticklabels(string(B))   % show actual bandwidth values
    xlabel("Noise bandwidth \Deltaf (Hz)")
    legend(["Empirical data", "Prediction"], 'Location', 'best')

end

linkaxes(ax,'xy')   % link both x and y axes
ylabel(t,"P_s (dB SPL)", 'FontSize',25)


% 
% if ~exist(saveDir + folderName, 'dir')
%     mkdir(saveDir + folderName)
% end
% 
% filename = "fletcher_predictions.png";
% saveas(gcf,saveDir + folderName + filename)


%% ERB COMPARISONS

for sel_sub = 1:2


    thres = subs_data{sel_sub}(:,2);
    xdata = subs_data{sel_sub}(:,1);

    [p,k] = RoexFilterTailPSMFit(xdata,thres,N0dB,fc, "notchednoise");

    ERB_roex = 4*fc / p;
    ERB_psycho = 24.7 + 0.108*fc;
    
    fprintf("Subject %s ERB roex: %s\n", num2str(sel_sub), num2str(ERB_roex))
    fprintf("Subject %s ERB psycho: %s\n",num2str(sel_sub), num2str(ERB_psycho))
end


