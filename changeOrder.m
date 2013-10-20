clear all; clc;


symAtOnce = 4;
P = 20;
fc = 1000;
fs = 48000;
timeStepsPerPacket = 49;
chirpLength = 0.02;
fieldSize = 8;
hamm = 4;
ar = audiorecorder(fs, 16, 1);

baseBitStringLength = 300;
rseN = 7;
rseK = 5;
hammingPad = 9;
keyboard;
bits = randi([0 1], 1, baseBitStringLength);
bitsIn = bits;
encodedBits = rsEncode(rseN, rseK, bitsIn')';
bitsEncoded = hammingEncode([encodedBits zeros(1,hammingPad)], 11);

symFSK = codesToSymbols(bitsEncoded);

[s, pad] = encodeNewFSK(symFSK, fc, symAtOnce, P, fs);

syncedSignal = addChirps(s, timeStepsPerPacket, fs, chirpLength); 
signalOut = transmit(syncedSignal, fs, chirpLength);

record(ar),pause(0.5),sound(signalOut,fs), pause(0.5),stop(ar);

rcv = getaudiodata(ar, 'double')';

A = synchro(rcv,timeStepsPerPacket,fs,fc,P,chirpLength);
codeBook = makeCodebook(fc,fs,P,symAtOnce,fieldSize);

symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;

[H, G] = hammgen(hamm);
syndrome = syndtable(H);

interBits = hammingDecode(symbols,syndrome,H,G);

out = rsDecode(rseN, rseK, interBits(1:end-hammingPad)');