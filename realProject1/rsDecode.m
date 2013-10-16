function [ message, nerrs ] = rsDecode( code, numErrors )
%   rsDecode decodes a Reed-Solomon code
%   code is the code to be decoded
%   messageLength is the length of the decoded message
%   numErrors is the desired number of tolerable errors
if (size(code,2) ~= 1)
    code = code';
end
H = comm.RSDecoder(length(code),length(code) - 2*numErrors);
[corrcode, nerrs] = step(H,code);
message = corrcode;
end

