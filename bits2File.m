function outfile = bits2File(bits, filepath)
    fid = fopen(filepath, 'w');
    outfile = fwrite(fid, -1.*bits, 'bit1');
    fclose(fid);
    
end