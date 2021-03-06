%%
close all;
clear all;
clc;
%% Chirping Derping Sending Shiz
fs = 48000;
fc = 400;
lenchirp = 0.6;
t = [0:fs*lenchirp-1]/fs;
f_of_t = 20+t/16*(20000-20);
s_chirp= sin(2*pi*f_of_t.*t)*.5;
r = 5;
y = [];
%Number of symbols being sent per packet
numSym = 100;
%Number of packets
numPack = 1;

%Number of symbols
n = numSym*numPack;

%Number of periods for tones to last
D = 3;
T = D/fc;
C = makeCodebook(r,fc,fs,D);
% Generate random bit string and encode
sent = randi([1 2^r],1,n);
y = s_chirp;
for i = 1:n
   y = [y encodeFSKSync(sent(i),fc,fs,D)]; 
end
signal = y;

%%
ar = audiorecorder(fs,16,1);
time = 3;
%%
%record(ar), pause(time), stop(ar);
record(ar),sound(signal,fs),pause(time),stop(ar);
rcv = getaudiodata(ar);
%%
rcv = rcv';
w = synchronizationRXPackets(rcv,fs,lenchirp,numPack,D,fc,numSym);
b = zeros(numPack,numSym);
for i = 1:numPack
    y = w(i,:);
    x1 = floor(D*fs/fc);
    x2 = floor(length(y)/x1);
    y = [y zeros(1,x1*x2 - length(y))];
    q = reshape(y,x1,x2);
    for j = 1:numSym
        b(i,j) = decodeFSKSync(q(:,j),r,fc,fs,C,D);
    end
end