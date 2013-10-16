function [G] = createGeneratorMatrix(degree, chunkSize, rate)
    rows = chunkSize/rate;
    columns = chunkSize;
    G = randi([0 degree-1], rows, columns);
end