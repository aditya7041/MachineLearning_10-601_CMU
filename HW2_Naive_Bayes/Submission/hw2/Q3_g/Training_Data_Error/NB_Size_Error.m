function [] = NB_Size_Error(XTest,yTest,XTrain,yTrain)

load('HW2Data.mat');

error = zeros([1 length(100:30:580)]);
count =1 ;

for m= 100:30:580
    
D = NB_XGivenY_Size(XTrain,yTrain,m);
p = sum(yTrain(1:m)==1)/length(yTrain);
fprintf('p = %d \n',p);
[yHat] = NB_Classify(D,p,XTrain);

error(count)=sum((yTrain~=yHat))/length(yTrain);
fprintf('size = %d, error = %d \n',m,error(count));
count = count+1;
    
end

data_size = 100:30:580;

figure
plot(data_size,error)
xlabel('Size'); 
ylabel('Errors'); 
title('Train data (Size vs Errors)');

end