function [ sendFiles, miniFiles, signalOut, bits ] = transmitFunction(numFiles)
%TESTFUNCTION Will test everything
symAtOnce = 4;
P = 20;
fc = 1000;
fs = 48000;
numErrors = 10;
timeStepsPerPacket = 2;
chirpLength = 0.02;

if ~exist('testFile')
    bits = randi([0 1],1,8000);
    fileName = 'randomBits';
else
    bits = file2Bits(testFile);
    fileName = testFile;
end

%We are using Hamming 11 15 codes
hammingInput = 11;
hammingOutput = 15;
headerLength = 78;

%miniFiles = matrix of file packets with headers
miniFiles = sliceFileAddHeader(bits,headerLength,numFiles,fileName);
fileLength = length(miniFiles(1,:));

sendFiles = zeros(numFiles,fileLength/hammingInput,hammingOutput);

for i = 1:numFiles
    sendFiles(i,:,:) = hammingEncode(miniFiles(i,:),hammingInput);
end

[r,c,d] = size(sendFiles);
symbols = zeros(d,r*c/3);
for i = 1:size(sendFiles, 3)
    symbols(i,:) = codesToSymbols(sendFiles(:,:,i));
end


for i = 1:size(symbols,1)
    symbolsEncoded(i,:) = rsEncode(symbols(i,:));
end

[signals, ~] = encodeNewFSK(symbolsEncoded, fc, symAtOnce, P, fs);

%signalOut = zeros(size(signals));
for i = 1:size(signals, 3)
    syncedSignal = addChirps(signals(:,:,i), timeStepsPerPacket, fs, chirpLength); 

    signalOut(:,:,i) = transmit(syncedSignal, fs, chirpLength);
end
end

