function [] = experimentation( )

A = [3 3 4; 6 5 6;9 8 15];
[rows col] = size(A);

M = mean(A.');
S = std(A.');

for row= 1:rows
    A(row,:) = (A(row,:) - M(1,row))/S(1,row);
end

fprintf('Changed array: \n');
A


%LR_PRED: Make prediction using weight vector w and feature matrix X
%   w is weight vector (d * 1)
%   x is feature matrix (d * n)
%   pred is binary prediction result based on w and X

%d = 4, n=2
w = [1;1;-2;-2]
X = [1 2;1 -2;1 0;1 0]

sigmoid_coeff = transpose(w)*X;
sigmoid = sigmf(sigmoid_coeff,[1 0]);

sigmoid

% result i.e. classification of features linear sum into classes
predictions = (sigmoid>=0.5)

end

