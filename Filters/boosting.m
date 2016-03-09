function [ b ] = boosting( a, g )
%BOOSTING is done along high-boost filtering.
%Part of Assignment1
a = double(a);
[n, m] = size(a);
uni = [1 1 1; 1 1 1; 1 1 1];
avga = conv2(uni, a);
maskd = a - avga(2:n+1, 2:m+1)/9;
b = a+g*maskd;
b = uint8(b);
end