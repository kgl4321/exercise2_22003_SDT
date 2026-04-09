
% LOAD DATA

[xkl3, ykl3, ystdkl3] = pldata('modulationDetection2', 'kl', '3', 'group11');
[xkl30, ykl30, ystdkl30] = pldata('modulationDetection2', 'kl', '30', 'group11');
[xkl300, ykl300, ystdkl300] = pldata('modulationDetection2', 'kl', '300', 'group11');

[x3, yjs3, ystdjs3] = pldata('modulationDetection2', 'js', '3', 'group11');
[xjs30, yjs30, ystdjs30] = pldata('modulationDetection2', 'js', '30', 'group11');
[xjs300, yjs300, ystdjs300] = pldata('modulationDetection2', 'js', '300', 'group11');


%% PLOT DATAPOINT FOR ALL THREE BANDWIDTHS TOGETHER

% SUBJECT 1

% Mean value of both measurements (already in 20*log(.) scale)
mean3kl = mean(ykl3);
mean30kl = mean(ykl30);
mean300kl = mean(ykl300);

std3kl = std(ykl3);
std30kl = std(ykl30);
std300kl = std(ykl300);

% Modulation frequency of 10 Hz
x = 10;

figure;
hold on
errorbar(x, mean3kl, std3kl, 'o', 'LineWidth', 3)
errorbar(x, mean30kl, std30kl, 's', 'LineWidth', 3)
errorbar(x, mean300kl, std300kl, '^', 'LineWidth', 3)
legend("3-Hz wide carrier", "30-Hz wide carrier", "300-Hz wide carrier")
% xscale log


% SUBJECT 2
% Mean value of both measurements (already in 20*log(.) scale)
mean3js = mean(yjs3);
mean30js = mean(yjs30);
mean300js = mean(yjs300);

std3js = std(yjs3);
std30js = std(yjs30);
std300js = std(yjs300);

% Modulation frequency of 10 Hz
x = 10;

figure;
hold on
errorbar(x, mean3js, std3js, 'o', 'LineWidth', 3)
errorbar(x, mean30js, std30js, 's', 'LineWidth', 3)
errorbar(x, mean300js, std300js, '^', 'LineWidth', 3)
legend("3-Hz wide carrier", "30-Hz wide carrier", "300-Hz wide carrier")
% xscale log




%% COMPARE WITH DATA FROM FIGURE 4

% data from figure 4

dat = load("data\Dau_data.mat");

fm = dat.fm;

figure;
hold on
plot(fm, dat.data_3Hz, 'o-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_31Hz, 's-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_314Hz, '^-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)

% errorbar(x, mean3kl, std3kl, 'o', 'LineWidth', 3, 'Color', 'green',  'MarkerSize', 10)
% errorbar(x, mean30kl, std30kl, 's', 'LineWidth', 3, 'Color', 'green', 'MarkerSize', 10)
% errorbar(x, mean300kl, std300kl, '^', 'LineWidth', 3, 'Color', 'green', 'MarkerSize', 10)
% 
% errorbar(x, mean3js, std3js, 'o', 'LineWidth', 3, 'Color', 'blue',  'MarkerSize', 10)
% errorbar(x, mean30js, std30js, 's', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 10)
% errorbar(x, mean300js, std300js, '^', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 10)

plot(x, mean3kl, 'o', 'LineWidth', 3, 'Color', 'green',  'MarkerSize', 20)
plot(x, mean30kl, 's', 'LineWidth', 3, 'Color', 'green', 'MarkerSize', 20)
plot(x, mean300kl, '^', 'LineWidth', 3, 'Color', 'green', 'MarkerSize', 20)

plot(x, mean3js, 'o', 'LineWidth', 3, 'Color', 'blue',  'MarkerSize', 20)
plot(x, mean30js, 's', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)
plot(x, mean300js, '^', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)


legend("3-Hz (Dau)", "31-Hz (Dau)", "314-Hz (Dau)", ...
       "3-Hz (KL)", "30-Hz (KL)", "300-Hz (KL)", ...
        "3-Hz (JS)", "30-Hz (JS)", "300-Hz (JS)" ...
        , 'Location', 'northeastoutside')
xlabel("Modulation frequency (Hz)")
ylabel("Modulation depth (dB)")
xscale log
xlim([2.5 110])
ylim([-35 0])
xticks(fm)
xticklabels(string(fm))
set(gca, 'FontSize', 30)



%% RUN AND PLOT RESULTS FROM SIMULATION


% LOWPASSMODEL2 (VIEMEISTER)
[xlp3, ylp3, ystdlp3] = pldata('modulationDetection2', 'lowPassModel2', '3', 'group1');
[xlp30, ylp30, ystdlp30] = pldata('modulationDetection2', 'lowPassModel2', '30', 'group1');
[xlp300, ylp300, ystdlp300] = pldata('modulationDetection2', 'lowPassModel2', '300', 'group1');
[xlp3000, ylp3000, ystdlp3000] = pldata('modulationDetection2', 'lowPassModel2', '3000', 'group1');

%%

xmd2 = unique(xlp3000);
L = length(xmd2);



xdata = [xlp3, xlp30, xlp300, xlp3000];
ydata = [ylp3, ylp30, ylp300, ylp3000];


for bb = 1:4

    gg = 1;

    [~, idx] = sort(xdata(:,bb));
    sortedylp = ydata(idx,bb);

    for ll = 1:L
        
        % fprintf("Loop %d:\n", ll)
        % fprintf("%d\n", sortedylp(gg:2+gg))

        meanylp(ll,bb) = mean(sortedylp(gg:2+gg));
    
        gg = gg+3;
    end
end


figure;
hold on

plot(fm, dat.data_3Hz, 'o-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_31Hz, 's-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_314Hz, '^-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)

plot(xmd2, meanylp(:,1), 'o-', 'LineWidth', 3, 'Color', 'red', 'MarkerSize', 20)
plot(xmd2, meanylp(:,2), 's-', 'LineWidth', 3, 'Color', 'red', 'MarkerSize', 20)
plot(xmd2, meanylp(:,3), '^-', 'LineWidth', 3, 'Color', 'red', 'MarkerSize', 20)
plot(xmd2, meanylp(:,4), 'x-', 'LineWidth', 3, 'Color', 'red', 'MarkerSize', 20)
xscale log
xticks(xmd2)
xticklabels(string(xmd2))
legend("3-Hz (Dau)", "31-Hz (Dau)", "314-Hz (Dau)", ...
        "LP model 3-Hz", "LP model 30-Hz", "LP model 300-Hz", "LP model 3000-Hz", ...
        'Location', 'northeastoutside')
xlabel("Modulation frequency (Hz)")
ylabel("Modulation depth (dB)")
title("Simulation - Low-pass Model")
set(gca, 'FontSize', 30)
xlim([2.5 110])
ylim([-35 0])



%%



% FILTERBANK MODEL (DAU)
[xfb3, yfb3, ystdfb3] = pldata('modulationDetection2', 'ModFilterBankModel', '3', 'group1');
[xfb30, yfb30, ystdfb30] = pldata('modulationDetection2', 'ModFilterBankModel', '30', 'group1');
[xfb300, yfb300, ystdfb300] = pldata('modulationDetection2', 'ModFilterBankModel', '300', 'group1');
[xfb3000, yfb3000, ystdfb3000] = pldata('modulationDetection2', 'ModFilterBankModel', '3000', 'group1');
%%

xdata = [xfb3, xfb30, xfb300, xfb3000];
ydata = [yfb3, yfb30, yfb300, yfb3000];


for bb = 1:4

    gg = 1;

    [~, idx] = sort(xdata(:,bb));
    sortedyfb = ydata(idx,bb);

    for ll = 1:L
        
        % fprintf("Loop %d:\n", ll)
        % fprintf("%d\n", sortedyfb(gg:2+gg))

        meanyfb(ll,bb) = mean(sortedyfb(gg:2+gg));
    
        gg = gg+3;
    end
end


figure;
hold on

plot(fm, dat.data_3Hz, 'o-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_31Hz, 's-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)
plot(fm, dat.data_314Hz, '^-', 'LineWidth', 3, 'Color', 'black', 'MarkerSize', 20)

plot(xmd2, meanyfb(:,1), 'o-', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)
plot(xmd2, meanyfb(:,2), 's-', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)
plot(xmd2, meanyfb(:,3), '^-', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)
plot(xmd2, meanyfb(:,4), 'x-', 'LineWidth', 3, 'Color', 'blue', 'MarkerSize', 20)
xscale log
xticks(xmd2)
xticklabels(string(xmd2))
legend("3-Hz (Dau)", "31-Hz (Dau)", "314-Hz (Dau)", ...
        "FB model 3-Hz", "FB model 30-Hz", "FB model 300-Hz", "FB model 3000-Hz", ...
        'Location', 'northeastoutside')
xlabel("Modulation frequency (Hz)")
ylabel("Modulation depth (dB)")
title("Simulation - Filterbank Model")
set(gca, 'FontSize', 30)
xlim([2.5 110])
ylim([-35 0])
