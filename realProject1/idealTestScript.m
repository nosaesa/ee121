clear all; close all; clc;

% initialize all variable values
fieldSize = 7;
chunkSize = 4;
L = chunkSize;
rate = .5;
fc = 400; 
fs = 48000;
P = 50;
packetLength = 10;

filein = 'sahai.jpg';

% read our bits
%testbits = file2Bits(filein);
testbits = randi([0 1], 100, 1);

% make G
G = createGeneratorMatrix(fieldSize, chunkSize, rate);

% turn bits into symbols
symbols = codePacketGenerator(G, testbits, fieldSize);
symbols = mod(symbols+1, fieldSize+1);

% encode symbols using FSK
signal = encodeFSK(symbols,fc,chunkSize,P,fs);

% add chirps for syncing
out = addChirps(signal, packetLength, fs);

out = transmit(out, fs,1);

% synchronize received signal and block into packets
A = synchronize(out,packetLength,fs,fc,P);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,L,fieldSize);
[~, vecs, binary] = makeLookupTable(G, fieldSize);

% decode waveforms into symbol packets
packets = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize);
packets = packets-1;

% decode symbol packets into bits
out = decodePackets(packets', vecs, binary, chunkSize/rate);

if (sum(out - testbits) ~= 0)
    display('ERROR in communicating bits')
else
    display('SUCCESSFUL communication!')
end
