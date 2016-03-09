function [ b ] = premediancut( a )
%MEDIANCUT Summary of this function goes here
%   Detailed explanation goes here
    [n,m,d] = size(a);
    b = zeros(n*m, d);
    for i=1:n
        for j=1:m
            for k=1:d
                b(m*(i-1)+j, k) = a(i, j, k);
            end
        end
    end
    b = {b};
end