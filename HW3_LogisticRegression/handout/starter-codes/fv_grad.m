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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here...
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% without regularization
% f = -log(p) * y' - log(1 - p) * (1 - y)';
% g = X * (p - y)';
end

