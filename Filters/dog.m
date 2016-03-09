function [ b, c ] = dog( a, mk, sig1, sig2 )
%DOG implmented using gaussian functions of sig1 and sig2
%Part of assingment1
    a = double(a);
    h1 = (1/(2*pi*(sig1)^2))*fspecial('gaussian', mk, sig1);
    h2 = (1/(2*pi*(sig2)^2))*fspecial('gaussian', mk, sig2);
    h = h1-h2;
    b = conv2(h,a);
    [n m d] = size(b);
    c = uint8(a-b(round(mk/2):n-floor(mk/2), round(mk/2):m-floor(mk/2)));
    if(sig1>sig2)
        b = uint8(-1*b);
    else
        b = uint8(b);
    end
end