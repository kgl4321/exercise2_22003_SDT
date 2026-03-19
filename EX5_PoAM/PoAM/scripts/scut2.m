% scut2.m - cuts trapezoidal portion of a signal's fourier transform.
%			  Fourier coefficients outside the passband specified by flow
%			  and fhigh are set to zero.
%
%	WARNING CRAPPY SCUT HACK FOR EXERCISE: IT IS NOT FAILSAVE FOR STRANGE INPUTS
%
% Usage: cut = scut2(in,flow,fhigh,ftrans,fs)
%
% in     = input column vector containing a signal's discrete fourier transform
% flow   = lower cutoff frequency in Hz
% fhigh  = upper cutoff frequency in Hz 
% ftrans = transition width in Hz 
% fs     = sampling rate in Hz 
%
% cut    = output vector

function cut = scut2(in,flow,fhigh,ftrans,fs);

if (size(in,2) > 1)
	error('input has to be column vector');
end

if ( ftrans < 0 )
	ftrans = 0;
end

len = length(in);
flowZero = round((flow-ftrans)*len/fs);
fhighZero = round((fhigh+ftrans)*len/fs);
flow = round(flow*len/fs);
fhigh = round(fhigh*len/fs);

cut = zeros(len,1);
cut(flow+1:fhigh+1) = in(flow+1:fhigh+1);

ramplow = [];
ramphigh = [];

if ( flowZero < 0 )
	flowZero = 0;
end

% there's some redundancy but we may want to have different slopes sometime
if ( flow-flowZero > 0 )
	ramplow = [1:flow-flowZero]'/(flow-flowZero+1);
end

if ( fhighZero-fhigh > 0 )
	ramphigh = [fhighZero-fhigh:-1:1]'/(fhighZero-fhigh+1);
end

if ~isempty(ramplow)
	cut(flow-length(ramplow)+1:flow) = ramplow.*in(flow-length(ramplow)+1:flow);
end

if ~isempty(ramphigh)
	cut(fhigh+2:fhigh+2+length(ramphigh)-1) = ramphigh.*in(fhigh+2:fhigh+2+length(ramphigh)-1);
end


% HACK: if lowpass ( flow = 0) index would be greater than len (len +1)
if flow == 0
	flow = 1;
end

cut(len-fhigh+1:len-flow+1) = in(len-fhigh+1:len-flow+1);

if ~isempty(ramplow)
	cut(len-flow+2:len-flow+2+length(ramplow)-1) = flipud(ramplow).*in(len-flow+2:len-flow+2+length(ramplow)-1);
end

if ~isempty(ramphigh)
	cut(len-fhigh-length(ramphigh)+1:len-fhigh) = flipud(ramphigh).*in(len-fhigh-length(ramphigh)+1:len-fhigh);
end
