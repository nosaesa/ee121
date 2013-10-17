function [A] = synchro(rcv,packLength,fs,fc,P,chirpLength)
%SYNCHRONIZE Find chirps then extract packet streams from rcv

% packLength = number of time steps per packet

t = 0:1/fs:chirpLength;
timeStep = 0:1/fs:P/fc-1/fs;
packLengthSamples = (packLength)*length(timeStep) + length(t);
% packLengthSamples is the number of samples in a packet (with pulse)
SSpulse = chirp(t,6000,chirpLength,600,'linear');
syncPulse = chirp(t,400,chirpLength,8000,'linear');
% Get pulse to start and stop data transmission%
%SSpulse = [SSpulse zeros(1,length(rcv)-length(SSpulse))];
startStop = xcorr(rcv,SSpulse);
startStop = fftshift(abs(startStop));
startStop = startStop(1:round(length(startStop)/2));
%[~,sortIndex] = sort(startStop(:),'descend');
[~,sortIndex] = sort(startStop(:),'descend');
maxIndex = [sortIndex(1) 0];
epsilon = 200;
for i = 2:length(sortIndex);
    if abs(sortIndex(i) - maxIndex(1)) > epsilon
        maxIndex(2) = sortIndex(i);
        break
    end
end
startSample = min(maxIndex);
endSample = max(maxIndex) - 1;
%-----------------------------------------------
% Find the actual peaks in the signal and create expected packets
messageLength = endSample - startSample;
numPeaks = round(messageLength/packLengthSamples); %floor or round
syncorr = xcorr(rcv,syncPulse);
syncorr = fftshift(abs(syncorr));
syncorr = syncorr(1:round(length(syncorr)/2));
%syncPeaks = [startSample zeros(1, numPeaks)];
syncPeaks = [startSample zeros(1, numPeaks-1)];
[~,sortIndex] = sort(syncorr(:),'descend');
peaks = 2;
for i = 1:length(sortIndex)
    if max(abs(sortIndex(i) - find(syncPeaks))) > epsilon
        syncPeaks(peaks) = sortIndex(i);
        peaks = peaks + 1;
        if peaks > numPeaks
            break
        end
    end
end
syncPeaks = sort(syncPeaks);
syncPeaks = syncPeaks + 1;
% syncPeaks is now the indices of syncPulses in recieved signal rcv
% A will be a matrix of Extracted Packets
A = zeros(length(numPeaks),(packLength)*length(timeStep));
for i = 1:numPeaks;
    A(i,:) = [rcv((syncPeaks(i) + length(t)):(syncPeaks(i) + packLengthSamples - 1))];
end
end