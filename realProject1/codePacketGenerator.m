function [packets] = codePacketGenerator(G, bits, fieldSize)
    chunkSize = size(G, 2);
    packets = [];
    for i = 0:length(bits)/chunkSize-1
        start = i*chunkSize + 1;
        packets = [packets; G*bits(start:start+chunkSize-1)];
    end
    packets = mod(packets, fieldSize);
end