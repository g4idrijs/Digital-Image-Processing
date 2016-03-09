function [ b ] = embossing( a )
%EMBOSSING filter implemented using 3x3 emboss mask
%Part of assignment1
%NotCompleted
    mk = [-1 -1 0; -1 0 1; 0 1 1];
    b = conv2(mk,a);
    b = uint8(b);
end