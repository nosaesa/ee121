function [ c ] = rsEncode( message, numErrors )
%   rsEncode encodes symbols \in {1,...,2^m} in a Reed-Solomon code
%   message is the array of symbols to be encoded
%   numBits is the number of bits required to represent a symbol
%   numErrors is the desired number of tolerable errors
if (size(message,2) ~= 1)
    message = message';
end
H = comm.RSEncoder(length(message)+2*numErrors,length(message));
c = step(H,message);
end

