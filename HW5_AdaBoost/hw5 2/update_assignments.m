% This function will update the assignment of the point(data)
% which is nearest to the cluster 
%  Data points         : X -> n*d (N-> number of data points, D-> Dimension of each point)
%  Clusters            : C -> k*d (K-> number of clusters, D->Dimension of point/cluster)
%  Assignments         : A -> n*1 (N-> number of data points)
%  Output is the update Assignment i.e A vector of n points signifying the
%  nearest cluster assignments
function a = update_assignments(X, C, a)
  
n = size(X,1);
d = size(X,2);
k = size(C,1);

a_updated = size(n,1);

for exam=1:n
    
    min_dis = 9999999;
    nearest_cluster = -1;
    
    for curr_cluster=1:k
        
        curr_cluster_distance = sum(abs(minus(X(exam,:),C(curr_cluster,:))).^2).^.5;
        %fprintf(' data point %d cluster num %d distance %d min_dis %d',exam,curr_cluster,curr_cluster_distance,min_dis);
                
        if min_dis > curr_cluster_distance
            min_dis = curr_cluster_distance;
            nearest_cluster = curr_cluster;
        end
        
    end
    
    a_updated(exam,1)= nearest_cluster;
    
end
a = a_updated;
end