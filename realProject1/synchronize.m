function [A] = synchronize(rcv,packlength,fs)
%SYNCHRONIZE Find chirps and get data streams from rcv
%   Detailed explanation goes here
t = 0:1/fs:0.02;
SSpulse = chirp(t,600,0.02,2000,'linear');
syncPulse = chirp(t,400,0.02,8000,'linear');
% Get pulse to start and stop data transmission%
startStop = xcorr(rcv,SSpulse);
startStop = fftshift(abs(startStop));
startStop = startStop(1:length(startStop)/2);
[~,sortIndex] = sort(startStop(:),'descend');
maxIndex = [sortIndex(1) 0];
epsilon = 200
for i = sortIndex(2:end)
    if abs(i - maxIndex(1)) > epsilon
        maxIndex(2) = i;
        break
    end
end
startSample = min(maxIndex) + length(t) + 1;
endSample = max(maxIndex) - 1;
%-----------------------------------------------


ends = [];
end