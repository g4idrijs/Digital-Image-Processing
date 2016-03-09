function [ c ] = warp( a, b, t )
%WARP Summary of this function goes here
%   Detailed explanation goes here
[n,m,d] = size(a);
fa = [1 1; 211 13; 400 1; 77 236; 150 253; 253 248; 321 233; 204 311; 166 353; 252 345; 1 500; 211 431; 400 500];
fb = [1 1; 195 26; 400 1; 70 162; 137 181; 259 183; 340 157; 193 263; 146 316; 250 316; 1 500; 199 398; 400 500];
fa_tri = delaunay(fa);
fb_tri = delaunay(fb);
%different sizes of fa_tri and fb_tri case not considered
stri = zeros(size(fa_tri,1), 2, 3);
ftri = zeros(size(fb_tri,1), 2, 3);
mtri = zeros(min(size(stri,1), size(ftri,1)), 2, 3);
c = uint8(zeros(n,m,d));
for i=1:size(fa_tri,1)
    for j=1:3
        stri(i,2,j) = fa(fa_tri(i,j),1);
        stri(i,1,j) = fa(fa_tri(i,j),2);
    end
end
for i=1:size(fb_tri,1)
    for j=1:3
        ftri(i,2,j) = fb(fa_tri(i,j),1);
        ftri(i,1,j) = fb(fa_tri(i,j),2);
    end
end
for i=1:size(mtri,1)
    for j=1:3
        mtri(i,1,j) = (1-t)*stri(i,1,j) + t*ftri(i,1,j);
        mtri(i,2,j) = (1-t)*stri(i,2,j) + t*ftri(i,2,j);
    end
end
for i=1:n
    for j=1:m
        for k=1:size(mtri,1)
            if(inpolygon(i,j,[mtri(k,1,1) mtri(k,1,2) mtri(k,1,3)],[mtri(k,2,1) mtri(k,2,2) mtri(k,2,3)])==1)
                amat = [mtri(k,1,2)-mtri(k,1,1) mtri(k,1,3)-mtri(k,1,1); mtri(k,2,2)-mtri(k,2,1) mtri(k,2,3)-mtri(k,2,1)];
                bmat = [i-mtri(k,1,1); j-mtri(k,2,1)];
                lamdax = linsolve(amat, bmat);
                lamda = [1-lamdax(1)-lamdax(2); lamdax(1); lamdax(2)];
                for l=1:d
                    c(i,j,l) = lamda(1)*a(uint32(stri(k,1,1)),uint32(stri(k,2,1)),l)+lamda(2)*a(uint32(stri(k,1,2)),uint32(stri(k,2,2)),l)+ lamda(3)*a(uint32(stri(k,1,3)),uint32(stri(k,2,3)),l);
                end
            end
        end
    end
end

end