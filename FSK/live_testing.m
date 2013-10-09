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
n = 20;
time = 5;
%%
record(ar), pause(time), stop(ar);
rcv = getaudiodata(ar);
y = synchronizationRX(rcv,fs,len);
b = zeros(1,n);
pad = ceil(length(y)/(T*fs));
y = [y; zeros(pad*T*fs - length(y),1)];
q = reshape(y,T*fs,length(y)/(T*fs));
for i = 1:n
    b(i) = decodeFSKSync(q(:,i),k,fc,fs,C,D);
end

