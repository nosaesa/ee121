function [ bits ] = hammingDecode( symbols, synd, H, G )
    b = dec2bi(symbols, 'left-msb');
    [k, n] = size(g);
    stream = reshape(b', length(b)/n, n);
    indices = bi2de(mod(stream*H', 2), 'left-msb') + 1;
    sent = mod(stream + synd(indices, :), 2);
    temp = sent*G;
    bits = temp(:, n-k+1);
    bits = reshape(bits', 1, size(bits,1)*size(bits,2));
end

