function y = Perror(L)
k = 10;
E = 100;
T = 2*E;
P1 = qfunc(sqrt(T/2) -L);
P2 = (2^k).*qfunc(L);
Perror = P1 + P2 - P1.*P2;
end