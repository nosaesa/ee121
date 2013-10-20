function [ bin ] = sym2binary( syms )
temp = de2bi(syms)';
bin = reshape(temp, 1, size(temp,1)*size(temp,2));

end

