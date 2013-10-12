function y = synchronization(x,fs)
    t = [0:fs*2-1]/fs;
    f_of_t = 20+t/16*(20000-20);
    chirp = sin(2*pi*f_of_t.*t)*.5;
    
    corr = conv(x,chirp(end:-1:1));
    idx = find(corr == max(corr));
    
    y = x(idx+1:end);
end