function [G] = createJeffGeneratorMatrix(degree, chunkSize, rate)
    rows = chunkSize/rate;
    columns = chunkSize;
    G = randi([1 degree], rows, columns);
end