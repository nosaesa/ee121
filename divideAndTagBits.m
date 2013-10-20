function [ outBits ] = divideAndTagBits( bits, baseLength, blocksPerHash, tagLength )
% bits is a string of bits of variable length
% baseLength is block size like 300 that our code is working with
% blocksPerHash is how many baseLengths we are putting together between
% tags

dataBitsPerTag = baseLength * blocksPerHash - tagLength;
rounds = ceil(length(bits) / dataBitsPerTag);
outBits = zeros(rounds, baseLength*blocksPerHash);

for i = 0:rounds-1
    endIndex = (i+1)*dataBitsPerTag;
    if endIndex < length(bits)
        toTag = bits(i*dataBitsPerTag + 1: endIndex);
    else
        toTag = bits(i*dataBitsPerTag + 1: end);
        padLength = dataBitsPerTag - length(toTag);
        toTag = [toTag zeros(1, padLength)];
    end
    tag = makeTag(toTag, mod(i, 4));
    outBits(i+1,:) = [tag', toTag];    
end
end

