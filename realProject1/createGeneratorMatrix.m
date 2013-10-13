function [G] = createGeneratorMatrix(degree, chunkSize, rate)
    rows = chunkSize/rate;
    columns = chunkSize;
    G = ceil(rand(rows, columns)*degree);
end