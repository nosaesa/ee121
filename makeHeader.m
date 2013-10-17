function [ bits ] = makeHeader( filename, bitSequence, seqNum )
    %edit this to actually use filename
    biName = reshape(dec2bin(double('name'),7).',[],1);
    len = de2bi(length(bitSequence), 16, 'left-msb')';
    toHash = [biName; seqNum; len; bitSequence];
    hash = DataHash(toHash, 'SHA-1');
    bits = [toHash; hash];
end

