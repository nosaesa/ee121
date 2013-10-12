function C = makeCodebook(k,fc,fs,D)
    T = D/fc;
    t = 0:1/fs:T-1/fs;
    C = zeros(2^k,length(t));
    for i = 1:2^k
        C(i,:) = cos(2*pi*i*fc*t);
    end
end