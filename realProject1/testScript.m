%% Add some tests here to run before you push anything.
clear all; close all; clc;

%% Tests for generator matrix
fieldSize = 7;
chunkSize = 4;
rate = .5;
G = createGeneratorMatrix(fieldSize, chunkSize, rate);

if (sum(sum(G > fieldSize)) || size(G,1) ~= chunkSize/rate || size(G,2) ~= chunkSize)  
    fprintf('ERROR in generator matrix.\n');
else
    fprintf('Generator matrix is good!\n');
end

%% Tests for packet generation
bits = randi(2, chunkSize*4, 1) - 1;
symbols = codePacketGenerator(G, bits, fieldSize);

if (length(symbols) ~= length(bits)/rate || sum(symbols > fieldSize))
    fprintf('ERROR in packet generation.\n');
else
    fprintf('Packet generation is good!\n');
end
%% Tests for turning a file into bits, and then bits into a file

filein = 'sahai.jpg';
testbits = file2Bits(filein);
image1 = imread(filein);

fileout = 'sahaiout.jpg';
newfile = bits2File(testbits, fileout);
image2 = imread(fileout);

diff = image1 - image2;
if ( sum(sum(diff)) == 0)
    fprintf('Image to and from binary works');
else
    fprintf('ERROR in image to and from binary works'); 
end

%% Test packet decoding
[~, vecs, binary] = makeLookupTable(G, fieldSize);

out = decodePackets(symbols', vecs, binary, chunkSize/rate);

if (sum(out ~= bits) ~= 0)
    fprintf('ERROR in decoding of packets.\n');
else
    fprintf('Packet decoding is good!\n');
end

%% Tests for encoding symbols
P = 1;
m = [1:5 1:5];
fc = 400;
T = P/fc;
fs = 48000;
t = 0:1/fs:T-1/fs;
chunkLength = 5;
out = encodeFSK(m,fc,chunkLength,P,fs);
test = zeros(1,length(t));
test = cos(2*pi*400*t)/5 + cos(2*pi*880*t)/5 + cos(2*pi*1360*t)/5 + cos(2*pi*1840*t)/5 + cos(2*pi*2320*t)/5;
if (abs(sum(out(1,:) - test)) > 1e-5)
    fprintf('ERROR in encoding symbols.\n');
else
    fprintf('Symbol encoding is good!\n');
end

%% Another test for encoding symbols

P = 1;
m = [1:5 5:-1:1 1:5 5:-1:1];
fc = 400;
T = P/fc;
fs = 48000;
t = 0:1/fs:T-1/fs;
chunkLength = 5;
out = encodeFSK(m,fc,chunkLength,P,fs);
test = cos(2*pi*400*t)/5 + cos(2*pi*880*t)/5 + cos(2*pi*1360*t)/5 + cos(2*pi*1840*t)/5 + cos(2*pi*2320*t)/5;
test2 = cos(2*pi*2000*t)/5 + cos(2*pi*1680*t)/5 + cos(2*pi*1360*t)/5 + cos(2*pi*1040*t)/5 + cos(2*pi*720*t)/5;
if (abs(sum(out(1,:) - test)) > 1e-5 || abs(sum(out(3,:) - test)) > 1e-5 || abs(sum(out(2,:) - test2)) > 1e-5 || abs(sum(out(4,:) - test2)) > 1e-5)
    fprintf('ERROR in encoding symbols.\n');
else
    fprintf('Symbol encoding is good!\n');
end

%% Tests for adding chirps and transmission
fs = 48000;
% Encode this random message then listen for the chirps. There should be 
% a chirp every 5 tones. There should be an inverse chirp at beginning and
% and end and 3 chirps in between.
y = encodeFSK(randi([1 8],1,100),400,5,100,fs);
Z = addChirps(y,5,fs);
transmit(Z,fs);
