function y = synchronizationRX(x,fs,len)
    t = [0:fs*len-1]/fs;
    f_of_t = 20+t/16*(20000-20);
    chirp = sin(2*pi*f_of_t.*t)*.5;
    N = length(chirp) + length(x) - 1;
    chirpPad = [zeros(1,2*(N-length(chirp))) chirp];
    xPad = [zeros(2*(N-length(x)),1); x];
    
    corr = fftfilt(xPad,chirpPad(end:-1:1));
    idx = find(corr == max(corr));
    
    y = xPad(idx+1:end);
end