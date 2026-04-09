

%% LOAD DATA

figure;
[xkl, ykl, ystdkl] = pldata('modulationDetection1', 'kl', '3000', 'group11');
figure;
[xjs, yjs, ystdjs] = pldata('modulationDetection1', 'js', '3000', 'group11');



%% PLOT ON LOGARITHMIC AXIS



figure;
errorbar(xkl, ykl,-ystdkl,ystdkl,'o', 'Linewidth', 2.5)
yscale log
xscale log
xlabel("Carrier bandwidth (Hz)")
ylabel("Modulation depth at threshold (dB)")
title("Modulation Detection 1 - KL")
xticks([4 8 16 32 64 128 256])
ylim([min(ykl)-5 max(ykl)+1])




figure;
errorbar(xjs, yjs,-ystdjs,ystdjs,'o', 'Linewidth', 2.5)
yscale log
xscale log
xlabel("Carrier bandwidth (Hz)")
ylabel("Modulation depth at threshold (dB)")
title("Modulation Detection 1 - JS")
xticks([4 8 16 32 64 128 256])
ylim([min(yjs)-5 max(yjs)+5])



%% RUN LOW-PASS MODEL AND EXPLORE CUTOFFS TO FIND A TMTF THAT RESMPLES THE ABOVE PLOTS


afc_main('modulationDetection1', 'lowPassModel', '3000', 'group1');
[xsim, ysim, ystdsim] = pldata('modulationDetection1', 'lowPassModel', '3000', 'group1');


%%

figure;
errorbar(xsim, ysim,-ystdsim,ystdsim,'o', 'Linewidth', 2.5)
xscale log
xlabel("Carrier bandwidth (Hz)")
ylabel("Modulation depth at threshold (dB)")
title("Modulation Detection 1 - KL")
xticks([4 8 16 32 64 128 256])
% ylim([min(ysim)-5 max(ysim)+1])


% MODIFY fc parameter in lowPassModel_init script


%%
