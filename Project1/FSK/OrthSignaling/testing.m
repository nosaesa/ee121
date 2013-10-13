close all;
clear all;
clc

k = 3;
D = 50;
fc = 400;
T = D/fc;
fs = 20000;
C = makeCodebook(k,fc,fs,D);
%%
z = [];
c = [];
for i = 1:10
    m = randi([1 2^k],1,1);
    z = [z encodeFSKSync(m,fc,fs,D)];
    c = [c m];
end
%%
v = synchronizationTX(z,fs);

%%
y = synchronizationRX(v,fs);

%%
b = [];
for i = 0:9
    w = y(i*T*fs+1:(i+1)*T*fs);
    b = [b decodeFSKSync(w,k,fc,fs,C,D)];
end

%%
if b ~= c
    display('failure')
else 
    display('success!')
end
