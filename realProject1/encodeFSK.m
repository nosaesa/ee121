function [y] = encodeFSK(m,fc,L,P,fs)
%ENCODEFSK Encodes a message in orthogonal tones of carriers
%   m MUST BE AN INTEGER MULTIPLE OF L
%   m is the message to be sent (string of numbers from field)
%   fc is the base carrier frequency (in Hertz)
%   L is the number of symbols per time step/ # carrier frequencies
%   fs is the sampling rate (in Hertz)
%   P is the number of periods of the fundamental frequency in each
%   waveform. Note that changing P could drastically impact the
%   degree of orthogonality of the signals and thus Pr[err]. Generally
%   speaking, a P = fc will make all signals perfectly orthogonal if
%   integer frequencies are used.
%   T is duration of tone being transmitted
if mod(length(m),L) ~= 0
    error('encodeFSK:message length must be multiple of chunk size')
end
T = P/fc;
t = 0:1/fs:T-1/fs;
n = length(m);
chunks = n/L;
D = reshape(m,chunks,L);
y = zeros(chunks,length(t));
k = 0:L-1;
step = k/L;
R = D + repmat(step,chunks,1);
F = 2*pi*fc*R;
for i = 1:L
    Q = F(:,i)*t;
    y = y + cos(Q);
end
end
