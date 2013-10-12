function y = synchronizationRXPackets(x,fs,len,numPack,D,fc,numSym)
    % numPack is number of packets
    % numSym is number of packets
    packLen = numSym*floor((D*fs)/fc);
    y = zeros(numPack,packLen);
    t = [0:fs*len-1]/fs;
    f_of_t = 20+t/16*(20000-20);
    chirp = sin(2*pi*f_of_t.*t)*.5;
    N = length(chirp) + length(x) - 1;
    chirpPad = [zeros(1,2*(N-length(chirp))) chirp];
    xPad = [x zeros(1,2*(N-length(x)))];
    
    corr = fftfilt(xPad,chirpPad(end:-1:1));
    idx = [];
    
    for i = 1:numPack
        big = find(corr == max(corr));
        idx = [idx big(1)];
        corr(big(1)-10:big(1)+10) = zeros(1,length(big(1)-10:big(1)+10));
    end
    idx = sort(idx);
    for i = 1:numPack
        y(i,:) = xPad(idx(i)+1:idx(i)+packLen);
    end
end