function [ args ] = testFunction(fileChunks,testFile)
%TESTFUNCTION Will test everything

if ~exist('testFile')
    bits = randi([0 1],1,100);
    fileName = testFile
else
    bits = file2Bits(testFile)
    fileName = 'randomBits'
end

files = sliceFileAddHeader(bits,numChunks);



end

