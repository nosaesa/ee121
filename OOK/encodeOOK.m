function y = encodeOOK(b,fs)
    % b is the binary string to be encoded
    % fs is the sampling rate (in Hertz)
    
    n = length(b);
    y = [];
        for i = 1:n
            y = [y b(i).*ones(1,fs/4)];
        end
    y = y.*cos(linspace(0, n*440*2*pi/4, n*fs/4));    
end