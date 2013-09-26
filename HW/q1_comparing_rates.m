% EE 121
% HW 2
% Question 1
% Part f

% Comparing Rates
figure
hold on
for R = [0.5 0.75 0.8]
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
    if R == 0.5
        plot(Perr_min_actual,'b')
    elseif R == 0.75
        plot(Perr_min_actual,'g')
    elseif R == 0.8
        plot(Perr_min_actual,'r')
    end
end
title('Optimal Probability of Error')
ylabel('Probability of Error')
xlabel('Probability of a Single Bit Error')
legend('R = 0.5','R = 0.75','R = 0.8')
