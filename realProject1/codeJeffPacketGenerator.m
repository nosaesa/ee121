function [packets] = codeJeffPacketGenerator(G, bits, fieldSize)
    chunkSize = size(G, 2);
    bitMat = reshape(bits, chunkSize, length(bits)/chunkSize);
    packets = reshape(mod(G*bitMat, fieldSize)+1, 1, length(bits)*(size(G,1)/size(G,2)));
end