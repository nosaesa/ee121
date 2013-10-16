function [Z] = addChirps(Y,timeStepsPerPacket,fs,chirpLength)
%ADDCHIRPS Adds chirps to the beginning of each row of Y
%   Detailed explanation goes here
%   packLength is the number of timesteps (rows of Y) per packet.
%   Each packet gets a chirp preamble for synchronization.

if mod(size(Y,1),timeStepsPerPacket) ~= 0
    error('addChirps:timeStepsPerPacket must be a factor of number of timesteps (size(Y,1))')
end

numPackets = size(Y,1)/timeStepsPerPacket;
%numTimeSteps = size(Y,1)/numPackets;

Y = reshape(Y',size(Y,2)*timeStepsPerPacket,numPackets)';

t = 0:1/fs:chirpLength;
pulse = chirp(t,400,chirpLength,8000,'linear');
pulses = repmat(pulse,numPackets,1);

Z = [pulses Y];
end
