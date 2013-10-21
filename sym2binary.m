function [ bin ] = sym2binary( syms, n )
temp = de2bi(syms, n, 'left-msb')';
bin = reshape(temp, 1, size(temp,1)*size(temp,2));

end

