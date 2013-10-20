function [ signalOut, fileBits, symFSK ] = transmitFunction()

fileBits = file2Bits('test.txt');

header = makeHeader('out.txt', fileBits);

bits = [header; fileBits];


symAtOnce = 4;
P = 20;
fc = 1000;
fs = 48000;
timeStepsPerPacket = 97;
chirpLength = 0.02;

baseBitStringLength = 300;
rseN = 7;
rseK = 5;
tagLength = 34;


bitsIn = divideAndTagBits(bits', baseBitStringLength, 2, tagLength);
encodedBits = [];
for i = 1:size(bitsIn,1)
    encodedBits = [encodedBits rsEncode(rseN, rseK, bitsIn(i,:)')' zeros(1,7)];
end

bitsEncoded = hammingEncode(encodedBits, 11);

symFSK = codesToSymbols(bitsEncoded);

[s, pad] = encodeNewFSK(symFSK, fc, symAtOnce, P, fs);

syncedSignal = addChirps(s, timeStepsPerPacket, fs, chirpLength); 
signalOut = transmit(syncedSignal, fs, chirpLength);
end

