%% Run once before beginning:

x = zeros(11,10);
live_error = zeros(1,11);
fs = 10000;
fc = 200;
T = 1/fc;
r = 3;
ar = audiorecorder(fs, 16, 1);

%% Run for each volume in 0:5:50:

% Set volume:
r = 11;
volume = 0;
vol_num = volume/5 + 1;

for i = 1:10
    % Generate random bit string and encode
    b = randi([1 2^r],1,1);
    
    y = encodeFSK(b,r,fc,fs);

    signal = [y y y y y y y y y y y y y y y y y y y y y y y y y y y y y y];
    
    % Play encoded signal and simultaneously record
    record(ar), sound(signal,fs), stop(ar);
    rcv = getaudiodata(ar, 'double')';

    % Normalize received signal
    rcv = rcv/max(rcv);
    
    thresh = 0.9;
    t = find(rcv > thresh);
    index = t(1);
    rcv = rcv(index:index+(T*fs)-1);

    % Decode and compute error
    c = decodeFSK(rcv,r,fc,fs);
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
plot(live_error);