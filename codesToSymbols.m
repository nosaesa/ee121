function [M] = codesToSymbols(C)
    m = size(C,1);
    k = size(C,2);
    C = reshape(C', 1, k*m);
    %%M = zeros(m,k);
    Q = reshape(C,3,k*m/3)';
    Q = bi2de(Q,'left-msb');
    M = reshape(Q,m*k/3,1)';
end