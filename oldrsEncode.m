function [ out ] = oldrsEncode( message )
%   rsEncode encodes symbols \in {1,...,2^m} in a Reed-Solomon code
%   message is the array of symbols to be encoded
%   numBits is the number of bits required to represent a symbol
%   numErrors is the desired number of tolerable errors
if (size(message,2) ~= 1)
    message = message';
end

sym = binary2sym(message, 6);

sym = reshape(sym, 50, length(sym)/50);
out = [];
for i = 1:size(sym, 2)
    H = comm.RSEncoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', fliplr(de2bi(primpoly(6))), 'MessageLength', 50, 'CodewordLength', 62);
    %H = comm.RSEncoder();
    c = step(H,sym(:,i));
    bits = sym2binary(c, 6);
    out = [ out, bits ];
end

end