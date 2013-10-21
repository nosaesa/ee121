clear all; clc;
fs = 48000;
ar = audiorecorder(fs, 16, 1);

[signalOut, inBits, symFSK, bitsEncoded] = transmitFunction();

record(ar),pause(0.5),tic,sound(signalOut,fs), pause(length(signalOut)/fs + 1),stop(ar);
rcv = getaudiodata(ar, 'double')';
%%rcv = signalOut;
[ name, outBits, symbols, errors, time, interBits ] = decodeFunction( rcv );
dataRate = length(inBits)/time