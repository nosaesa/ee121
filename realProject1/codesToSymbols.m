function [M] = codesToSymbols(C)
    m = size(C,1);
    k = size(C,2)/3;
    M = zeros(m,k);
    Q = reshape(C',3,k*m)';
    Q = bi2de(Q,'left-msb');
    M = reshape(Q,m*k,1)';
end