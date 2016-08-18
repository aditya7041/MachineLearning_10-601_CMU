function [yHat] = NB_Classify(D,p,XTest)

load('HW2Data.mat');
%load('NB_XGivenY.mat');
%load('NB_YPrior.mat');

x = XTest;
[m, v] = size(x);
yHat = zeros([m 1]);

sum1 = zeros([1 v+1]);
sum2 = zeros([1 v+1]);

for doc_id=1:m

    for word=1:v
        if x(doc_id,word)==1
            sum1(1,word) = log(D(1,word));
            sum2(1,word) = log(D(2,word));
        else 
            sum1(1,word) = log(1-D(1,word));
            sum2(1,word) = log(1-D(2,word));
        end
    end
    
    sum1(1,v+1) = log(p);
    sum2(1,v+1) = log(1-p);
    
    if sum(sum1)>sum(sum2)
        yHat(doc_id,1)=1;
    else
        yHat(doc_id,1)=2;
    end
    
end

%fprintf('Original classification : Eco = %d Onion = %d \n',sum(y==1),sum(y==2));
%fprintf('My classfier : Economist(Y=1) = %d Onion(Y=2) %d\n',sum(yHat==1),sum(yHat==2));
%fprintf('Numnber of matches = %d \n',sum(y==yHat));
%fprintf('error = %d \n',sum((y~=yHat))/length(y));

end
