function Res=Seam_carving(inp,m,n)
    Res=Seam_carvingv(inp,m);
    Res=Seam_carvingv(imrotate(Res,90),n);
    Res=imrotate(Res,-90);
end
function Res=Seam_carvingv(inp,m)
    Res=inp;
%     Res1=Res;
    coder.varsize('Res',[],[1 1 0]);
    for i=1:m
        
       temp_Res=ones(size(inp,1),size(inp,2)-i,size(inp,3));
       
        temp=Seam(Res);
      
        for j=size(temp_Res,1):-1:1
            temp_Res(j,:,1)=[Res(j,1:temp(j)-1,1),Res(j,temp(j)+1:end,1)];
            temp_Res(j,:,2)=[Res(j,1:temp(j)-1,2),Res(j,temp(j)+1:end,2)];
            temp_Res(j,:,3)=[Res(j,1:temp(j)-1,3),Res(j,temp(j)+1:end,3)];
            
        end
        Res=temp_Res;
    end
    Res=uint8(Res);
end
function Res = Seam( inp )
%Outputs image downsampled to m*n resolution
%   Takes input input image and desired m,n.Implemented from paper
    grad_res=grad(inp);
    dyan_indx=zeros(size(grad_res));
    mask=zeros(size(grad_res),'double');
%     Res=mask;
    mask=padarray(grad_res,[0,1],realmax('double')); %taking care of edge conditions
%     Res1=mask;
    dyn_indx=padarray(dyan_indx,[0,1],-2);
    for i=2:size(mask,1)
        for j=2:size(mask,2)-1
            ngbr=[mask(i-1,j-1),mask(i-1,j),mask(i-1,j+1)];
            [value,indx]=min(ngbr);
            dyn_indx(i,j)=indx-2;
            mask(i,j)=mask(i,j)+value;
            
        end
    end
%     Res=mask;
    mask=mask(:,2:end-1);
%     Res=mask;
    dyn_indx=dyn_indx(:,2:end-1);
%     Res1=dyn_indx;
%     indx_arr=zeros(m);
    temp=mask(size(mask,1),:);
    [min_energy,min_indx]=min(temp);
%     for i=1:size(indx_arr,1)
%         [min_energy,min_indx]=min(temp);
%         temp=[temp(1:min_indx-1),temp(min_indx+1:end)];
%         indx_arr(i)=min_indx;
%     end
%     [min_energy,min_indx]=min(mask(size(mask,1),:));
    Res=zeros(1,size(mask,1));
    
        
        for i=size(mask,1):-1:1
            Res(i)=min_indx;
            min_indx=min_indx+dyn_indx(i,min_indx);
        end
        
   
    
end

function grad_res=grad(inp)
    inp=double(inp);
    grad_res=zeros(size(inp(:,:,1)),'double');
    grad_res1=abs(imfilter(inp(:,:,1),[-1 0 1],'replicate'))+abs(imfilter(inp(:,:,1),[-1;0;1],'replicate'));
    grad_res2=abs(imfilter(inp(:,:,2),[-1 0 1],'replicate'))+abs(imfilter(inp(:,:,2),[-1;0;1],'replicate'));
    grad_res3=abs(imfilter(inp(:,:,3),[-1 0 1],'replicate'))+abs(imfilter(inp(:,:,3),[-1;0;1],'replicate'));
    grad_res=grad_res1+grad_res2+grad_res3;
end