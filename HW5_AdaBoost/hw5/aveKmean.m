function [  ] = aveKmean(  )

    load kmeans_data;
    init = 'kmeans++';
    num_restarts=1;
    mean_obj_val = size(1000,1);
    
    for i=1:1000
        [best_C, best_a, best_obj] = kmeans_cluster(X, 9, init, num_restarts);
        %fprintf('itr = %d best_obj = %d\n mean_obj %d\n',i,best_obj,mean_obj_val);
        mean_obj_val(i) = best_obj;
    end

    mean_obj_val = sum(mean_obj_val)/1000;
    fprintf('mean obj val for random init = %d \n',mean_obj_val);
end

