clear all; close all; clc;
error = [];
%%
clc
% initialize all variable values
fieldSize = 7;
chunkSize = 4;
L = 4;
rate = .5;
%fc = round(15000/(fieldSize + (L-1)/L)); 
fc = 2000;
fs = 48000;
P = fc/10;
packetLength = 25;
chirpLength = 0.02;
ar = audiorecorder(fs, 16, 1);

testbits = randi([0 1], 100, 1);

% make G
G = createGeneratorMatrix(fieldSize, chunkSize, rate);

% turn bits into symbols
symbols = codePacketGenerator(G, testbits, fieldSize);
symbols = mod(symbols+1, fieldSize+1);


% encode symbols using FSK
signal = encodeFSK(symbols,fc,chunkSize,P,fs);

% add chirps for syncing
out = addChirps(signal, packetLength, fs, chirpLength);

signalOut = transmit(out, fs,chirpLength);

% transmit / record simulatneously
%{
n = -256:256;
cutoff = 1.5*fc*(fieldSize + (L-1)/L)*2/fs;
h = (cutoff)*hann(length(n))'.*sinc(n*cutoff);
record(ar), sound(fftfilt(h,signalOut),fs), stop(ar);
%}
%%{
record(ar),pause(0),sound(signalOut,fs), pause(0),stop(ar);
%}
rcv = getaudiodata(ar, 'double')';
 
% synchronize received signal and block into packets
A = synchro(rcv,packetLength,fs,fc,P,chirpLength);

% creating a codebook and lookup table to be used in decoding
codeBook = makeCodebook(fc,fs,P,L,fieldSize);
[~, vecs, binary] = makeLookupTable(G, fieldSize);

% decode waveforms into symbol packets
packets = decodeSymbolPackets(A,fs,fc,P,codeBook,fieldSize);
packets = packets-1;
%display(length(find(packets - symbols + 1 ~= 0)))
% decode symbol packets into bits
out = decodePackets(packets', vecs, binary, chunkSize/rate);
    prob = length(find(packets - symbols + 1 ~= 0))/length(symbols);
    error = [error prob];
if (sum(abs(out - testbits)) ~= 0)
    display('ERROR in communicating bits')
    %stem(abs(out-testbits))
    %sound(rcv,fs)
else
    %display('SUCCESSFUL communication!')
    %display('RATE:')
    display(length(testbits)/(length(signalOut)/fs))
    %display('bits/second')

end
