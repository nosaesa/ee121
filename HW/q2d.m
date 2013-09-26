% EE 121
% HW 2
% Question 2
% Part d

epsilon = 0.1;
p = 2/3;
beta = p - epsilon;
alpha = p + epsilon;


n = 100;
Ptypical_actual = 0;
for i = ceil(n*beta):floor(n*alpha)
    Ptypical_actual = Ptypical_actual + nchoosek(n,i).*((2/3).^i).*((1/3).^(n - i));
end

mu = 2/3;
sigma = sqrt((2/3)*(1 - 2/3));

Ptypical_approx = normcdf((n*alpha - n*mu)./(sigma*sqrt(n))) - normcdf((n*beta - n*mu)./(sigma*sqrt(n)));
