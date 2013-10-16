function [table, vecs, bi] = makeJeffLookupTable(G, fieldSize)
    bits = size(G, 2);
    strings = [];
    vecs = [];
    bi = [];
    for i = 0:2^bits-1
       temp = dec2bin(i);
       if (length(temp) < bits)
           for j = 1:bits-length(temp)
               temp = strcat('0', temp);
           end
       end
       a = [];
       for k = 1:bits
            a = [a str2double(temp(k))];
       end
       symbols = mod(G*a', fieldSize) + 1;
       strings{i+1} = {a', symbols};
       vecs = [vecs; symbols'];
       bi = [bi; a];
    end
    table = strings;
end