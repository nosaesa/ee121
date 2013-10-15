function [A] = synchro(rcv,packLength,fs,fc,P)
%SYNCHRONIZE Find chirps then extract packet streams from rcv

t = 0:1/fs:0.02;
timeStep = 0:1/fs:P/fc-1/fs;
packLengthSamples = (packLength)*length(timeStep) + length(t);
% packLengthSamples is the number of samples in a packet (with pulse)
SSpulse = chirp(t,600,0.02,2000,'linear');
syncPulse = chirp(t,400,0.02,8000,'linear');
% Get pulse to start and stop data transmission%
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
startSample = min(maxIndex) + 1;
endSample = max(maxIndex) - 1;
keyboard;
%-----------------------------------------------
% Find the actual peaks in the signal and create expected packets
messageLength = endSample - startSample;
numPeaks = round(messageLength/packLengthSamples); %floor or round
syncorr = xcorr(rcv,syncPulse);
syncorr = fftshift(abs(syncorr));
syncorr = syncorr(1:round(length(syncorr)/2));
syncPeaks = [startSample zeros(1, numPeaks)];
[~,sortIndex] = sort(syncorr(:),'descend');
peaks = 2;
for i = 1:length(sortIndex)
    if max(abs(sortIndex(i) - find(syncPeaks)) > epsilon)
        syncPeaks(peaks) = sortIndex(i);
        peaks = peaks + 1;
        if peaks > numPeaks
            break
        end
    end
end
plusOne = ones(1,length(syncPeaks));
plusOne(1) = 0;
syncPeaks = syncPeaks + plusOne;
% syncPeaks is now the indices of syncPulses in recieved signal rcv
% A will be a matrix of Extracted Packets
for i = 1:numPeaks;
    A(i,:) = [rcv((syncPeaks(i) + length(t)):(syncPeaks(i) + packLengthSamples - 1))];
end
end