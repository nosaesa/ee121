function [y,numPad] = encodeNewFSK(symbols,fc,N,P,fs)
%ENCODEFSK Encodes a message in orthogonal tones of carriers
%   m MUST BE AN INTEGER MULTIPLE OF L
%   symbols is the message to be sent (string of numbers from field)
%   fc is the base carrier frequency (in Hertz)
%   N is the number of symbols per time step/ # carrier frequencies
%   fs is the sampling rate (in Hertz)
%   P is the number of periods of the fundamental frequency in each
%   waveform. Note that changing P could drastically impact the
%   degree of orthogonality of the signals and thus Pr[err]. Generally
%   speaking, a P = fc will make all signals perfectly orthogonal if
%   integer frequencies are used.
%   T is duration of tone being transmitted

% zero-padding the symbols to make dimensions work
n = length(symbols);
numSteps = floor(n/N);
numPad = 0;
if mod(n,N) ~= 0
    numSteps = numSteps + 1;
    numPad = N*numSteps - n;
    symbols = [symbols zeros(1,numPad)];
end

T = P/fc;
t = 0:1/fs:T-1/fs;
stepLength = length(t);

D = (reshape(symbols,N,numSteps))';

y = zeros(numSteps,stepLength);
k = 0:N-1;
step = k/N;

% constructing (s + delta/N), where:
% s is the symbol value {0,..,7}
% delta is the symbol position {0,...,N-1}
% we add 1 at the end to make s \in {1,...,8}
% otherwise, s = 0 would have no tone
R = D + repmat(step,numSteps,1) + 1;

F = 2*pi*fc*R;
for i = 1:N
    Q = F(:,i)*t;
    y = y + (1/N)*cos(Q);
end
end