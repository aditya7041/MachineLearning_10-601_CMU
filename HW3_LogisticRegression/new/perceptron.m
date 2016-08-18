function w = perceptron(w0,X,Y)
%   w0 is the initial weight vector (d * 1)
%   X is feature values of training examples (d * n)
%   Y is labels of training examples (1 * n)

[d,n] = size(X);
maxiter = 100;
stop_criteria = 1;

% WEIGHTING vector "w" initialized to zeros. Use this in your algorithm!
w = w0;

% PREDICTION vector "y_hat" initialized to zeros. Use this in your algorithm!
y_hat = zeros(1,n);
y_hat_prev = y_hat;

for k = 1:maxiter
    
    % Run through all the examples for each iteration
    for example=1:n
        
        % Update predicted Y values as per the current w params
        pred_val = transpose(w)*X(:,example);
        if(pred_val<=0)
             y_hat(1,example) =-1;
        else 
             y_hat(1,example) =1;
        end
        
        if((pred_val > 0) && (Y(1,example)==-1))
            w = w - X(:,example);
        else
            if ((pred_val <= 0) && (Y(1,example)==1))
                w = w + X(:,example);
            end
        end
        
    end
    
    eps = sum(y_hat == y_hat_prev) / length(y_hat);
    fprintf('%21d %20g\n', k, eps);
    if eps >= stop_criteria
        break;
    end
    y_hat_prev = y_hat;
    
end


