function [output] = relu_forward(input, layer)

%% function input
% input.data: actual input data of relu layer
h_in = input.height;
w_in = input.width;
c_in = input.channel;
batch_size = input.batch_size;

%% function output
% output: the output of relu_forward function

%% here begins the relu forward computation

% set the shape of output
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% input dimensions
fprintf('\n IP frwd : input dimen (pool output) num_img=%d h=%d w=%d c=%d \n',batch_size,h_in,w_in,c_in);
orig_img = input.data(:, 1);
fprintf(' Relu frwd : input size = %d %d \n',size(orig_img,1), size(orig_img,2));

% start to work here to compute output.data
for img_num= 1:batch_size
            
    input_data = input.data(:, img_num);
        
    for i=1:h_in*w_in*c_in
        if input_data(i) <=0 
            input_data(i)=0;
        end
    end
    
    output.data(:,img_num) =  input_data; 
end

end
