function [scramble] = timsCoolFunction(mat)
    [rows, cols] = size(mat);
    temp = reshape(mat, cols, rows);
    scramble = reshape(temp', rows, cols);
end