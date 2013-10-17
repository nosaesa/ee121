clear all; close all; clc;
symErrors = [];
%%
fc = 800;
fs = 48000;
P = 5;
chirpLength = 0.02;
ar = audiorecorder(fs, 16, 1);
fieldSize = 8;

% number of symbols/tones per timestep
N = 5;

% x is how many 57-bit messages to send
x = 400;
bits = randi([0 1],1,57*x);

% n = 4 for hamming 11, 15
n = 6;
[H,G] = hammgen(n);
syndrome = syndtable(H);

C = hammingEncode(bits,n);
C = timsCoolFunction(C);

M = codesToSymbols(C);

encodedM = rsEncode(M);

[Y,numPad] = encodeNewFSK(encodedM',fc,N,P,fs);

fprintf('Number of timesteps: %d\n',size(Y,1));
%%
timeStepsPerPacket = 3920;

out = addChirps(Y, timeStepsPerPacket, fs, chirpLength);

signalOut = transmit(out, fs,chirpLength);

c = clock;
startTime = c(4:6);
%%{
record(ar),pause(0.5),sound(signalOut,fs), pause(0.5),stop(ar);

rcv = getaudiodata(ar, 'double')';
%}

%%% IDEAL CASE
%rcv = signalOut;
%%%

A = synchro(rcv,timeStepsPerPacket,fs,fc,P,chirpLength);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,N,fieldSize);

% decode waveforms into symbol packets
symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;

decodedSymbols = rsDecode(symbols)';

output = hammingDecode(decodedSymbols,syndrome,H,G);
c = clock;
endTime = c(4:6);

deltaTime = endTime - startTime;
totalTime = 60*60*deltaTime(1) + 60*deltaTime(2) + deltaTime(3);
%%% IDEAL CASE
%totalTime = totalTime + length(signalOut)/fs;
%%%

dataRate = round(length(bits)/(totalTime));
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