function [ out ] = oldrsEncode( message )
%   rsEncode encodes symbols \in {1,...,2^m} in a Reed-Solomon code
%   message is the array of symbols to be encoded
%   numBits is the number of bits required to represent a symbol
%   numErrors is the desired number of tolerable errors
if (size(message,2) ~= 1)
    message = message';
end

sym = binary2sym(message, 8);

sym = reshape(sym, 75, length(sym)/75);
out = [];
for i = 1:size(sym, 2)
    %g = fliplr(de2bi(primpoly(6)));
    g = [1 0 0 0 1 1 1 0 1];
    H = comm.RSEncoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', g, 'MessageLength', 75, 'CodewordLength', 111);
    %H = comm.RSEncoder();
    c = step(H,sym(:,i));
    bits = sym2binary(c, 8);
    out = [ out, bits ];
end

end