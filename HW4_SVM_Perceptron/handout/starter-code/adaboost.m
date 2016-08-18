
function [sign_array] = adaboost(trainX, trainY,testX,T)

train.X = trainX;
train.y = trainY;
test.X=testX;
num_iter=T;

% Weight vector which is initialized to 1/sample_size.
weight = zeros(1,s1);
weight(:) = 1/s1;  % Each Weight = 1/400

decision_array = zeros(1,num_iter);
decision_dir_array = zeros(1,num_iter);
alpha_array = zeros(1,num_iter);
% Decision stumps parameteres

%Misclassified indexes

for outter_iter=1:20
mis_classified_indexes = zeros(1,s1);
best_mis_classified_indexes = zeros(1,s1);

% What is the decision boundary i.e hori = some_val or ver = some_val
boundary = 0;

% Anyone of them being 1 implies the direction
horizontal_ori =0;
vertical_ori = 0;

%Right/left/up/down -> 1/2/3/4
best_decision_oreintation = 0;

% Parameters to check the min_error,temp_err for  decision
% stump iteration and decide the minimal error stamps

% Total weight of the mis-classified examples
total_misclassified_weight =0;
% Minimium weight across all the iteratin (global)
minimum_misclassified_weights=1000;
% Minimum mislcassified weights for a particular iteration(temp)
min_misclassified_weight =0;
count=0;


% Sort the points w.r.t x and y axis co-ordinates and store the indexes
temp1 = train.X(:,1);
temp2 = train.X(:,2);
[a,b] = size(temp2);

[ver_sort,ver_sort_index]= sort(temp1);
[hor_sort,hor_sort_index]= sort(temp2);

% checking if the results are correct or not
%{
    for i=1:
        fprintf('Ver :val = %d idx =%d train val =%d \n',ver_sort(i),ver_sort_index(i),train.X(ver_sort_index(i),1));
        fprintf('Hori :val = %d idx =%d train val =%d \n',hor_sort(i),hor_sort_index(i),train.X(hor_sort_index(i),2));
        end
        %}

% Vertical decision stumps hypothesis

% rightside -> + (positive class)
for i=1:s1
decision_val = train.X(ver_sort_index(i),1);

right_side_indexes = find(train.X(:,1)>=decision_val); % Column vector
left_side_indexes = find(train.X(:,1)<decision_val); % Column vector

%initialize misclassfied weights for this cycle
misclassified_weights =0;
mis_classified_indexes = zeros(1,s1);

% Add the weights of all incorrectly classified examples

% Misclassified on right side i.e. actual class = -1
if size(right_side_indexes,1) + size(left_side_indexes,1) ~= 400
fprintf('some issue with segregation, point on right %d on left %d \n',size(right_side_indexes,1),size(left_side_indexes,1));
end

for r=1:size(right_side_indexes,1)
if train.y(right_side_indexes(r,1),1)==1
continue;
end
mis_classified_indexes(1,right_side_indexes(r,1))=1;
misclassified_weights = misclassified_weights + weight(1,right_side_indexes(r,1));
end

% Misclassified on left side i.e. actual class = +1
if size(left_side_indexes,1)>=1
for l=1:size(left_side_indexes,1)
if train.y(left_side_indexes(l,1),1)==-1
continue;
end
mis_classified_indexes(1,left_side_indexes(l,1))=1;
misclassified_weights = misclassified_weights + weight(1,left_side_indexes(l,1));
end
end

if(misclassified_weights < minimum_misclassified_weights)
%fprintf('mis-classified weights %d decision val %d orient = 1 num_mis %d iter %d count %d \n',misclassified_weights,decision_val,sum(mis_classified_indexes==1),i,count);
minimum_misclassified_weights = misclassified_weights;
best_mis_classified_indexes = mis_classified_indexes;
count = count+1;
best_decision_boundary = decision_val;
best_decision_oreintation = 1;
end

end


count=0;
% leftside -> + (positive class)
for i=1:s1
decision_val = train.X(ver_sort_index(i),1);
%fprintf('Itertion %d point %d decision val %d :\n',i,ver_sort_index(i),decision_val);

% segregrate indexes
right_side_indexes = find(train.X(:,1)>=decision_val); % Column vector
left_side_indexes = find(train.X(:,1)<decision_val); % Column vector

%initialize misclassfied weights for this cycle
misclassified_weights =0;
mis_classified_indexes = zeros(1,s1);

% Add the weights of all incorrectly classified examples

% Misclassified on right side i.e. actual class = -1
if size(right_side_indexes,1) + size(left_side_indexes,1) ~= 400
fprintf('some issue with segregation, point on right %d on left %d \n',size(right_side_indexes,1),size(left_side_indexes,1));
end

for r=1:size(right_side_indexes,1)
if train.y(right_side_indexes(r,1),1)==-1
%fprintf('Classified correctly -> right side of ver\n');
continue;
end
%fprintf('Classified incorrectly -> right side of ver\n');
mis_classified_indexes(1,right_side_indexes(r,1))=1;
misclassified_weights = misclassified_weights + weight(1,right_side_indexes(r,1));
end

% Misclassified on left side i.e. actual class = +1
if size(left_side_indexes,1)>=1
for l=1:size(left_side_indexes,1)
if train.y(left_side_indexes(l,1),1)==1
%fprintf('Classified correctly -> left side of ver\n');
continue;
end
%fprintf('Classified incorrectly -> left side of ver\n');
mis_classified_indexes(1,left_side_indexes(l,1))=1;
misclassified_weights = misclassified_weights + weight(1,left_side_indexes(l,1));
end
end

if(misclassified_weights < minimum_misclassified_weights)
%fprintf('mis-classified weights %d decision val %d orient = 1 mis_class %d iter %d count %d \n',misclassified_weights,decision_val,sum(mis_classified_indexes==1),i,count);
minimum_misclassified_weights = misclassified_weights;
count = count+1;
best_mis_classified_indexes = mis_classified_indexes;
best_decision_boundary = decision_val;
best_decision_oreintation = 2;
end

end

% Vertical classifier now
% up -> +1(positive class)
count=0;
for i=1:s1
decision_val = train.X(hor_sort_index(i),1);

upper_side_indexes = find(train.X(:,2)>=decision_val);
lower_side_indexes = find(train.X(:,2)<decision_val);

misclassified_weights =0;
mis_classified_indexes = zeros(1,s1);

if size(upper_side_indexes,1)>=1
for u=1:size(upper_side_indexes,1)
if train.y(upper_side_indexes(u,1),1)==-1
continue;
end
mis_classified_indexes(1,upper_side_indexes(u,1))=1;
misclassified_weights = misclassified_weights + weight(1,upper_side_indexes(u,1));
end
end

% Add the weights of all incorrectly classified examples on left hand
% side of this vertical classifier(decision stumps)
if size(lower_side_indexes,1)>=1
for d=1:size(lower_side_indexes,1)
if train.y(lower_side_indexes(d,1),1)==1
%fprintf('Classified correctly \n');
continue;
end
mis_classified_indexes(1,lower_side_indexes(d,1))=1;
misclassified_weights = misclassified_weights + weight(1,lower_side_indexes(d,1));
end
end

if(misclassified_weights < minimum_misclassified_weights)
%fprintf('mis-classified weights %d decision val %d orient = 3 error %d count %d \n',misclassified_weights,decision_val,sum(mis_classified_indexes==1),i,count);
minimum_misclassified_weights = misclassified_weights;
best_mis_classified_indexes = mis_classified_indexes;
count = count+1;
best_decision_boundary = decision_val;
best_decision_oreintation = 3;
end

end


count=0;
for i=1:s1
decision_val = train.X(hor_sort_index(i),1);

% get all indexes which are misclassified
upper_side_indexes = find(train.X(:,2)>=decision_val);
lower_side_indexes = find(train.X(:,2)<decision_val);

misclassified_weights =0;
mis_classified_indexes = zeros(1,s1);

% Add the weights of all incorrectly classified examples on right hand
% side of this vertical classifier(decision stumps)
if size(upper_side_indexes,1)>=1
for u=1:size(upper_side_indexes,1)
if train.y(upper_side_indexes(u,1),1)==1
%fprintf('Classified correctly \n');
continue;
end
mis_classified_indexes(1,upper_side_indexes(u,1))=1;
misclassified_weights = misclassified_weights + weight(1,upper_side_indexes(u,1));
end
end

% Add the weights of all incorrectly classified examples on left hand
% side of this vertical classifier(decision stumps)
if size(lower_side_indexes,1)>=1
for d=1:size(lower_side_indexes,1)
if train.y(lower_side_indexes(d,1),1)==-1
%fprintf('Classified correctly \n');
continue;
end
%fprintf('Classified incorrectly \n');
mis_classified_indexes(1,lower_side_indexes(d,1))=1;
misclassified_weights = misclassified_weights + weight(1,lower_side_indexes(d,1));
end
end

if(misclassified_weights < minimum_misclassified_weights)
%fprintf('mis-classified weights %d decision val %d orient = 4 error %d iter %d count %d \n',misclassified_weights,decision_val,sum(mis_classified_indexes==1),i,count);
minimum_misclassified_weights = misclassified_weights;
best_mis_classified_indexes = mis_classified_indexes;
count = count+1;
best_decision_boundary = decision_val;
best_decision_oreintation = 4;
end

end

%fprintf('iter %d decision val %d orient = %d error %d num_error %d\n',outter_iter,best_decision_boundary,best_decision_oreintation,minimum_misclassified_weights,sum(best_mis_classified_indexes==1));
misclassified_points_weights_sum = best_mis_classified_indexes*transpose(weight);
epsilon = misclassified_points_weights_sum/sum(weight);
aplha = (log((1-epsilon)/epsilon))/2;

prev_weight = sum(weight);
z = 2*sqrt(epsilon*(1-epsilon));

increase_factor = exp(aplha);
decrease_factor = exp(-aplha);

%fprintf('epsilon %d aplha %d z = %d \n',epsilon,aplha,z);
for i=1:s1
if best_mis_classified_indexes(1,i)==1
weight(1,i) = weight(1,i)*increase_factor;
else
weight(1,i) = weight(1,i)*decrease_factor;
end
end

weight = weight./z;
decision_array(1,outter_iter)= best_decision_boundary;
decision_dir_array(1,outter_iter) = best_decision_oreintation;
alpha_array(1,outter_iter) = aplha;
%fprintf('Weight : prev = %d this %d \n\n',prev_weight,sum(weight));

end


% we are done with all the hypothesis(decision stumps) and corresponding
% alpha values, Now make a prediction on the training sample.

sign_array = ones(s1,1);
for sample=1:s1

total_sum=0;
prediction = ones(1,num_iter);

for hypothesis=1:num_iter
%fprintf('decision dir = %d decision val = %d \n',decision_dir_array,decision_array(1,hypothesis));
prediction(1,hypothesis) =1;

if(decision_dir_array(1,hypothesis)==1)
if(train.X(sample,1) < decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==2)
if(train.X(sample,1) >= decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==3)
if(train.X(sample,2) > decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==4)
if(train.X(sample,2) < decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

end

%Now, we have the prediction array and the alpha array,
%So, we can now make the decision based on the sign and summation

sign = prediction*transpose(alpha_array);
if(sign<0)
sign_array(sample,1) = -1;
end
%fprintf('Input val = %d %d sign %d actual val =%d\n',train.X(sample,1),train.X(sample,2),sign,train.y(sample,1));

end

% we are done with the prediction, now check the error rate
errors = sum(sign_array~=train.y);
fprintf('Training error = %d total_sample=%d \n',errors,size(train.y,1));

% Testing data prediction and error rate

sign_array = ones(size(test.X,1),1);
for sample=1:size(test.X,1)

prediction = ones(1,num_iter);

for hypothesis=1:num_iter
%fprintf('decision dir = %d decision val = %d \n',decision_dir_array,decision_array(1,hypothesis));
prediction(1,hypothesis) =1;

if(decision_dir_array(1,hypothesis)==1)
if(test.X(sample,1) < decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==2)
if(test.X(sample,1) >= decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==3)
if(test.X(sample,2) > decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

if(decision_dir_array(1,hypothesis)==4)
if(test.X(sample,2) < decision_array(1,hypothesis))
prediction(1,hypothesis)=-1;
end
end

end

%Now, we have the prediction array and the alpha array,
%So, we can now make the decision based on the sign and summation

sign = prediction*transpose(alpha_array);
if(sign<0)
sign_array(sample,1) = -1;
end
%fprintf('Input val = %d %d sign %d actual val =%d\n',test.X(sample,1),test.X(sample,2),sign,test.y(sample,1));

end


