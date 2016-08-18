function w = kernel_perceptron(a0, X, Y)
%Kernel perceptron algorithm
%   a0 is the initial count vector (1 * n)
%   X is feature values of training examples (d * n)
%   Y is labels of training examples (1 * n)

[d,n] = size(X);
maxiter = 100;
%maxiter = 100;
stop_criteria = 1;

% WEIGHTING vector "a" initialized to zeros. Use this in your algorithm!
a = a0;

% PREDICTION vector "y_hat" initialized to zeros. Use this in your algorithm!
y_hat = zeros(1,n);
y_hat_prev = y_hat;

% The Gram matrix is constructed here.
K = polykernel(X,X);

for k = 1:maxiter
    
    for i = 1:n
        y_hat(1,i) = kernel_perceptron_pred(a, Y, K, i);
    end
    
    mis_match = (y_hat~=Y);
    
    %fprintf('Number of mismatch = %d \n',sum(mis_match==1));
    
    for ss=1:n
        if mis_match(1,ss)==1
            a(1,ss)= a(1,ss)+1;
        end
    end
    
    %{
        tot_sum = 0.0;
        
        temp_sum = a(:,i).*transpose(Y(:,i));
        kernel = polykernel(X(:,i),X);
        tot_sum = sum(transpose(temp_sum).*kernel);
        %{
        for j=1:n
            temp_sum = a(1,i).*transpose(Y(1,i));
            kernel = polykernel(X(:,i),X(:,j));
            tot_sum = tot_sum + temp_sum*kernel;
            %fprintf('tot_sum = %d kernel = %d \n',tol_sum,kernel);
        end
        %}
        
        %fprintf('tot_sum = %d, Y = %d \n',tot_sum,Y(1,i));
        
        if tot_sum<=0
            if(Y(1,i)==1)
                a(1,i) = a(1,i)+1;
            end
        end
        
        if tot_sum>0
            if(Y(1,i)==-1)
                a(1,i) = a(1,i)+1;
            end
        end
        
    end
    %}
    eps = sum(y_hat == y_hat_prev) / length(y_hat);
    fprintf('k = %21d eps = %20g\n', k, eps);
    if eps >= stop_criteria
        break;
    end
    y_hat_prev = y_hat;
end

w = a;

end


