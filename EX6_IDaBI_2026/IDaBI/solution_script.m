
%% PART1: JUST NOTICEABLE INTENSITY DIFFERENCE

[x,y,ystd] = pldata('intjnd', 'kl', 'group1');



%%  PART2: TIME-INTENSITY TRADING

[x,y,ystd] = pldata('ildjnd', 'kl', 'group1');





%% PART3: BINAURAL MASKING LEVEL DIFFERENCE (BMLD)


[vFreq, vBMLD, vStd] = plBMLD('kl', 'group1');



%%

vFreq = (50*2*pi):1:(10000*2*pi) ;
sigmaD = 105*10^-6;
sigmaE = 0.25;




out = ECmodel(vFreq,sigmaD,sigmaE);





figure;
plot(vFreq./(2*pi),out, 'LineWidth', 3)
xticks([50 100 200 500 1000 2000 5000 10000])
xticklabels({"50", "100", "200", "500", "1000", "2000", "5000", "10000"})
xscale log
xlabel("\omega_0 / 2\pi (Hz)")
ylabel("B(1,\pi) (dB)")
set(gca,'FontSize', 30)
ylim([0 20])


% xlim([50 10^4])