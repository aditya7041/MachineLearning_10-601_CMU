function [] = NB_FreqWords(XTrain,yTrain)

load('HW2Data.mat');
[n, v] = size(XTrain);
D = zeros([2 v]);

word_count = zeros([2 v]);
 
[rows,col,value]= find(XTrain);

num_eco_docs = sum(yTrain==1);
num_oni_docs = sum(yTrain==2); 

length_spare_matrix = length(rows);
    
for i = 1:length_spare_matrix
    if yTrain(rows(i),1)==1
        word_count(1,col(i)) = word_count(1,col(i))+1;
    else
        word_count(2,col(i)) = word_count(2,col(i))+1;
    end
end

D(1,:) = (word_count(1,:) + .001)/(num_eco_docs + .901);
D(2,:) = (word_count(2,:) + .001)/(num_oni_docs + .901);

%B = zeros(v);

%D(2,:) = D(2,:) ./ D(1,:);
B = D(1,:);

for i=1:5
    [M,I] = max(B);
    fprintf(' Economist : index = %d, val = %d \n',M,I);
    B(1,I)=0;
end

B = D(2,:);

for i=1:5
    [M,I] = max(B);
    fprintf(' Onion : index = %d, val = %d \n',M,I);
    B(1,I)=0;
end

D(1,:) = D(1,:) ./ D(2,:);
B = D(1,:);

for i=1:5
    [M,I] = max(B);
    fprintf(' Eco/Onion : index = %d, val = %d \n',M,I);
    B(1,I)=0;
end


D(2,:) = D(2,:) ./ D(1,:);
B = D(2,:);

for i=1:5
    [M,I] = max(B);
    fprintf(' Onion/Eco : index = %d, val = %d \n',M,I);
    B(1,I)=0;
end

end
