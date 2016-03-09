function [ b ] = halftoning( a, l)
%HALFTONING Summary of this function goes here
%   Detailed explanation goes here
[n m d] = size(a);
b = uint8(zeros(n, m ,d));
for i=1:n
    for j=1:m
        new_pixel = floor(a(i,j)/2^l);
        b(i,j) = new_pixel;
%        q_er = a(i,j) - new_pixel;
        if(i<l)
            b(i+1,j) = a(i+1,j) + 7/16;
        end
        if(i>1 && j<l)
            b(i-1,j+1) = a(i-1,j+1) + 3/16;
        end
        if(j<l)
            b(i,j+1) = a(i,j+1) + 5/16;
        end
        if(i<l && j<l)
            b(i+1,j+1) = a(i+1,j+1) + 1/16;
        end
    end
end
end