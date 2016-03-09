function [ b, c ] = mediancut( a, z )
%MEDIANCUT implements median cut algorithm
%a is original image, z is quantized range of image
    [n,m,d] = size(a);
    ar = mediancutrec(a, z, {});
    b = zeros(z, 3);
    for i=1:z
        b(i, :) = round(mean(ar{i}));
    end
    a = double(a);
    b = double(b);
    c = zeros(n, m, d);
    for i=1:n
        for j=1:m
            tmp = zeros(1,z);
            tmp_min = 99999;
            tmp_idx = 1;
            for k=1:z
                tmp(1,k) = (a(i,j,1)-b(k,1))^2 + (a(i,j,2)-b(k,2))^2 + (a(i,j,3)-b(k,3))^2;
            end
            for k=1:z
                if(tmp(1,k)<tmp_min)
                    tmp_min = tmp(1,k);
                    tmp_idx = k;
                end
            end
            for l=1:d
                c(i,j,l) = b(tmp_idx,l);
            end
            error = c(i,j,:)-a(i,j,:);
            for l=1:d
                if(j<m)
                    a(i,j+1,l) = a(i,j+1,l) + error(l)*(3/8);
                end
                if(i<n)
                    a(i+1,j,l) = a(i+1,j,l) + error(l)*(3/8);
                end
                if(i<n && j<m)
                    a(i+1,j+1,l) = a(i+1,j+1,l) + error(l)*(1/4);
                end
            end
        end
    end
    c = uint8(c);
end