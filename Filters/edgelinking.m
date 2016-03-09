function [ d ] = edgelinking( aa, t1, t2 )
%EDGELINKING is implemented as a part of Canny Edge Detection
% a is high thresholded image and b is low thresholded
%Part of Assignment1
%Completed
edga = lapog(aa);
[a, b] = threshold(edga, t1, t2);
[n, m] = size(a);
    for i=1:n
        for j=1:m
            if(i>1 && j>1 && i<n && j<m)
                if(a(i,j)>0)
                    for k=-1:1
                        for l=-1:1
                            if(b(i+k,j+l)>0)
                                a(i+k,j+l) = a(i,j);
                            end
                        end
                    end
                end
            end
        end
    end
    d = a;
end

