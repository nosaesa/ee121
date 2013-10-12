fs = 10000;
fc = 200;


i = -5:1:10;
w = zeros(1,length(i));
k = 0;

% number of bits
r = 3;

% Use the awgn() function to add White Gaussian Noise to 
% the encoded signal. Do 10 trials for each SNR in [-5,10].
for i = -5:1:10
    z = [];
    k = k+1;
    for j = 1:10;
        b = randi([1 2^r],1,1);
        y = encodeFSK(b,r,fc,fs);
        y = awgn(y,i);
        c = decodeFSK(y,r,fc,fs);
        disp(' ');
        if b ~= c
            z = [z 1];
        else
            z = [z 0];
        end
    end
    w(k) = mean(z);
end
plot(w)
xlabel('SNR')
ylabel('0 is good, 1 is bad')