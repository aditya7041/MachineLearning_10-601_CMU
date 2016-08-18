function [ pred ] = lr_pred( w, X )
%LR_PRED: Make prediction using weight vector w and feature matrix X
%   w is weight vector (d * 1)
%   x is feature matrix (d * n)
%   pred is binary prediction result based on w and X

sigmoid_coeff = transpose(w)*X;
sigm = sigmoid(sigmoid_coeff);

% result i.e. classification of features linear sum into classes
pred = (sigm>=0.5);
end

