function [ tag ] = makeTag( bits, seqNum )
tag = de2bi(seqNum, 2, 'left-msb')';
toHash = [tag; bits'];

hash = DataHash(toHash);
hash = dec2bin(hash,8);
hash = hash(:)'-'0';
hash = hash';
tag = [hash(1:32); tag];

end

