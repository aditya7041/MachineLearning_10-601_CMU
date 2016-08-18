function [p] = NB_YPrior(yTrain)

%load('HW2Data.mat');
[num_doc,a] = size(yTrain);

p = sum(yTrain==1)/num_doc;

end


