% EE 121 
% HW 1
% Problem 3
% Part b



k = 1:100;
L = zeros(1,length(k));
epsilon = 0.5;

for i = 1:100;
    E = 2*i*(log(2) + 2*epsilon);
    T = 2*E;
    L(i) = findBestThreshold(i,E);
end

P1 = qfunc(sqrt(T/2) - L);
P2 = (2.^k).*qfunc(L);
Perror = P1 + P2 - P1.*P2;

semilogy(k,Perror)

