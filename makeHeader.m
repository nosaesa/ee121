function [ bits ] = makeHeader( filename, bitSequence )
    %edit this to actually use filename
    biName = reshape(dec2bin(filename,8)',1,[]);
    len = de2bi(length(bitSequence), 32, 'left-msb')';
    biName = biName(:)'-'0';
    biName = biName';
    nameLength = de2bi(length(biName), 32, 'left-msb')';
    
    bits = [len; nameLength; biName];
end

