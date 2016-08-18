function obj = kmeans_obj(X, C, a)
  
n = size(X,1);
d = size(X,2);
k = size(C,1);

    obj =0;
    
    for exam=1:n
        curr_cluster = a(exam);
        obj = obj + sum(abs(minus(X(exam,:),C(curr_cluster,:))).^2);
        %fprintf(' point %d clus %d obj %d \n',exam,curr_cluster,obj);
    end
    
end
