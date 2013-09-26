% EE 121
% HW 2
% Problem 1
% Part f

%% Varying the Rate
% Run for R = 0.5, 0.75, 0.8
R = 0.5;
%% Approximate Probability of Error
prob = 0.01:0.01:0.9;
minJ_approx = zeros(1,length(prob));
for p = prob
    j = 1:10;
    n = 2.^j;
    k = R*n;
    Psym = 1 - (1 - p).^j;
    mu = Psym;
    E = floor(0.5*(2.^j - k));
    sigma = sqrt(Psym.*(1 - Psym));
    Perr_approx = qfunc((E - n.*mu)./(sigma.*sqrt(n)));
    %minJ_approx(floor(p*100)) = find(Perr_approx == min(Perr_approx));
    minJ_approx(floor(p*100)) = min(Perr_approx);
end
Perr_min_approx = zeros(1,90);
for i = 1:90
    p = prob(i);
    j = minJ_approx(i);
    n = 2.^j;
    k = R*n;
    Psym = 1 - (1 - p).^j;
    mu = Psym;
    E = floor(0.5*(2.^j - k));
    sigma = sqrt(Psym.*(1 - Psym));
    Perr_min_approx(i) = qfunc((E - n.*mu)./(sigma.*sqrt(n)));
end
%% Actual Probability of Error
prob = 0.01:0.01:0.9;
minJ_actual = zeros(1,length(prob));
for p = prob
    Perr_actual = zeros(1,10);
    for j = 1:10
        Psym = 1 - (1 - p)^j;
        n = 2.^j;
        k = R*n;
        E = floor(0.5*(2.^j - k));
        for m = E+1:2^j
           Perr_actual(j) = Perr_actual(j) + nchoosek(2^j,m).*(Psym.^m).*(1 - Psym).^(2^j - m);
        end
    end
    minJ_actual(floor(p*100)) = find(Perr_actual == min(Perr_actual));
end
Perr_min_actual = zeros(1,90);
for i = 1:90
    p = prob(i);
    j = minJ_actual(i);
    Perr_actual = 0;
    Psym = 1 - (1 - p)^j;
    n = 2.^j;
    k = R*n;
    E = floor(0.5*(2.^j - k));
    for m = E+1:2^j
       Perr_actual = Perr_actual + nchoosek(2^j,m).*(Psym.^m).*(1 - Psym).^(2^j - m);
    end
    Perr_min_actual(i) = Perr_actual;
    
end
%%
figure
plot(minJ_actual,'b')
hold on
plot(minJ_approx,'g')
title('Optimal Symbol Length')
ylabel('Symbol Length [bits]')
xlabel('Probability of a Single Bit Error')
legend('Actual','CLT Approximation')

figure
plot(Perr_min_actual,'b')
hold on
plot(Perr_min_approx,'g')
title('Optimal Probability of Error')
ylabel('Probability of Error')
xlabel('Probability of a Single Bit Error')
legend('Actual','CLT Approximation')
