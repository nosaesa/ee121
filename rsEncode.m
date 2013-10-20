function [ c ] = rsEncode( n, k, message )
%   rsEncode encodes symbols \in {1,...,2^m} in a Reed-Solomon code
%   message is the array of symbols to be encoded
%   numBits is the number of bits required to represent a symbol
%   numErrors is the desired number of tolerable errors
if (size(message,2) ~= 1)
    message = message';
end

H = comm.RSEncoder(n,k,'BitInput', true);
c = step(H,message);

end

