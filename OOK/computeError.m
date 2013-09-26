function y = computeError(c,b)
y=[];
for i = 1:min(length(b),length(c))
    y = [y (c(i) - b(i))^2];
end
y = sum(y)/length(b);
end
