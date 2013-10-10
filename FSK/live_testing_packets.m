close all;
clear all;
clc;

%%
k = 3;
D = 10;
len = 0.6;
fc = 400;
T = D/fc;
fs = 48000;
C = makeCodebook(k,fc,fs,D);
ar = audiorecorder(fs,16,1);
numSym = 20;
numPack = 5;
time = 10;
%%
record(ar), pause(time), stop(ar);
% record(ar),sound(signal,fs),pause(time),stop(ar);
rcv = getaudiodata(ar);
%%
w = synchronizationRXPackets(rcv,fs,len,numPack,D,fc,numSym);
b = zeros(numPack,numSym);
for i = 1:numPack
    y = w(i,:);
    pad = ceil(length(y)/(T*fs));
    y = [y; zeros(pad*T*fs - length(y),1)];
    q = reshape(y,T*fs,length(y)/(T*fs));
    for j = 1:numSym
        b(i,j) = decodeFSKSync(q(:,j),k,fc,fs,C,D);
    end
end