function [ c ] = morph( a, b, t )
%MORPH : Morphs image a and b to result in c, t is parameter to generate c
%   features are found of a and b
[n,m,d] = size(a);
b1 = features(a);
b2 = features(b);
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
alltri = zeros(3,3,size(mtri,1),3);
for k=1:size(mtri,1)
    alltri(:,:,k,1) = [mtri(k,1,1) mtri(k,1,2) mtri(k,1,3); mtri(k,2,1) mtri(k,2,2) mtri(k,2,3); 1 1 1];
    alltri(:,:,k,2) = [stri(k,1,1) stri(k,1,2) stri(k,1,3); stri(k,2,1) stri(k,2,2) stri(k,2,3); 1 1 1];
    alltri(:,:,k,3) = [ftri(k,1,1) ftri(k,1,2) ftri(k,1,3); ftri(k,2,1) ftri(k,2,2) ftri(k,2,3); 1 1 1];
end
for i=1:n
    for j=1:m
        for k=1:size(mtri,1)
            if(inpolygon(i,j,[mtri(k,1,1) mtri(k,1,2) mtri(k,1,3)],[mtri(k,2,1) mtri(k,2,2) mtri(k,2,3)])==1)
%                mtri_mat = [mtri(k,1,1) mtri(k,1,2) mtri(k,1,3); mtri(k,2,1) mtri(k,2,2) mtri(k,2,3); 1 1 1];
%                barc = mtri_mat\[i;j;1];
                barc = alltri(:,:,k,1)\[i;j;1];
%                stri_mat = [stri(k,1,1) stri(k,1,2) stri(k,1,3); stri(k,2,1) stri(k,2,2) stri(k,2,3); 1 1 1];
%                sxy = stri_mat*barc;
                sxy = alltri(:,:,k,2)*barc;
%                ftri_mat = [ftri(k,1,1) ftri(k,1,2) ftri(k,1,3); ftri(k,2,1) ftri(k,2,2) ftri(k,2,3); 1 1 1];
%                fxy = ftri_mat*barc;
                fxy = alltri(:,:,k,3)*barc;
                sxy = uint32(sxy);
                fxy = uint32(fxy);
                for l=1:d
                    sx = uint32(sxy(1)/sxy(3));
                    sy = uint32(sxy(2)/sxy(3));
                    fx = uint32(fxy(1)/fxy(3));
                    fy = uint32(fxy(2)/fxy(3));
%                     if(fx==0)
%                         fx = 1;
%                     end
%                     if(fy==0)
%                         fy = 1;
%                     end
%                     if(fx>n)
%                         fx = n;
%                     end
%                     if(fy>m)
%                         fy = m;
%                     end
%                     if(sx==0)
%                         sx = 1;
%                     end
%                     if(sy==0)
%                         sy = 1;
%                     end
%                     if(sx>n)
%                         sx = n;
%                     end
%                     if(sy>m)
%                         sy = m;
%                     end
                    c(i,j,l) = (1-t)*a(uint32(sx),uint32(sy),l) + t*b(uint32(fx),uint32(fy),l);
%                    c(i,j,l) = a(sx,sy,l);
%                    c(i,j,l) = b(fx,fy,l);
                end
                break;
            end
        end
    end
end
end
