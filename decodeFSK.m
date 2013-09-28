function b = decodeFSK(x,k,fc,fs)
    % x is the signal to be decoded, normalized to [-1,1]
    % k is the number of bits in the message
    % T is the duration of the signal to be decoded (in seconds)
    % fc is the carrier frequency (in Hertz)
    % fs is the sampling rate of the signal to be decoded (in Hertz)
    T = 1/fc;
    t = 0:1/fs:T-1/fs;
    result = zeros(1,2^k);
    
    for i = 1:2^k
       result(i) = dot(x,cos(2*pi*i*fc*t)); 
    end
    
    b = find(result == max(result));
end
