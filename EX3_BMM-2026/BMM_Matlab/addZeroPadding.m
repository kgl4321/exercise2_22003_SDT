function signal = addZeroPadding(signal, t)

if max(t)<1
    fs = length(t)/max(t);
    sample = 1/fs;
    t_zp = (t+sample:sample:1)';
    %t = [t ; t_zp];
    signal = [signal ; zeros(length(t_zp),1)];
end

end