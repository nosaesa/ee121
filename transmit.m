function out = transmit(Z,fs,chirpLength)
Z = reshape(Z',size(Z,1)*size(Z,2),1)';
t = 0:1/fs:chirpLength;
pulse = chirp(t,6000,chirpLength,600,'linear');
out = [pulse Z(length(t)+1:end) pulse];
end