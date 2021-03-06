%%
% Valid n values:
%   4 -> (11, 15)  6 -> (57, 63)  8 -> (247, 255)
% Out is a matrix with n columns where n is the 2nd element of an above
% tuple
%
% bits must be a multiple of the 1st element of an above tuple
%%
function [ out ] = hammingEncode( bits, n )
    

    [~, g, l, k] = hammgen(n);
    if (mod(l, 3) ~= 0)
        error('hamming size invalid.\n');
    end
    b = reshape(bits, k, length(bits)/k)';

    out = mod(b*g, 2);

end

