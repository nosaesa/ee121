% Encode a random bitstring
fs = 10000;
fc = 200;
k = 3;
b = randi([1 2^k],1,1);
y = encodeFSK(b,k,fc,fs);

% Immediately decode the encoded signal
% and compute the error
c = decodeFSK(y,k,fc,fs);
