function [ packets ] = decodeSymbolPackets(A, fs, fc, P, codeBook, fieldSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T = P/fc;
t = 0:1/fs:T-1/fs;
% TSL = time step length
TSL = length(t);
numPackets = size(A,1);
packetLength = size(A,2);
% NTSP = number of time steps in packet
NTSP = packetLength/TSL;
% NTS = number of time steps
NTS = (numPackets*NTSP);
S = reshape(A',TSL,NTS)';
prods = abs(S*codeBook);
[row, col] = size(prods);
prods = reshape(prods', fieldSize, col/fieldSize, row); 
[~, ind] = max(prods);
packets = reshape(ind, 1, size(ind,2)*size(ind,3));
end

