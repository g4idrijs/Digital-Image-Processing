function [ b ] = zoomin2( a, n, m )
%ZOOMIN2 Summary of this function goes here
%   Detailed explanation goes here
[r c d ] = size(a);
newr = n*r;
newc = m*c;
b = zeros(newr, newc, d);
for k=1:d
    for i=1:n:newr
        for j=1:m:newc
            b(i,j,k) = a((i+n-1)/n, (j+m-1)/m, k);
        end
    end
    for i=1:n:newr-n
        for j=1:m:newc-m
            for t=0:n-1
                for s=0:m-1
                    c = [1 i j i*j; 1 i j+m i*(j+m); 1 i+n j (i+n)*j; 1 i+n j+m (i+n)*(j+m)];
                    d = [b(i, j, k); b(i, j+m, k); b(i+n, j, k); b(i+n, j+m, k)];
                    x = c\d;
                    b(i+t, j+s, k) = x(1) + x(2)*(i+t) + x(3)*(j+s) + x(4)*(i+t)*(j+s);
                end
            end
        end
    end
end
b = uint8(b);
imshow(b)
end