function [ b ] = zoomout( a, r, c )
%ZOOMOUT Summary of this function goes here
%   Detailed explanation goes here
[n m d] = size(a);
newr = n/r;
newc = m/c;
b = uint8(zeros(newr, newc, d));
for k=1:d
    for i=1:r:n
        for j=1:c:m
            b((i+1)/r, (j+1)/c, k) = a(i, j, k);
        end
    end
end
end