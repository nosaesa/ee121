function [ sendFiles,miniFiles, signalOut ] = transmitFunction(numFiles)
%TESTFUNCTION Will test everything
symAtOnce = 4;
P = 20;
fc = 1000;
fs = 48000;
numErrors = 10;
timeStepsPerPacket = 5;
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
headerLength = 77;

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

% symbolsEncoded = zeros(size(symbols,1), size(symbols,2)+2*numErrors);
% for i = 1:size(symbols,1)
%     symbolsEncoded(i,:) = rsEncode(symbols(i,:), numErrors);
% end
% 
% [signals, ~] = encodeNewFSK(symbols, fc, symAtOnce, P, fs);
% 
% signalOut = zeros(size(signals));
% for i = 1:size(signals, 3)
%     syncedSignal = addChirps(signals(:,:,i), timeStepsPerPacket, fs, chirpLength); 
%     signalOut(:,:,i) = transmit(syncedSignal, fs, chirpLength);
% end
%modulate sendFiles to signals
%send sendFiles in order and wait for positive response on each

end

