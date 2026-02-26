% timeFreqDistributionWaterfall.m - displays absolute gammatone filterbank output as waterfall
%
% Usage: timeFreqDistributionWaterfall( in, cfs, fs, range )
%
% in = time/freq input array (different colums are different channels)  
% cfs = vector of center frequencies of the channels in erb
% fs = sampling rate in Hz
% range = two element vector for time range in ms, e.g. [0 25]

function timeFreqDistributionWaterfall( in, cfs, fs, range );

sample_range = round(range/1000*fs+1);

if sample_range(1) < 1
	sample_range(1) = 1;
end

if sample_range(2) > size(in,1)
	sample_range(2) = size(in, 1);
end

pl = abs(in(sample_range(1):sample_range(2),:));

figure;

waterfall(1000*[0:size(pl,1)-1]/fs, (1:length(cfs)), flipud(pl'));


tmp = get(gca,'ytick');
tmp(1)=1;
str =[];

for idx=1:length(tmp)
	str(idx) =round(erbtofreq(cfs(tmp(idx))));
end

set(gca,'ytickLabel',flip(str));
grid off;

set(gca,'ydir','reverse');
colormap(zeros(256,3))
view(gca,[-0.3 56.4]);
xlabel('Time (ms)')
ylabel('Frequency (Hz)')

