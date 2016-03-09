I = imread('wiki.jpg');
I = rgb2gray(I);
level = 1;

BW = roipoly(I);
%{
for i = 1 : level
    
    I = impyramid(I,'reduce');
end

%}
I = double(I);
m = size(I,1); n = size(I,2);
I_r = I;

% imshow(uint8(I));
   
for i=2 : m-1
    for j=2: n-1
        if(BW(i,j))
        arb = I(i,j) + 0.25*(-4*I(i,j) + I(i,j+1) + I(i-1,j) + I(i+1,j) + I(i,j-1)); 
        if(arb > 255)
            arb = 255;
        end
        if(arb < 0)
            arb = 0;
        end
        I_r(i,j) = arb ;
        end
    end
end

%figure, imshow(uint8(I_r));

%Ix = I;
%Iy = I;
%Ixx = I;
%Iyy = I;



%{
for i=2 : m-1
    for j=2: n-1
        
        Ix(i,j) = I_r(i+1,j)-I_r(i,j);
        Iy(i,j) = I_r(i,j+1)-I_r(i,j);
        Ixx(i,j) = I_r(i+1,j) - 2*I_r(i,j) + I_r(i-1,j);
        Iyy(i,j) = I_r(i,j+1) - 2*I_r(i,j) + I_r(i,j-1);
    end
end
%}

%H1 = fspecial('gaussian');
%I = imfilter(I,H1);
for s =1 :100
    [Ix,Iy] = imgradientxy(I_r);
    H = fspecial('Laplacian');
    Ila = imfilter(I_r,H);
    for i=2 : m-1
        for j=2: n-1 
            if(BW(i,j))
                M = (Ix(i,j))^2 + (Iy(i,j))^2;
                Mag = sqrt(M)+ 0.001;
                N = [(-Iy(i,j))/Mag,(Ix(i,j))/Mag];
                delta = [Ila(i+1,j) - Ila(i-1,j), Ila(i,j+1) - Ila(i,j-1)];
                val = N(1)*delta(1) + N(2)*delta(2)
                del = 0;
                if (val > 0)
                    fir = min((I_r(i,j)-I_r(i-1,j)),0);
                    sec = max((I_r(i+1,j)-I_r(i,j)),0);
                    thi = min((I_r(i,j)-I_r(i,j-1)),0);
                    fou = max((I_r(i,j+1)-I_r(i,j)),0);
                    del = sqrt(fir^2 + sec^2 + thi^2 + fou^2);
                end
                if (val < 0)
                    fir = max((I_r(i,j)-I_r(i-1,j)),0);
                    sec = min((I_r(i+1,j)-I_r(i,j)),0);
                    thi = max((I_r(i,j)-I_r(i,j-1)),0);
                    fou = min((I_r(i,j+1)-I_r(i,j)),0);
                    del = sqrt(fir^2 + sec^2 + thi^2 + fou^2);
                end
                (val*del*0.1);
                
                arb = I_r(i,j) + (0.002*val*del);
                if(arb > 255)
                    arb = 255;
                end
                if(arb < 0)
                    arb = 0;
                end
                I_r(i,j) = arb ;
            end
        end
    end
    
    if(mod(s,20) == 9)
        figure, imshow(uint8(I_r));
        % diffusing
        I_r1 = I_r;
        for i=2 : m-1
            for j=2: n-1
                if(BW(i,j))
                    arb = I_r1(i,j) + 0.25*(-4*I_r1(i,j) + I_r1(i,j+1) + I_r1(i-1,j) + I_r1(i+1,j) + I_r1(i,j-1));
                    if(arb > 255)
                        arb = 255;
                    end
                    if(arb < 0)
                        arb = 0;
                    end
                    I_r(i,j) = arb ;
                end
            end
        end

    end
    
    
           
    %{
    Ix = I_r;
    Iy = I_r;
    Ixx = I_r;
    Iyy = I_r;
   
    for i=2 : m-1
        for j=2: n-1
            Ix(i,j) = I_r(i+1,j)-I_r(i,j);
            Iy(i,j) = I_r(i,j+1)-I_r(i,j);
            Ixx(i,j) = I_r(i+1,j) - 2*I_r(i,j) + I_r(i-1,j);
            Iyy(i,j) = I_r(i,j+1) - 2*I_r(i,j) + I_r(i,j-1);
        end
    end
    %}
    
end

%{
for i = 1 : level
    
    I= impyramid(I,'expand');
end
%}
%{
%I = uint8(I);
%figure, imshow(I);

for i = 1 : level
    
    Ia = impyramid(Ia,'reduce');
end
% figure, imshow(Ia);


Ib = Ia
for i = 1 : level
    
    Ib = impyramid(Ib,'expand');
end
% figure, imshow(Ib);

im = imresize(Ia,[size(I,1),size(I,2)]);
size3 = size(im);

% figure, imshow(im);


%} 
