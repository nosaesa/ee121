% EE 121
% HW 2
% Problem 1
% Part e

%% Approximate Probability of Error
prob = 0.01:0.01:0.9;
minJ_approx = zeros(1,length(prob));
for p = prob
    j = 1:10;
    k = 2.^(j - 1);
    n = 2.^j;
    Psym = 1 - (1 - p).^j;
    mu = Psym;
    E = floor(0.5*(2.^j - k));
    sigma = sqrt(Psym.*(1 - Psym));
    Perr_approx = qfunc((E - n.*mu)./(sigma.*sqrt(n)));
    minJ_approx(floor(p*100)) = find(Perr_approx == min(Perr_approx));
end
%% Actual Probability of Error
prob = 0.01:0.01:0.9;
minJ_actual = zeros(1,length(prob));
for p = prob
    n = 10;
    Perr_actual = zeros(1,n);
    for j = 1:n
        Psym = 1 - (1 - p)^j;
        k = 2.^(j - 1);
        E = floor(0.5*(2.^j - k));
        for m = E+1:2^j
           Perr_actual(j) = Perr_actual(j) + nchoosek(2^j,m).*(Psym.^m).*(1 - Psym).^(2^j - m);
        end
    end
    minJ_actual(floor(p*100)) = find(Perr_actual == min(Perr_actual));
end
%%
plot(minJ_actual,'b')
hold on
plot(minJ_approx,'g')
title('Optimal Symbol Length')
ylabel('Symbol Length [bits]')
xlabel('Probability of a Single Bit Error')
legend('Actual','CLT Approximation')
