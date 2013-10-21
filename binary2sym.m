function [ symbols ] = binary2sym( bits, n )
rows = length(bits)/n;
r = reshape(bits, n, rows)';

symbols = bi2de(r, 'left-msb');
end

