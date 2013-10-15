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
ar = audiorecorder(fs, 16, 1);


filein = 'sahai.jpg';

% read our bits
%testbits = file2Bits(filein);
testbits = randi([0 1], 100, 1);

% make G
G = createGeneratorMatrix(fieldSize, chunkSize, rate);

% turn bits into symbols
symbols = codePacketGenerator(G, testbits, fieldSize);

% encode symbols using FSK
signal = encodeFSK(symbols,fc,chunkSize,P,fs);

% add chirps for syncing
out = addChirps(signal, packetLength, fs);

out = transmit(out, fs,1);

% transmit / record simulatneously
record(ar), sound(out,fs), pause(10),stop(ar);
rcv = getaudiodata(ar, 'double')';
%%
% synchronize received signal and block into packets
A = synchro(rcv,packetLength,fs,fc,P);
%%
% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,L,fieldSize);
[~, vecs, binary] = makeLookupTable(G, fieldSize);

% decode waveforms into symbol packets
packets = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize);

% decode symbol packets into bits
out = decodePackets(symbols', vecs, binary, chunkSize/rate);

if (sum(out - testbits) ~= 0)
    display('ERROR in communicating bits')
else
    display('SUCCESSFUL communication!')
end
