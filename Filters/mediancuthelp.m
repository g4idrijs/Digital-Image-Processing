function [ c ] = mediancuthelp( b )
%MEDI Summary of this function goes here
%   Detailed explanation goes here
    [n,d] = size(b);
    diff1 = max(b(:,1)) - min(b(:,1));
    diff2 = max(b(:,2)) - min(b(:,2));
    diff3 = max(b(:,3)) - min(b(:,3));
    diff = max([diff1; diff2; diff3]);
    if(diff==diff1)
        sortrows(b, 1);
    else if(diff==diff2)
            sortrows(b, 2);
        else
            sortrows(b, 3);
        end
    end
    c1 = b(1:n/2, :);
    c2 = b((n/2)+1:n, :);
    c = {c1 c2};
end