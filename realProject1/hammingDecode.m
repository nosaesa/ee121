function [ bits ] = hammingDecode( symbols, synd, H, G )
    b = de2bi(symbols, 'left-msb');
    [k, n] = size(G);
    stream = (reshape(b', n, size(b,1)*size(b,2)/n))';
    indices = bi2de(mod(stream*H', 2), 'left-msb') + 1;
    sent = mod(stream + synd(indices, :), 2);
    bits = sent(:, n-k+1:end);
    bits = reshape(bits', 1, size(bits,1)*size(bits,2));
end

