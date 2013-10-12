function y = synchronizationTX(x,fs)
    t = [0:fs*2-1]/fs;
    f_of_t = 20+t/16*(20000-20);
    chirp = sin(2*pi*f_of_t.*t)*.5;
    
    y = [chirp x];
end