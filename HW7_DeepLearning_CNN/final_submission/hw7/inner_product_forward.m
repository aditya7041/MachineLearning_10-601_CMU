function [output] = inner_product_forward(input, layer, param)

%% function input:
% input.batch_size: batch_size of input
% input.height: height of input
% input.width : width of input
% input.data: the actual data of input
% input.data is of size (input.height*input.width*input.channel, input.batch_size)
% layer.num: output dimension of this layer

% param.w: weight parameter of this layer, is of size 
% (input.height*input.width*input.channel, layer.num)
% param.b: bias parameter of this layer, is of size
% (1, layer.num);

%% function output
% output: the output of inner_product_forward


%% here begins the inner product forward computation
% set the shape of output
output.height = 1;
output.width = 1;
output.channel = layer.num;
output.batch_size = input.batch_size;
batch_size = output.batch_size;

%input dimensions (last pooling layer output)
h_in = input.height;
w_in = input.width;
c_in = input.channel;

% sanity check
d = size(input.data, 1);
assert(size(param.w, 1) == d, 'dimension mismatch in inner_product layer');

% initialize the outupt data
output.data = zeros(layer.num, input.batch_size);
fprintf('\n IP frwd : input dimen (pool output) num_img=%d h=%d w=%d c=%d \n',batch_size,h_in,w_in,c_in);

% params of this layer : w = 
% params{i-1}.w = rand(h*w*c, layers{i}.num); 800*500
% params{i-1}.b = zeros(1, layers{i}.num); b-> 1*500
w = param.w;
b = param.b;
fprintf('IP frwd : w dimension = %d %d b dim = %d %d\n',size(w,1),size(w,2),size(b,1),size(b,2));
orig_data = input.data(:, 1);
fprintf('IP frwd : size of input %d %d \n',size(orig_data,1),size(orig_data,2));

% start to work here to compute output.data  
for img_num= 1:batch_size
            
      orig_data = input.data(:, img_num);
      
      for i=1:layer.num
            output.data(i,img_num) = sum(orig_data(:,1).*w(:,i)) + b(i);
      end
end
