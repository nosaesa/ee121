function [Z] = synchTest(Y,packLength,fs)
%ADDCHIRPS Adds chirps to the beginning of each row of Y
%   Detailed explanation goes here
%   packLength is the number of timesteps (rows of Y) per packet.
%   Each packet gets a chirp preamble for synchronization.
if mod(size(Y,1),packLength) ~= 0
    error('addChirps:packLength must be a factor of total number of timesteps (size(Y,1))')
end
q = size(Y,1)/packLength;
Y = reshape(Y',size(Y,2)*packLength,q)';
Z = Y;
end
