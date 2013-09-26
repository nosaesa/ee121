fs = 2000;
i = -5:1:10;
w = zeros(1,length(i));
k = 0;

% Use the awgn() function to add White Gaussian Noise to 
% the encoded signal. Do 10 trials for each SNR in [-5,10].
for i = -5:1:10
    z = [];
    k = k+1;
    for j = 1:10;
        b = randi([0 1],1,1000);
        y = encodeOOK(b,fs);
        y = awgn(y,i);
        c = decodeOOK(y,fs);
        e = computeError(c,b);
        z = [z e];
    end
    w(k) = mean(z);
end
% plot(w)