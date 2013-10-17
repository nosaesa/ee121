function [ binary ] = hash2bin( hash )

binary = [];
for i = 1:8
    curr = hash(i);
    switch curr
        case 'a'
            curr = 10;
        case 'b'
            curr = 11;
        case 'c'
            curr = 12;
        case 'd'
            curr = 13;
        case 'e' 
            curr = 14;
        case 'f'
            curr = 15;
        otherwise
            curr = str2double(curr);
    end
    binary = [binary, de2bi(curr, 4, 'left-msb')];

end

