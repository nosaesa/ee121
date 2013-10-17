function [files] = sliceFileAddHeader(bits,headerLength,numChunks)
%SLICEFILEADDHEADER Slices file into chunks and add header packet to each
chunkLength = floor(length(bits)/(numChunks-1));
padBits = chunkLength - mod(length(bits),numChunks-1);

chunkHeaders = zeros(numChunks,headerLength);
for i = 1:numChunks
if i == numChunks
    chunkHeaders(i,:) = makeheader(bits((i-1)*chunkLength+1:end));
else
    chunkHeaders(i,:) = makeHeader(bits((i-1)*chunkLength+1:i*chunkLength));
end
end

paddedBits = [bits zeros(1,padBits)];
files = [chunkHeaders reshape(paddedBits,numChunks,chunkLength)];

end

