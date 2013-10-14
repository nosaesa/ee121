function [rcv] = recieve(time,fs)
%RECEIVE Record for time
%   Detailed explanation goes here
ar = audiorecorder(fs,16,1,-1);
record(ar),pause(time),stop(ar);
rcv = getaudiodata(ar)';

end