function [C, a] = lloyd_iteration(X, C)

n = size(X,1);
d = size(X,2);
k = size(C,1);

    a = zeros(n,1);
    old_a = size(n,1);
    old_a = -1;
    
    x=1;
    itr_count=0;
    
    while x==1
        a = update_assignments(X, C, a);
        C = update_centers(X, C, a);
        if sum(old_a~=a)==0
            %fprintf(' breaking at itr_count = %d',itr_count);
            break;
        end
        old_a = a;
        itr_count = itr_count+1;
    end
    
end
