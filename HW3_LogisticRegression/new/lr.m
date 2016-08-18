clear all;
load lr_train.mat; 
load lr_test.mat;

% Normalize and center training data
train.X = standardize(train.X);
test.X = standardize(test.X);

% Add a row of 1's as x0 to introduce intercept
train.X = [ones(1, size(train.X, 2)); train.X];
test.X = [ones(1, size(test.X, 2)); test.X];

% Initialize
w0 = rand(size(train.X, 1), 1) * 1e-4;

% Train
w = lr_gd(w0, train.X, train.y);

% Print out training accuracy
train_pred = lr_pred(w, train.X);
trainnacc = train_pred == train.y;
trainacc = sum(trainnacc) / length(train.y);

fprintf('Your training accuracy is:%6.4f%%\n', 100 * trainacc);

% Print out cross-validation accuracy
test_pred = lr_pred(w, test.X);
testnacc = test_pred == test.y;
testacc = sum(testnacc) / length(test.y);

fprintf('mis_clss size = %d',sum(test_pred ~= test.y));

mis_classified  = zeros(1,15);
count=1;

for i=1:size(testnacc,2)
   if testnacc(1,i)==0
       mis_classified(1,count) = i;
       count = count +1;
   end
end

%display mis classified images
display_network(test.X(2:785,mis_classified(1:13)));

fprintf('\nYour testing accuracy is:%6.4f%%\n', 100 * testacc);