function out = transmit(Z,fs,suppressAudio)
%TRANSMIT Spit it out motherfucker
Z = Z';
t = 0:1/fs:0.02;
pulse = chirp(t,600,0.02,2000,'linear');
out = [pulse Z(length(t)+1:end) pulse];
if ~suppressAudio
    sound(out ,fs);
end

%-----TEST CODE JUNK THROW AWAY IF NOT IN USE
%{
A = [pulse Z(length(t)+1:end) pulse];
c = xcorr(A,pulse);
c = fftshift(abs(c));
c = c(1:length(c)/2);
% plot(c); hold on;figure;
% pulse = chirp(t,400,0.02,8000,'linear');
% c = xcorr(A,pulse);
% c = fftshift(abs(c));
% c = c(1:length(c)/2);
plot(c,'g');
[sortedValues,sortIndex] = sort(c(:),'descend');
maxIndex = sortIndex(1:5)
maxVals = sortedValues(1:5)
%}
end