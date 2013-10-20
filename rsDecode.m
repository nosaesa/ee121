function [ message ] = rsDecode( n, k, code )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors
if (size(code,2) ~= 1)
    code = code';
end

H = comm.RSDecoder(n,k,'BitInput', true);
message = step(H,code);
end

