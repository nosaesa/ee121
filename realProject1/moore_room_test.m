clear all; close all; clc;

% initialize all variable values
fieldSize = 7;
chunkSize = 1;
L = 1;
rate = .5;
fc = 400; 
fs = 48000;
P = 50;
packetLength = 50;
ar = audiorecorder(fs, 16, 1);
symbols = randi([1 7],1,150);

% encode symbols using FSK
signal = encodeFSK(symbols,fc,L,P,fs);

% add chirps for syncing
out = addChirps(signal, packetLength, fs);

out = transmit(out, fs,1);

% transmit / record simulatneously
record(ar), sound(out,fs), pause(1),stop(ar);
%record(ar),pause(10),stop(ar)
rcv = getaudiodata(ar, 'double')';

% synchronize received signal and block into packets
A = synchro(rcv,packetLength,fs,fc,P);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,L,fieldSize);

% decode waveforms into symbol packets
packets = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize);
stem(abs(packets-symbols))
