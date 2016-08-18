function [Xnew] = standardize( X )
%STANDARDIZE: standardize input matrix X
%   Center the mean of each feature to 0
%   Adjust each feature to have variance 1

% X is d * n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%s = std(X') + 1e-5;  % Computes standard deviation of features as a vector
%m = mean(X.');	% Computes mean of features as a vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Xnew = bsxfun(@minus, X, m);
%Xnew = bsxfun(@rdivide, Xnew, s + 1e-5);

M = mean(X.');
S = std(X.') + 1e-5;
[rows col] = size(X);

for row= 1:rows
    X(row,:) = (X(row,:) - M(1,row))/S(1,row);
end

Xnew = X;

end

