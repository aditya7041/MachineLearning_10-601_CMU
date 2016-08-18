function pred = perceptron_pred(w, x)
%PERCEPTRON_PRED: Make prediction using weight vector w and feature vector
%x
%   w is weight vector (d * 1)
%   x is feature vector (d * 1)
%   pred is binary prediction result based on w and x

pred =1;
if(transpose(w)*x <=0)
      pred=-1;
end