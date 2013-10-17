function [ pad ] = computePad(RSratio, messageLength)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
pad=0;
found=0;
while found == 0
  temp = (pad + messageLength) * RSratio;
  if mod(temp, 11) == 0
      found = 1;
  end
pad = pad+1;  
end

end

