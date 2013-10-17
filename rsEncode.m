function [ c ] = rsEncode( message )
%   rsEncode encodes symbols \in {1,...,2^m} in a Reed-Solomon code
%   message is the array of symbols to be encoded
%   numBits is the number of bits required to represent a symbol
%   numErrors is the desired number of tolerable errors
if (size(message,2) ~= 1)
    message = message';
end
<<<<<<< HEAD

%find k
l = length(message);
k = 1;
switch l
    case mod(l,5) == 0
        k = 5;
    case mod(l, 4) == 0
        k = 4;
    case mod(l, 3) == 0
        k = 3;
    case mod(l, 2) == 0
        k = 2;
end
H = comm.RSEncoder('PrimitivePolynomialSource', 'Property', 'PrimitivePolynomial', fliplr(de2bi(primpoly(3))), 'MessageLength', k, 'CodewordLength', k+2);
=======
%fuck = rsgenpoly(numErrors+length(message),length(message))
%H = comm.RSEncoder(length(message)+2*numErrors,length(message));
H = comm.RSEncoder('GeneratorPolynomial', numErrors+length(message), length(message))
>>>>>>> eaff9020e729f74aea377fdfedb2164e56402a76
c = step(H,message);

end

