% EE 121
% HW 2
% Question 2
% Part f

epsilon = 0.1;
p = 2/3;
beta = p - epsilon;
alpha = p + epsilon;


n = 100;
Stypical_actual = 0;
for i = ceil(n*beta):floor(n*alpha)
    Stypical_actual = Stypical_actual + nchoosek(n,i);
end

H = (2/3)*log2(3/2) + (1/3)*log2(3);

Stypical_approx = 2.^(n*(H + epsilon));
