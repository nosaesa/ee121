%% Run once before beginning:

x = zeros(11,10);
live_error = zeros(1,11);

%% Run for each volume in 0:5:50:

% Set volume:
volume = 0;
vol_num = volume/5 + 1;

fs = 2000;

for i = 1:10
    % Generate random bit string and encode
    b = randi([0 1],1,10);
    
    % Add a "synchronization bit" to ensure the first information
    % bit is not missed during decoding if it is a zero    
    b = [1 b];
    signal = encodeOOK(b,fs);

    % Play encoded signal and simultaneously record
    ar = audiorecorder(fs, 16, 1);
    record(ar), sound(signal,fs), stop(ar);
    rcv = getaudiodata(ar, 'double')';

    % Normalize received signal
    rcv = rcv/max(rcv);

    % Ignore "synchronization bit"
    thresh = 0.8;
    t = find(rcv > thresh);
    index = t(1) + fs/4 - 1;
    rcv = rcv(index:end);

    % Decode and compute error
    c = decodeOOK(rcv,fs);
    q = computeError(c,b);
    x(vol_num,i) = q;
end

%% Generate average error probability vector
for i = 1:11
    live_error(i) = mean(x(i,:));
end
% plot(live_error);