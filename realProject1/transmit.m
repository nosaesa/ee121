function transmit(Z,fs)
%TRANSMIT Spit it out motherfucker
Z = Z';
sound(Z(1:end),fs);
end