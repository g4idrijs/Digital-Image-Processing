function [ b ] = lapog( a )
%LOG Summary of this function goes here
%   Detailed explanation goes here
    b = uint8(conv2(fspecial('laplacian'), a));
end

