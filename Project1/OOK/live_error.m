w = zeros(1,11);
for i = 1:11
    w(i) = mean([x1(i) x2(i) x3(i) x4(i) x5(i) x6(i) x7(i)]);
end
plot(w(end:-1:1))