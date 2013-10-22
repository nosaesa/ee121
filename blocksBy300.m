clear all; clc;
fs = 48000;
ar = audiorecorder(fs, 16, 1);

[signalOut, inBits, symFSK, bitsEncoded] = transmitFunction2();
%%
%record(ar),pause(0.5),tic,sound(signalOut,fs), pause(length(signalOut)/fs + 1),stop(ar);
%
t = 0:1/fs:1-1/fs;
f = cos(2*pi*400*t);
tic, record(ar),sound(f,fs),pause(1.0001),sound(signalOut,fs),stop(ar);
rcv = getaudiodata(ar, 'double')';
%%
rcv = signalOut;
%
%
[ name, outBits, symbols, errors, time, interBits ] = decodeFunction2( rcv );
dataRate = length(inBits)/time