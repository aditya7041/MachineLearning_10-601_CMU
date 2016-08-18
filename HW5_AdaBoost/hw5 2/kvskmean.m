function [a]= kvskmean()

    obj=0;
    load kmeans_data;
    [a,b]= size(X);
    fprintf('size of x = %d %d \n',a,b);
    init = 'random';
    num_restarts=10;
    obj_val = size(20,1);
    
    for k=1:1:20
        [best_C, best_a, best_obj] = kmeans_cluster(X, k, init, num_restarts);
        fprintf('k = %d best_obj = %d\n',k,best_obj);
        obj_val(k,1) = best_obj;
    end
    
    x = linspace(1,1,20);
    figure
    plot(obj_val);
    title('K vs Obj value');
    xlabel('K (number of clusters)');
    ylabel('Obj value');

end

