function [bits] = file2Bits(filepath)
    fid = fopen(filepath);
    bits = abs(fread(fid, inf, 'bit1'));
    fclose(fid);
    
end