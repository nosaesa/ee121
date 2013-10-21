function [ out ] = oldrsDecode( code )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors

sym = binary2sym(code, 6);
sym = reshape(sym, 62, length(sym)/62);
out = [];
for i = 1:size(sym, 2)
    H = comm.RSDecoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', fliplr(de2bi(primpoly(6))), 'MessageLength', 50, 'CodewordLength', 62);
    message = step(H,sym(:,i));
    bits = sym2binary(message, 6);
    out = [out bits];
end

end