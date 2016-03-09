function [ b ] = otsus( a )
%OTSUS Summhisty of this function goes here
%   Detailed explanation goes here
[n,m] = size(a);
b = uint8(zeros(n,m));
hist = zeros(1,256);
for i=1:n
    for j=1:m
        hist(1, a(i,j)+1) = hist(1, a(i,j)+1) + 1;
    end
end
for z=1:256
    hist(1, z) = hist(1, z)/(n*m);
end
kar = zeros(1,256);
for i=1:256
    kar(1, i) = bvar(hist,i);
end
kstr = -99999;
for i=1:256
    if(kstr<kar(1,i))
        kstr = i;
    end
end
for i=1:n
    for j=1:m
        if(a(i,j)>kstr)
            b(i,j) = a(i,j);
        else
            b(i,j) = 0;
        end
    end
end
end

function [ m ] = mk(hist, k)
    m = 0.0;
    for i=1:k
        m = m + i*hist(1,i);
    end
end

function [ p ] = pk(hist, k)
    p = 0.0;
    for i=1:k
        p = p + hist(1,i);
    end
end

function [ sig ] = bvar(hist, k)
    mg = 0.0;
    for i=1:256
        mg = mg + i*hist(1,i);
    end
    p = pk(hist,k);
    sq = (mg*p - mk(hist,k))^2;
    sig = sq/(p*(1-p));
end