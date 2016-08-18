function [ f, g ] = fv_grad( w_curr, X, y )
%FV_GRAD: returns the objective function value f and the gradient g w.r.t w
%at point w_curr
%   w_curr is current weight vector (d * 1)
%   X is feature values (d * n)
%   y is label (1 * n)

% Set parameters
f = 0;
g = zeros(length(w_curr), 1);

lambda_val = 25;
lambda = ones(length(w_curr), 1) * lambda_val;
lambda(1) = 0;  % do not penalize weight associated with the intercept term

sigma = transpose(w_curr)*X;
p = sigmoid(sigma); 

% without regularization
%f = -log(p + 1e-5)*(sum(y==0)) - log(1-p + 1e-5)*(sum(y==1));

% with regularization
f = -y*transpose(log(p + 1e-5)) - (1-y)*transpose(log(1-p + 1e-5)) - lambda/2*norm(w_curr);

%fprintf(' fv_grad: sum(wx) = %d P(y=1) = %d',sigma,p,f); 
% Slope of the gradient/loss function with respect to each feature weighting term
g = X * (p - y)' + transpose(lambda)*w_curr;
%g = X * (p - y)';
end