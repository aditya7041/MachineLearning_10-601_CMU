function [input_od] = relu_backward(output, input, layer)

%% function input
% output.data: output data of relu_forward
% output.diff: gradient w.r.t output.data

%% function output
% input_od: gradient w.r.t input.data

%% here begins the relu forward computation

% initialize
input_od = zeros(size(input.data));
inputdata = input.data;
% layer.num is the number of input and output units for Relu layer per 
fprintf(' \n-------------Relu backward-------------- \n');
fprintf('relu backward : input_od dim %d %d \n', size(inputdata,1), size(inputdata,2));

output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;
batch_size = input.batch_size;

fprintf('relu backward : output diff dim %d %d \n', size(output.diff,1), size(output.diff,2));
h_in = input.height;
w_in = input.width;
c_in = input.channel;

fprintf('relu backward : output data dim %d %d \n', size(output.data,1), size(output.data,2));

fprintf('relu backward : Printing 10 units of output.data : \n');
for i=1:10
    fprintf(' %d',output.data(i,1));
end
fprintf('\n');

fprintf('\nrelu backward : Printing 10 units of output.diff (from loss func) : \n');
for i=1:10
    fprintf(' %d',output.diff(i,1));
end
fprintf('\n');

% start to work here to compute input_od
for img_num= 1:batch_size
            
    for i=1:size(output.data,1)
        if output.data(i,img_num)==0
            input_od(i,img_num)=0;
        else
            input_od(i,img_num) = output.diff(i,img_num);
        end
    end
    
end

fprintf('\nrelu backward : Printing 10 units of input.od : \n');
for i=1:10
     fprintf(' %d',input_od(i,1));
end
    

