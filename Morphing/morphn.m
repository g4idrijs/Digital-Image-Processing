function [ ret ] = morphn( ar )
%MORPHN function to morph an array of images,
% Generalization of moprh function
[n,m,len] = size(ar);
d=1;
feature_ar = zeros(13, 2, len);
for i=1:len
%    feature_ar(:,:,i) = features(ar(:,:,:,i));
end
feature_ar(:,:,1) = [1 1; 211 13; 400 1; 77 236; 150 253; 253 248; 321 233; 204 311; 166 353; 252 345; 1 500; 211 431; 400 500];
feature_ar(:,:,2) = [1 1; 195 26; 400 1; 70 162; 137 181; 259 183; 340 157; 193 263; 146 316; 250 316; 1 500; 199 398; 400 500];
feature_ar(:,:,3) = [1 1; 188 33; 400 1; 76 219; 175 236; 257 233; 316 205; 222 285; 174 312; 261 307; 1 500; 220 382; 400 500];
%different sizes of triangles in image neglected
ftri_ar = zeros(size(delaunay(feature_ar(:,:,1)),1), 3, len);
for i=1:len
    ftri_ar(:,:,i) = delaunay(feature_ar(:,:,i)); %Can result in error size mismatch
end
vtri_ar = zeros(size(ftri_ar,1), 2, 3, len);
for i=1:len
    for j=1:size(ftri_ar,1)
        for k=1:3
            vtri_ar(j,2,k,i) = feature_ar(ftri_ar(j,k,1),1,i);
            vtri_ar(j,1,k,i) = feature_ar(ftri_ar(j,k,1),2,i);
        end
    end
end
morphtri = zeros(size(ftri_ar,1),2,3);
for i=1:size(morphtri,1)
    for j=1:3
%        for k=1:len
         morphtri(i,1,j) = (1/len)*sum(vtri_ar(i,1,j,:));
         morphtri(i,2,j) = (1/len)*sum(vtri_ar(i,2,j,:));
%        end
%        morphtri(i,1,j) = sum1/len;
%        morphtri(i,2,j) = sum2/len;
    end
end
alltrimat = zeros(3,3,size(morphtri,1),len+1);
for i=1:size(morphtri,1)
    alltrimat(:,:,i,1) = [morphtri(i,1,1) morphtri(i,1,2) morphtri(i,1,3); morphtri(i,2,1) morphtri(i,2,2) morphtri(i,2,3); 1 1 1];
    for j=1:len
        alltrimat(:,:,i,j+1) = [vtri_ar(i,1,1,j) vtri_ar(i,1,2,j) vtri_ar(i,1,3,j); vtri_ar(i,2,1,j) vtri_ar(i,2,2,j) vtri_ar(i,2,3,j); 1 1 1];
    end
end
ret = uint8(zeros(n,m,d));
for i=1:n
    for j=1:m
        for k=1:size(morphtri,1)
            if(inpolygon(i,j,[morphtri(k,1,1) morphtri(k,1,2) morphtri(k,1,3)],[morphtri(k,2,1) morphtri(k,2,2) morphtri(k,2,3)])==1)
                barc = alltrimat(:,:,k,1)\[i;j;1];
                mapxy = zeros(3, len);
                for l=2:len+1
                    mapxy(:,l-1) = alltrimat(:,:,k,l)*barc;
                end
                for p=1:d
                    summ = 0;
                    for q=1:len
                        summ = summ + ar(uint32(mapxy(1,q)/mapxy(3,q)),uint32(mapxy(2,q)/mapxy(3,q)),q,p);
                        %p & q have to be exchanged, not now
                    end
                    ret(i,j,p) = summ/len;
                end
                break;
            end
        end
    end
end