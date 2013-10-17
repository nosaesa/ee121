function [files] = sliceFileAddHeader(bits,headerLength,numFiles,fileName)
%SLICEFILEADDHEADER Slices file into chunks and add header packet to each
chunkLength = floor(length(bits)/(numFiles-1));
padBits = chunkLength - mod(length(bits),numFiles-1);

Headers = zeros(numFiles,headerLength);
for i = 1:numFiles
if i == numFiles
    Headers(i,:) = makeHeader(fileName,(bits((i-1)*chunkLength+1:end))',mod(i-1,4));
else
    Headers(i,:) = makeHeader(fileName,(bits((i-1)*chunkLength+1:i*chunkLength))',mod(i-1,4));
end
end

%padding for file length
paddedBits = [bits zeros(1,padBits)];
files = [Headers reshape(paddedBits,numFiles,chunkLength)];

%padding for hamming
fileLength = length(files(1,:));
hammPad = zeros(numFiles,(floor(fileLength/11)+1)*11 - fileLength);
files = [files hammPad];
end

