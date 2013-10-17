function [files] = sliceFileAddHeader(bits,numChunks)
%SLICEFILEADDHEADER Slices file into chunks and add header packet to each
chunkSize = floor(length(bits)/(numChunks-1));
padBits = chunkSize - mod(length(bits),numChunks-1);

chunkHeaders = 

end

