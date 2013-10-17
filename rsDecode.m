function [ message ] = rsDecode( code )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors
if (size(code,2) ~= 1)
    code = code';
end

L = length(code);
n = 3;
if mod(L, 4) == 0
    n = 4;
end
if mod(L, 5) == 0
    n = 5;
end
if mod(L, 6) == 0
    n = 6;
end
if mod(L, 7) == 0
    n = 7;
end

H = comm.RSDecoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', fliplr(de2bi(primpoly(3))), 'MessageLength', n-2, 'CodewordLength', n);
message = step(H,code);
end

