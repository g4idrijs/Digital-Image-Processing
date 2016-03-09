function  [Res,Dis] = bilateral(inp,w,sig_s,sig_r)
%bilateral filtering to  both gray,color images
%   Detailed explanation goes here
inp = double(inp)/255;
inp = inp+0.03*randn(size(inp));
Dis=inp;
if size(inp,3)==1
    Res=bil_gray(inp,w,sig_s,sig_r);
else
    Res=bil_color(inp,w,sig_s,sig_r);
end
end
%%% bilateral filter for gray scale
function Res = bil_gray(inp,w,sig_s,sig_r)
    Res=zeros(size(inp));
    
    [X,Y] = meshgrid(-w:w,-w:w);
    G = exp(-(X.^2+Y.^2)/(2*sig_s^2));
    
    for i=1:size(inp,1)
        for j=1:size(inp,2)
            i1=max(i-w,1);
            i2=min(i+w,size(inp,1));
            j1=max(j-w,1);
            j2=min(j+w,size(inp,2));
            
            mask=inp(i1:i2,j1:j2);
            
            H = exp(-(mask-inp(i,j)).^2/(2*sig_r^2));
      
            F = H.*G((i1:i2)-i+w+1,(j1:j2)-j+w+1);
            Res(i,j) = sum(F(:).*mask(:))/sum(F(:));
        end
    end
           
end
%%% bilateral filter for color image
function Res = bil_color(inp,w,sig_s,sig_r)
    inp =applycform(inp,makecform('srgb2lab'));
    sig_r = 100*sig_r;
    Res=zeros(size(inp));
    
    [X,Y] = meshgrid(-w:w,-w:w);
    G = exp(-(X.^2+Y.^2)/(2*sig_s^2));
    
    for i=1:size(inp,1)
        for j=1:size(inp,2)
            i1=max(i-w,1);
            i2=min(i+w,size(inp,1));
            j1=max(j-w,1);
            j2=min(j+w,size(inp,2));
            
            mask=inp(i1:i2,j1:j2,:);
            
            dL = mask(:,:,1)-inp(i,j,1);
            da = mask(:,:,2)-inp(i,j,2);
            db = mask(:,:,3)-inp(i,j,3);
            H = exp(-(dL.^2+da.^2+db.^2)/(2*sig_r^2));
      
            F = H.*G((i1:i2)-i+w+1,(j1:j2)-j+w+1);
            z_all=sum(F(:));
            Res(i,j,1) = sum(sum(F.*mask(:,:,1)))/z_all;
            Res(i,j,2) = sum(sum(F.*mask(:,:,2)))/z_all;
            Res(i,j,3) = sum(sum(F.*mask(:,:,3)))/z_all;
        end
    end
    Res = applycform(Res,makecform('lab2srgb'));
end