function [ outBits, errors ] = checkCorrectness( bits, baseLength, blocksPerHash, tagLength )
% bits is a string of bits of variable length
% baseLength is block size like 300 that our code is working with
% blocksPerHash is how many baseLengths we are putting together between
% tags
% tagLength is the length of the tag

chunkLength = blocksPerHash*baseLength;
rounds = length(bits)/chunkLength;
errors = zeros(1,rounds);

outBits = [];

for i = 0:rounds-1
    toCheck = bits(i*chunkLength+1:(i+1)*chunkLength);
    hash = toCheck(1:32);
    calcHash = DataHash(toCheck(33:end));
    calcHash = dec2bin(calcHash,8);
    calcHash = calcHash(:)'-'0';
    if sum(calcHash(1:32)' ~= hash) ~= 0
        errors(i+1) = 1;
    end
    tag = toCheck(33:33+(tagLength-32)-1);
    data = toCheck(33+(tagLength-32):end);
    outBits = [outBits data];
end

