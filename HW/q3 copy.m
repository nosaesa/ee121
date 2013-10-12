% EE 121
% HW 2
% Question 3

% Number of bits
k = 1:1000;

epsilon = 0.01;

sigma = 1;

T = (log(2) + 2*epsilon)*4*k*sigma^2;
L = sqrt((log(2) + epsilon)*2*k*sigma^2);
E = (log(2) + 2*epsilon)*2*sigma^2;

Perror = qfunc((sqrt(T/2) - L)/sigma) + qfunc(L/sigma).*2.^k;
