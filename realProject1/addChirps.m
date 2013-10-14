function [Z] = addChirps(Y,packLength,fs)
%ADDCHIRPS Adds chirps to the beginning of each row of Y
%   Detailed explanation goes here
%   packLength is the number of timesteps (rows of Y) per packet.
%   Each packet gets a chirp preamble for synchronization.
if mod(size(Y,1),packLength) ~= 0
    error('addChirps:packLength must be a factor of timestep length (size(Y,1))')
end
q = size(Y,1)/packLength;
Y = reshape(Y',size(Y,2)*packLength,q)';
t = 0:1/fs:0.02;
pulse = chirp(t,400,0.02,8000,'linear');
pulses = repmat(pulse,q,1);
Z = [pulses Y];
end
