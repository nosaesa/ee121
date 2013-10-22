function [ out ] = oldrsDecode( code )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors

sym = binary2sym(code, 8);
sym = reshape(sym, 111, length(sym)/111);
out = [];
for i = 1:size(sym, 2)
    %g = fliplr(de2bi(primpoly(6)));
    g = [1 0 0 0 1 1 1 0 1];
    H = comm.RSDecoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', g, 'MessageLength', 75, 'CodewordLength', 111);
    message = step(H,sym(:,i));
    bits = sym2binary(message, 8);
    out = [out bits];
end

end