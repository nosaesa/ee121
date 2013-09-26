% Encode a random bitstring
fs = 2000;
b = randi([0 1],1,1000);
y = encodeOOK(b,fs);

% Immediately decode the encoded signal
% and compute the error
c = decodeOOK(y,fs);
e = computeError(c,b)