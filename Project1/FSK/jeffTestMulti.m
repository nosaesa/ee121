%%
close all;
clear all;
clc;
%% Chirping Derping Sending Shiz
fs = 48000;
fc = 900;
lenchirp = 0.6;
t = [0:fs*lenchirp-1]/fs;
f_of_t = 20+t/16*(20000-20);
s_chirp= sin(2*pi*f_of_t.*t)*.5;
r = 3;
y = [];
%Number of symbols being sent per packet
numSym = 200;
%Number of packets
numPack = 1;

%Number of symbols
n = numSym*numPack;

%Number of symbols/tones per timeslot
numTones = 2;

%Number of periods for tones to last
D = 2;
T = D/fc;
C0 = makeCodebookMulti(r,fc,fs,D,0);
C1 = makeCodebookMulti(r,fc,fs,D,1);
% Generate random bit string and encode
sent = randi([1 2^r],1,n);
y = s_chirp;
for i = 1:numTones:n
   y = [y encodeFSKSyncMulti(sent(i),fc,fs,D,0)+encodeFSKSyncMulti(sent(i+1),fc,fs,D,1)]; 
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
rcv = signal;
w = synchronizationRXPackets(rcv,fs,lenchirp,numPack,D,fc,numSym/numTones);
b = zeros(numPack,numSym);
for i = 1:numPack
    y = w(i,:);
    x1 = floor(D*fs/fc);
    x2 = floor(length(y)/x1);
    y = [y zeros(1,x1*x2 - length(y))];
    q = reshape(y,x1,x2);
    u = 1;
    for j = 1:numSym/numTones
        b(i,u) = decodeFSKSync(q(:,j),r,fc,fs,C0,D);
        b(i,u+1) = decodeFSKSync(q(:,j),r,fc,fs,C1,D);
        u = u+2;
    end
end
plot(b-sent)
