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
%%Tests for turning a file into bits, and then bits into a file

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
