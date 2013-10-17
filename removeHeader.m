function [ realBits, err ] = removeHeader( bits, lengthBits, seqBits, hashBits, nameBits )
name = bits(1:nameBits);
seqStart = nameBits+1;
seqNum = bits(seqStart:seqStart+seqBits-1);
lenStart = seqStart+seqBits;
len = bits(lenStart:lenStart+lengthBits-1);
length = bi2de(len, 'left-msb');
hashStart = lenStart+lengthBits;
hash = bits(hashStart:hashStart+hashBits-1);

keyboard;

dataStart = hashStart+hashBits;
dataBits = bits(dataStart:dataStart+length);

toHash = [name; seqNum; len; dataBits];

calculated = DataHash(toHash);
calculated = dec2bin(calculated,8);
calculated = calculated(:)'-'0';
actualHash = calculated(1:32);

if sum(hash ~= actualHash) ~= 0
    err = 1;
end

realBits = dataBits;

end

