% EE 121
% HW 2
% Problem 1
% Part d

%% Approximate Probability of Error
j = 1:10;
p = 0.1;
k = 2.^(j - 1);
n = 2.^j;
Psym = 1 - (1 - p).^j;
mu = Psym;
E = floor(0.5*(2.^j - k));
sigma = sqrt(Psym.*(1 - Psym));
Perr_approx = qfunc((E - n.*mu)./(sigma.*sqrt(n)));

%% Actual Probability of Error
n = 10;
Perr_actual = zeros(1,n);
for j = 1:n
    p = 0.1;
    Psym = 1 - (1 - p)^j;
    k = 2.^(j - 1);
    E = floor(0.5*(2.^j - k));
    for m = E+1:2^j
       Perr_actual(j) = Perr_actual(j) + nchoosek(2^j,m).*(Psym.^m).*(1 - Psym).^(2^j - m);
    end
end
%%
semilogy(Perr_actual,'b')
hold on
semilogy(Perr_approx,'g')
ylabel('Probability of Error')
xlabel('Symbol Length [bits]')
legend('Actual','CLT Approximation')
