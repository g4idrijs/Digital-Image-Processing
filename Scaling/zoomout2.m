function [ b ] = zoomout2( a, r, c )
%ZOOMOUT2 Summary of this function goes here
%   Detailed explanation goes here
[n m d] = size(a);
newr = n/r;
newc = m/c;
b = uint8(zeros(newr, newc, d));
for k=1:d
    for i=1:newr
        for j=1:newc
           sum = 0;
           for x=0:r-1
               for y=0:c-1
                   sum = sum + a(2*i+x-1, 2*j+y-1, k);
               end
           end
           b(i, j, k) = sum/r*c;
        end
    end
end
end

