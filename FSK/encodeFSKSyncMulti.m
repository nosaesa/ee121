function y = encodeFSKSyncMulti(m,fc,fs,D,bitNum)
    % m is the message to be sent
    % k is the number of bits in the message
    % fc is the carrier frequency (in Hertz)
    % T is the duration of the tone to be transmitted (in seconds)
    % fs is the sampling rate (in Hertz)
    % D is the number of periods of fc to look at
    T = D/fc;
    t = 0:1/fs:T-1/fs;
    y = cos(2*pi*m*(fc+bitNum*30)*t);  
end