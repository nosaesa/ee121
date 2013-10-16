function [bits] = decodePackets(packets, codeBookVectors, codeBookStr, packetLength)
    bits = [];
    for i = 0:length(packets)/packetLength - 1
        start = i*packetLength + 1;
        temp = packets(start:start+packetLength-1)';
        index = -1;
        best = 100;
        for j = 1:size(codeBookVectors, 1)
            val = sum(codeBookVectors(j,:) ~= temp);
            if (val < best)
                best = val;
                index = j;
            end
        end
        
        bits = [bits; codeBookStr(index,:)'];
    end
end