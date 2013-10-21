function [ signalOut, fileBits, symFSK, encodedBits ] = transmitFunction()

fileBits = file2Bits('test.txt');

header = makeHeader('out.txt', fileBits);

bits = [header; fileBits];


symAtOnce = 4;
P = 10;
fc = 1000;
fs = 48000;
timeStepsPerPacket = 97;
chirpLength = 0.02;

baseBitStringLength = 300;
blocksPerHash = 2;
rseN = 7;
rseK = 5;
tagLength = 34;

hammingPad = 7;


bitsIn = divideAndTagBits(bits', baseBitStringLength, blocksPerHash, tagLength);
syncedSignal = [];
symFSK = [];
encodedBits = [];
for i = 1:size(bitsIn,1)
    encodedBits(i,:) = [rsEncode(rseN, rseK, bitsIn(i,:)')' zeros(1,hammingPad)];


    bitsEncoded = hammingEncode(encodedBits(i,:), 11);

    symFSK(i,:) = codesToSymbols(bitsEncoded);
    [s, pad] = encodeNewFSK(symFSK(i,:), fc, symAtOnce, P, fs);

    syncedSignal = [syncedSignal addChirps(s, timeStepsPerPacket, fs, chirpLength)]; 
end
signalOut = transmit(syncedSignal, fs, chirpLength);
end