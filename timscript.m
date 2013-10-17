clear all; close all; clc;

[~, ~, signalOut, inBits, symbolsSent] = transmitFunction(1);


%%
[symbols, outBits] = decodeFunction(signalOut);

