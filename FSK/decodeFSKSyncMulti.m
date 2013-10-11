function b = decodeFSKSyncMulti(x,k,fc,fs,C,D)
    % x is the signal to be decoded, normalized to [-1,1]
    % k is the number of bits in the message
    % T is the duration of the signal to be decoded (in seconds)
    % fc is the carrier frequency (in Hertz)
    % C is the codebook
    % fs is the sampling rate of the signal to be decoded (in Hertz)
    T = D/fc;
    t = 0:1/fs:T-1/fs;
    
    result = C*x';
    
    b = find(result == max(result));
end
