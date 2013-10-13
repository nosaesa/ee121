%% Run once before beginning:

x = zeros(11,10);
live_error = zeros(1,11);
ar = audiorecorder(fs, 16, 1);

%% Run for each volume in 0:5:50:

% Set volume:
volume = 50;
vol_num = volume/5 + 1;

fs = 10000;
fc = 200;

% r = number of bits
r = 3;

for i = 1:10
    % Generate random bit string and encode
    b = randi([1 2^r],1,1);
    
    y = encodeFSK(b,r,fc,fs);
    t = (0:3*fs-1)/fs;
    preamble = sin(2*pi*60*(t.^4)/2);
    signal = [preamble y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y];
    % Play encoded signal and simultaneously record
    record(ar), sound(signal,fs), stop(ar);
    rcv = getaudiodata(ar, 'double')';

    % Normalize received signal
    rcv = rcv/max(rcv);
    
    corr = fftfilt(preamble(end:-1:1),rcv);
    idx_begin = find(abs(corr)==max(abs(corr(:)))) + length(preamble) + 1;
    data = rcv(idx_begin:end);

    % Decode and compute error
    c = decodeFSK(data,r,fc,fs);
    if c ~= b
        x(vol_num,i) = 1;
    else
        x(vol_num,i) = 0;
    end
end

%% Generate average error probability vector
for i = 1:11
    live_error(i) = mean(x(i,:));
end
% plot(live_error);