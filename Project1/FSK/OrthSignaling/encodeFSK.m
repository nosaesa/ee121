function y = encodeFSK(m,fc,fs)
    % m is the message to be sent
    % fc is the carrier frequency (in Hertz)
    % T is the duration of the tone to be transmitted (in seconds)
    % fs is the sampling rate (in Hertz)
    T = 1/fc;
    t = 0:1/fs:T-1/fs;
    y = cos(2*pi*m*fc*t);  
end