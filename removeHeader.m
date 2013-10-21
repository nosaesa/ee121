function [ realBits, name ] = removeHeader( bits, lengthBits, nameBits )
%reading the name incorrectly and needs to be fixed
len = bits(1:lengthBits);
length = bi2de(len', 'left-msb');
nameLen = bits(lengthBits+1:lengthBits+nameBits);
nameLength = bi2de(nameLen', 'left-msb');
nameData = bits(lengthBits+nameBits+1:lengthBits+nameBits+nameLength);
nameData = reshape(nameData, 8, [])';
name = char(bi2de(nameData, 'left-msb'))';

startIndex = lengthBits+nameBits+nameLength+1;
endIndex = lengthBits+nameBits+nameLength+length;
realBits = bits(startIndex:endIndex);


end

