function [ book ] = makeCodebook(fc, fs, P, L, fieldSize)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
T = P/fc;
t = 0:1/fs:T-1/fs;

book = zeros(length(t), L*fieldSize);
for k = 0:L-1
    C = zeros(length(t), fieldSize);
    for s = 1:fieldSize
        C(:,s) = cos(2*pi*fc*(s+k/L)*t);
    end
    book(:, k*fieldSize+1:k*fieldSize + fieldSize) = C;
end

end

