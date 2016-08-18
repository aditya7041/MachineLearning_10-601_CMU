% This function will update the centers positions based on the current
% assignment
% which is nearest to the cluster 
%  Data points         : X -> n*d (N-> number of data points, D-> Dimension of each point)
%  Clusters            : C -> k*d (K-> number of clusters, D->Dimension of point/cluster)
%  Assignments         : A -> n*1 (N-> number of data points)
%  Output is the update Assignment i.e A vector of n points signifying the
%  nearest cluster assignments
function C = update_centers(X, C, a)
  
n = size(X,1);
d = size(X,2);
k = size(C,1);

    for cluster=1:k
        data_points = (a==cluster);
        num_points = sum(data_points==1);
        if num_points>=1
             C(cluster,:)= sum(X(data_points,:))/num_points;
        end
    end
end