function C = makeCodebookNew(k,fc,fs,P,symbolNumber,L)
    T = P/fc;
    t = 0:1/fs:T-1/fs;
    C = zeros(2^k,length(t));
    for i = 1:2^k
        C(i,:) = cos(2*pi*i*fc*(1 + symbolNumber/L)*t);
    end
end