function [ c ] = mediancutrec( a, z, c )
%MEDIANCUTREC Summary of this function goes here
%   Detailed explanation goes here
    b = premediancut(a);
    sb = size(b);
    k = 1;
    while k<z
        for i=1:sb(2)
            tmp = mediancuthelp(b{1, i});
            c{1, 2*(i-1)+1} = tmp{1, 1};
            c{1, 2*(i-1)+2} = tmp{1, 2};
        end
        k = k*2;
        b = c;
        sb = size(b);
    end
end

