function K = polykernel(X1,X2)
% Homogeneous polynomial kernel of degree-3 with an offset of 1
% X1 is a matrix
% X2 is a matrix

%fprintf('running the polykernel \n');
%fprintf('value of trans(x1)*(x2) = %d \n',transpose(X1)*X2);
K = (transpose(X1)*X2 +1).^3;
%fprintf('Dimension of K = %d %d \n',size(K,1),size(K,2));