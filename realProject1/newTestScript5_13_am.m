clear all; close all; clc;
symErrors = [];
%%
fc = 800;
fs = 48000;
P = 20;
chirpLength = 0.02;
ar = audiorecorder(fs, 16, 1);
fieldSize = 8;

numErrors = 20;

% number of symbols/tones per timestep
N = 4;

% x is how many 57-bit messages to send
x = 120;
bits = randi([0 1],1,11*x);

% n = 4 for hamming 11, 15
n = 4;
[H,G] = hammgen(n);
syndrome = syndtable(H);

C = hammingEncode(bits,n);
C = timsCoolFunction(C);

M = codesToSymbols(C);

encodedM = rsEncode(M,numErrors);

[Y,numPad] = encodeNewFSK(encodedM',fc,N,P,fs);

fprintf('Number of timesteps: %d\n',size(Y,1));

timeStepsPerPacket = 80;

out = addChirps(Y, timeStepsPerPacket, fs, chirpLength);

signalOut = transmit(out, fs,chirpLength);

record(ar),pause(0.5),sound(signalOut,fs), pause(0.5),stop(ar);

rcv = getaudiodata(ar, 'double')';

A = synchro(rcv,timeStepsPerPacket,fs,fc,P,chirpLength);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,N,fieldSize);

% decode waveforms into symbol packets
symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;

decodedSymbols = rsDecode(symbols,numErrors)';

output = hammingDecode(decodedSymbols,syndrome,H,G);

dataRate = round(length(bits)/(length(signalOut)/fs));
symErrors = [symErrors length(find(decodedSymbols(1:end-numPad) ~= M))];

if (sum(abs(bits-output)) ~= 0)
    fprintf('ERROR in communication\n');
    
    figure;
    stem(abs(bits-output));
    title('Bit Errors');
    figure;
    stem(abs(M-decodedSymbols(1:end-numPad)));
    title('Symbol Errors');
else
    fprintf('SUCCESSFUL communication! %d bits/sec\n',dataRate);
end