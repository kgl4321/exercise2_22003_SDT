% timeFreqDistribution.m - displays absolute gammatone filterbank output as b/w image
%
% Usage: timeFreqDistribution( in, cfs, fs, range )
%
% in = time/freq input array (different colums are different channels)
% cfs = vector of center frequencies of the channels in erb
% fs = sampling rate in Hz
% range = two element vector for time range in ms, e.g. [0 25]

function timeFreqDistribution( in, cfs, fs, range );

sample_range = round(range/1000*fs+1);

if sample_range(1) < 1
	sample_range(1) = 1;
end

if sample_range(2) > size(in,1)
	sample_range(2) = size(in, 1);
end

pl = -abs(in(sample_range(1):sample_range(2),:));

figure;

imagesc(1000*[0:size(pl,1)-1]/fs, fliplr(cfs), flipud(pl'));

set(gca,'ydir','normal')

tmp = get(gca,'ytick');
str =[];

for idx=1:length(tmp)
	str(idx) =round(erbtofreq(cfs(tmp(idx))));
end

set(gca,'ytickLabel',str);


colormap('gray')

xlabel('Time (ms)')
ylabel('Center frequency (Hz)')
xlim ([0 20])
