function [y,numPad] = encodeNewFSK(symbols,fc,N,P,fs)
%ENCODEFSK Encodes a message in orthogonal tones of carriers
%   m MUST BE AN INTEGER MULTIPLE OF L
%   symbols is the message to be sent (string of numbers from field) and is
%   a 2D matrix
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
T = P/fc;
t = 0:1/fs:T-1/fs;
stepLength = length(t);
numFileChunks = size(symbols, 1);

n = size(symbols, 2);
numSteps = floor(n/N);
y = zeros(numSteps, stepLength, size(symbols, 1));
numPad = zeros(numFileChunks, 1);

for w = 1:size(symbols, 1)
    
    if mod(n,N) ~= 0
        numPad(w) = N*numSteps - n;
        symbols(w,:) = [symbols(w,:) zeros(1,numPad)];
    end
    
    
    
    D = (reshape(symbols(w,:),N,numSteps))';
    
    
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
        y(:,:,w) = y(:,:,w) + (1/N)*cos(Q);
    end
end
end
