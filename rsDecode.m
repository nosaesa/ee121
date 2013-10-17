function [ message ] = rsDecode( code )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors
if (size(code,2) ~= 1)
    code = code';
end

l = length(code);
n = 3;
switch l
    case mod(l, 7) == 0
        n = 7;
    case mod(l, 6) == 0
        n = 6;
    case mod(l, 5) == 0
        n = 5;
    case mod(l, 4) == 0
        n = 4;
end

H = comm.RSEncoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', fliplr(de2bi(primpoly(3))), 'MessageLength', n-2, 'CodewordLength', n);
message = step(H,code);
end

