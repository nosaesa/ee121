function [ sendFiles,miniFiles ] = testFunction(numFiles)
%TESTFUNCTION Will test everything

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


%modulate sendFiles to signals
%send sendFiles in order and wait for positive response on each



end
