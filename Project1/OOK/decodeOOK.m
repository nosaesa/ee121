function b = decodeOOK(x,fs)
    % x is the signal to be decoded, normalized to [-1,1]
    % fs is the sampling rate of the signal to be decoded (in Hertz)
    
    % Break up signal into quarter-second duration chunks
    y = [];
    for i = 1:fs/4:(length(x)-fs/4)
        y = [y x(i:i+fs/4)'];
    end
    
    % Decode via FFT thresholding
    Y = fft(y);
    b = [];
    for i = 1:length(Y(1,:));
        if (mean(abs(Y(105:115,i))) > 20)
            b(i) = 1;
        else
            b(i) = 0;
        end
    end
end
