function [ b ] = features( a )
%FEATURES : returns b as the features corresponding to the image a
%   b is (10,2) matrix having feature points of image a as (x,y)
%   coordinates
[n,m,d] = size(a);
b = rand(10,2);
b(:,1) = b(:,1)*n;
b(:,2) = b(:,2)*m;
b1 = [1 1; 211 13; 400 1; 77 236; 150 253; 253 248; 321 233; 204 311; 166 353; 252 345; 211 431; 1 500; 400 500];
b2 = [1 1; 195 26; 400 1; 70 162; 137 181; 259 183; 340 157; 193 263; 146 316; 250 316; 199 398; 1 500; 400 500]; 
end