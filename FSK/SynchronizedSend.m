%% Chirping Derping Sending Shiz
fs = 48000;
fc = 400;
lenchirp = 0.6;
t = [0:fs*lenchirp-1]/fs;
f_of_t = 20+t/16*(20000-20);
s_chirp= sin(2*pi*f_of_t.*t)*.5;
%sound(s_chirp,fs);
r = 3;
y = [];
%Number of symbols being sent
n = 20;

%Number of periods for tones to last
D = 10;
% Generate random bit string and encode
sent = randi([1 2^r],1,n);

index = 0;
for bit = sent
    if mod(index,20) == 0
        y = [y s_chirp];
    end
    y = [y repmat(encodeFSK(bit,r,fc,fs),1,D)];
    index = index + 1;
end
signal = y;

% sound(signal,fs)
    