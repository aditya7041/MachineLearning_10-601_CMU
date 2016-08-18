function [output] = pooling_layer_forward(input, layer)

%% function input:
% input.batch_size: batch_size of input
% input.height: height of input
% input.width : width of input
% input.data: the actual data of input
% input.data is of size (input.height*input.width*input.channel, input.batch_size)

% layer.k: kernel size of pooling operation
% layers.stride: stride of pooling operation
% layers.pad: pad of pooling operation


%% function output
% output: the output of inner_product_forward

% figure out the output shape
h_in = input.height;
w_in = input.width;
c_in = input.channel;
c = c_in;
batch_size = input.batch_size;

k = layer.k;
layer.pad = 0;
pad = layer.pad;
stride = layer.stride;

h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;
assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')

% set output shape
output.height = h_out;
output.width = w_out;
output.channel = c_in;
output.batch_size = batch_size;

% initialize output.data
output.data = zeros(h_out*w_out*c, batch_size);

fprintf('Pooling frwd : input dimen (conv output) : num_img=%d h=%d w=%d c=%d \n',batch_size,h_in,w_in,c_in);
fprintf('Pooling frwd : output dimen (pooling output) : num_img=%d h=%d w=%d c=%d \n',batch_size,h_out,w_out,c_in);

switch layer.act_type
    
    case 'MAX'

        for img_num= 1:batch_size
            
            orig_img = input.data(:, img_num);
            conv_output = reshape(orig_img, [h_in, w_in, c]);
            
            for depth=1:c_in
                for width=1:w_out
                    for height=1:h_out
                    
                        %fprintf('img_cnt =%d depth %d h = %d w = %d \n',img_num,depth,i,j);
                        temp_arr = zeros(1,k);
                        for row=1:k
                             nth_row = conv_output(stride*(height-1)+ row,stride*(width-1)+1:stride*(width-1)+k,depth);
                             temp_arr(1,row) = max(nth_row(:));
                        end
                        max_val = max(temp_arr(:));
                   
                        idx = h_out*w_out*(depth-1) + h_out*(width-1) + height;
                        %fprintf(' idx %d',idx);
                        output.data(idx,img_num) = max_val;
                        
                    end
                end
            end
            
        end
        
        
    case 'AVE'
        
        
        for img_num= 1:batch_size
            
            orig_img = input.data(:, img_num);
            conv_output = reshape(orig_img, [h_in, w_in, c]);
            
            for depth=1:c_in
                for width=1:w_out
                    for height=1:h_out
                    
                        %fprintf('img_cnt =%d depth %d h = %d w = %d \n',img_num,depth,i,j);
                        temp_arr = zeros(1,k);
                        for row=1:k
                             nth_row = conv_output(stride*(height-1)+ row,stride*(width-1)+1:stride*(width-1)+k,depth);
                             temp_arr(1,row) = sum(nth_row(:));
                        end
                        avg_val = sum(temp_arr(:));
                        avg_val = avg_val/(k*k);
                   
                        idx = h_out*w_out*(depth-1) + h_out*(width-1) + height;
                        output.data(idx,img_num) = avg_val;
                        
                    end
                end
            end
            
        end
          
end


