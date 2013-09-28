clear all; close all; clc;

E = 100; k = 5;

L = linspace(0, sqrt(E), 1000);

Y = exp(-((sqrt(E)-L).^2)/2) + 2^k*exp(-(L.^2)/2);
Y = qfunc(sqrt(E)-L) + 2^k*qfunc(L) - (qfunc(sqrt(E)-L)).*(2^k*qfunc(L));
%figure(1); 
plot(L,Y);