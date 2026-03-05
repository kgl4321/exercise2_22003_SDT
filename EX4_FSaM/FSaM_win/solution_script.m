
% OBS! Run this line from the data folder (function only searches within
% \Exercises_22003\exercise2_22003_SDT\data EX4

[x1,y1,y1std] = pldata('fletcher', 'eh', 'group1');
[x2,y2,y2std] = pldata('fletcher', 'kl', 'group1');

%%


x = x1;
y = y1;
ystd = y1std;

figure;
plot(log10(x),y, 'o')
ylim([55 70])
hold on
errorbar(log10(x),y,ystd, 'o')
xticks(sort(log10(x)))
xticklabels([sort(x)])
title("sub1")

x = x2;
y = y2;
ystd = y2std;

figure;
plot(log10(x),y, 'o')
ylim([40 70])
hold on
errorbar(log10(x),y,ystd, 'o')
xticks(sort(log10(x)))
xticklabels([sort(x)])
title("sub2")



%%

% K = Ps / N0 * deltaF
sel_val_idx = find(x1 == 800);
Ps = 10^(y1(sel_val_idx)/10);

x = sort(x1);
deltaF = abs(x1(sel_val_idx) - x(end));

N0dB = 40;
N0 = 10^(N0dB/10);

K = Ps / (N0*deltaF);
fprintf("Subject 1 K-value: %.4f\n", K)

% K = Ps / N0 * deltaF
sel_val_idx = find(x2 == 200);
Ps = 10^(y2(sel_val_idx)/10);

x = sort(x2);
deltaF = abs(x2(sel_val_idx) - x(end));

N0dB = 40;
N0 = 10^(N0dB/10);

K = Ps / (N0*deltaF);
fprintf("Subject 2 K-value: %.4f\n", K)


