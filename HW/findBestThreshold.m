function L = findBestThreshold(k,E)
% findBestThreshold() returns the optimal decoding threshold for 
% the orthogonal signaling method discussed in class, given the
% number of bits k in a message and the energy per bit E.

T = 2*E;
step = .001;
L = 0:step:E;

% P1 represents the probability of the true message 
% falling short of the threshold:
P1 = qfunc(sqrt(T/2) - L);

% P2 represents the probability of any of the "false
% messages" (noise) passing the threshold:
P2 = (2^k).*qfunc(L);

% The overall probability of error is upper-bounded 
% by the union of the two independent events 
% described above:
Perror = P1 + P2 - P1.*P2;

% We choose the optimal decoding threshold to be 
% the threshold that minimizes the probability of
% error: 
L = find(Perror == min(Perror))*step;
end