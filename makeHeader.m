function [ bits ] = makeHeader( filename, bitSequence, seqNum )
    %edit this to actually use filename
    biName = reshape(dec2bin(double('name'),7).',[],1);
    len = de2bi(length(bitSequence), 16, 'left-msb')';
    biName = biName(:)'-'0';
    biName = biName';
    toHash = [biName; seqNum; len; bitSequence];
    hash = DataHash(toHash);
    hash = dec2bin(hash,8);
    hash = hash(:)'-'0';
    hash = hash';
    bits = [toHash(1:45); hash(1:32)];
end
