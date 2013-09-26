function y = encodeFSK(m,fc,T,fs)
    % m is the message to be sent
    % fc is the carrier frequency (in Hertz)
    % T is the duration of the tone to be transmitted (in seconds)
    % fs is the sampling rate (in Hertz)
    
    t = 0:T*fs;
    y = cos(2*pi*m*fc*t/fs);  
end