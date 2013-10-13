function [bits] = bits2File(filepath)
    fid = fopen(filepath);
    bits = abs(fread(fid, inf, 'bit1'));
    fclose(fid);
    
end