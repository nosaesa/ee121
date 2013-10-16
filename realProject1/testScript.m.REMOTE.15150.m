%% Add some tests here to run before you push anything.

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