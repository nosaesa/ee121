function [ name, fileBits, symbols, errors, time, interBits ] = decodeFunction2( rcv )
symAtOnce = 4;
P = 10;
fc = 1000;
fs = 48000;
timeStepsPerPacket = 130;
chirpLength = 0.02;

symbolsPerBlock = 520;

baseBitStringLength = 300;
blocksPerHash = 2;
rseN = 7;
rseK = 5;
tagLength = 34;
fieldSize = 8;
hamm = 3;
hammingPad = 0;

keyboard;

A = synchro(rcv,timeStepsPerPacket,fs,fc,P,chirpLength);
codeBook = makeCodebook(fc,fs,P,symAtOnce,fieldSize);
symbols = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize) - 1;
symbols = reshape(symbols, symbolsPerBlock, length(symbols)/symbolsPerBlock)';
totalBits = [];
interBits = [];
for i=1:size(symbols,1)
    [H, G] = hammgen(hamm);
    syndrome = syndtable(H);
    
    interBits(i,:) = hammingDecode(symbols(i,:),syndrome,H,G);
    out = oldrsDecode(interBits(i,1:end-hammingPad)');
    [bits, errors] = checkCorrectness(out', baseBitStringLength, blocksPerHash, tagLength);
    totalBits = [totalBits; bits];
end

[fileBits, name] = removeHeader(totalBits, 32, 32);
time = toc;
bits2File(fileBits, name);
system(['open ' name]);
end

