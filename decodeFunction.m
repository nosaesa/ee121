function [ symbols, bits ] = decodeFunction( rcv )
symAtOnce = 4;
P = 20;
fc = 1000;
fs = 48000;
timeStepsPerPacket = 29;
chirpLength = 0.02;
fieldSize = 8;

hamm = 4;

keyboard;

A = synchro(rcv(1,:),timeStepsPerPacket,fs,fc,P,chirpLength);
codeBook = makeCodebook(fc,fs,P,symAtOnce,fieldSize);

symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;

symbols = rsDecode(symbols)';
keyboard;
[H, G] = hammgen(hamm);
syndrome = syndtable(H);

interBits = hammingDecode(symbols,syndrome,H,G);
bits = interBits;
%bits = removeHeader(interBits, 16, 2, 32, 28);
end

