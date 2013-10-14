function [ packets ] = decodeSymbolPackets(A, fs, fc, P, codeBook, fieldSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T = P/fc;
t = 0:1/fs:T-1/fs;
% TSL = time step length
TSL = length(t);
% NTS = number of time steps
NTS = floor(size(A,1)*size(A,2)/TSL);
S = reshape(A',TSL,NTS)';
prods = S*codeBook;
[row, col] = size(prods);
prods = reshape(prods', fieldSize, col/fieldSize, row); 
[~, ind] = max(prods);
packets = reshape(ind, 1, size(ind,2)*size(ind,3));
keyboard;
end
