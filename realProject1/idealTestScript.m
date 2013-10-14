clear all; close all; clc;

% initialize all variable values
fieldSize = 7;
chunkSize = 4;
rate = .5;
fc = 400; 
fs = 48000;
P = 50;
packetLength = 100;

filein = 'sahai.jpg';

% read our bits
%testbits = file2Bits(filein);
testbits = randi([0 1], 1000, 1);

% make G
G = createGeneratorMatrix(fieldSize, chunkSize, rate);

% turn bits into symbols
symbols = codePacketGenerator(G, testbits, fieldSize);

% encode symbols using FSK
signal = encodeFSK(symbols,fc,chunkSize,P,fs);

% add chirps for syncing
out = addChirps(signal, packetLength, fs);

%transmit(out, fs);