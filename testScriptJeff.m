clear all; close all; clc;
symError = [];
bitError = [];
%%
fc = 1000;
fs = 48000;
P = 20;
chirpLength = 0.02;
ar = audiorecorder(fs, 16, 1);
fieldSize = 8;

% number of errors we want to correct for
numErrors = 20;

% number of symbols/tones per timestep
N = 3;

% x is how many 11-bit messages to send
x = 97;
bits = randi([0 1],1,57*x);

% n = 4 for hamming 11, 15
n = 6;
[H,G] = hammgen(n);
syndrome = syndtable(H);

C = hammingEncode(bits,n);
C = timsCoolFunction(C);
M = codesToSymbols(C);

encodedM = rsEncode(M,numErrors)';

[Y,numPad] = encodeNewFSK(encodedM,fc,N,P,fs);

fprintf('Number of timesteps: %d\n',size(Y,1));

timeStepsPerPacket = 10;

out = addChirps(Y, timeStepsPerPacket, fs, chirpLength);

signalOut = transmit(out, fs,chirpLength);

record(ar),pause(0.5),sound(signalOut,fs), pause(0.5),stop(ar);

rcv = getaudiodata(ar, 'double')';

A = synchro(rcv,timeStepsPerPacket,fs,fc,P,chirpLength);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,N,fieldSize);

% decode waveforms into symbol packets
symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;

[symbols,rsErrors] = rsDecode(symbols,numErrors);

symbols = symbols';

output = hammingDecode(symbols,syndrome,H,G);

dataRate = round(length(bits)/(length(signalOut)/fs));

symError = [symError length(find(abs(M - symbols(1:end-numPad)) ~= 0))];
bitError = [bitError length(find(abs(output - bits) ~= 0))];
if (rsErrors <= numErrors)
    if (sum(abs(bits-output)) ~= 0)
        fprintf('ERROR in communication\n');
        close all;
        figure;
        stem(abs(bits-output));
        title('Bit Errors')
        figure;
        stem(abs(M-symbols(1:end-numPad)));
        title('Symbol Errors')
    else
        fprintf('SUCCESSFUL communication! %d bits/sec\n',dataRate);
    end
else
    fprintf('too many errors, try again')
end