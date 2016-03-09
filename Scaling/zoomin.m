function [ b ] = zoomin( a, n, m )
%ZOOMIN Summary of this function goes here
%   Detailed explanation goes here
[r,c,d] = size(a);
newr = n*r;
newc = m*c;
b = uint8(zeros(newr, newc, d));
for i=1:n:newr
   for j=1:m:newc
       for t=0:n-1
           for s=0:m-1
               for k=1:d
                   b(i+t,j+s,k) = a((i+n-1)/n, (j+m-1)/m, k);
               end
           end
       end
   end
end
imshow(b)
end