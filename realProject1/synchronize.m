function [A] = synchronize(rcv,packLength,fs,fc,P)
%SYNCHRONIZE Find chirps and get data streams from rcv

t = 0:1/fs:0.02;
timeStep = 0:1/fs:P/fc-1/fs;
packLengthSamples = (packLength)*length(timeStep) + length(t);
% packLengthSamples is the number of samples in a packet (with pulse)
SSpulse = chirp(t,600,0.02,2000,'linear');
syncPulse = chirp(t,400,0.02,8000,'linear');
% Get pulse to start and stop data transmission%
startStop = xcorr(rcv,SSpulse);
startStop = fftshift(abs(startStop));
startStop = startStop(1:length(startStop)/2);
[~,sortIndex] = sort(startStop(:),'descend');
maxIndex = [sortIndex(1) 0];
epsilon = 200;
for i = sortIndex(2:end)
    if abs(i - maxIndex(1)) > epsilon
        maxIndex(2) = i;
        break
    end
end
startSample = min(maxIndex);
endSample = max(maxIndex) - 1;
%-----------------------------------------------
% Find the actual peaks in the signal and create expected packets
messageLength = endSample - startSample;
numPeaks = round(messageLength/packLengthSamples); %floor or round
i = 0:numPeaks-1;
syncorr = xcorr(rcv,syncPulse);
syncorr = fftshift(abs(syncorr));
syncorr = syncorr(1:length(syncorr)/2);
syncPeaks = [startSample zeros(1, numpeaks - 1)]
[~,sortIndex] = sort(syncorr(:),'descend');
peaks = 1;
for i = sortIndex 
    if max(abs(i - find(syncPeaks)) > epsilon
        
        peaks = peaks + 1
        if peaks >= numPeaks
            break
        end
    end
end

end