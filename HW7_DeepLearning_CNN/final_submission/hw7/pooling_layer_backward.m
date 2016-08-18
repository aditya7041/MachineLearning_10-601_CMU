function [input_od] = pooling_layer_backward(output, input, layer)

%% function input:
% input: input of pooling_layer_forward
% output: output of pooling_layer_forward

% layer.k: kernel size of pooling operation
% layer.stride: stride of pooling operation
% layer.pad: pad of pooling operation


%% function output
% input_od: gradient w.r.t input.data

% initialize
input_od = zeros(size(input.data));
% Copy the params here 
k = layer.k;
stride = layer.stride;
pad = layer.pad;

% Debug msgs
fprintf('\n------------Pooling backward-------------\n');
fprintf(' input.data size %d %d \n',size(input.data,1),size(input.data,2));
fprintf(' input h %d',input.height);
fprintf(' k %d stride %d pad %d\n',k,stride,pad);
fprintf(' input_od(conv layer) size %d %d \n',size(input_od,1),size(input_od,2));
fprintf(' output.diff size %d %d \n',size(output.diff,1),size(output.diff,2));
fprintf(' output.data size %d %d \n',size(output.data,1),size(output.data,2));

fprintf(' input data %d %d %d %d',input.data(1,1),input.data(2,1),input.data(3,1),input.data(4,1)); 

h_in = input.height; %8
w_in = input.width; %8
c_in = input.channel;%50
c = c_in;
h_out = (h_in + 2*pad - k) / stride + 1; %4
w_out = (w_in + 2*pad - k) / stride + 1; %4

fprintf(' input(conv layer) params = %d %d %d \n',h_in,w_in,c);
fprintf(' pooling layer params %d %d %d \n',h_out,w_out,c);

switch layer.act_type
    
    case 'MAX'
        
        for img = 1:size(input.data,2)
           
            % Reshape the conv layer and Pooling layer 
            con_reshape = reshape(input.data(:,img),[h_in,w_in,c]);
            pool_reshape = reshape(output.diff(:,img),[h_out,w_out,c]);
            
            for depth = 1:c
                for width = 1:w_out
                    for height = 1:h_out
                        
                        max_val=-9999;
                        max_row = 0;
                        max_col = 0;
                        
                        for row=1:k
                            for col=1:k
                              
                                if con_reshape(stride*(height-1)+row,stride*(width-1) + col,depth) > max_val
                                    max_val = con_reshape(stride*(height-1)+row,stride*(width-1) + col,depth);
                                    max_row = stride*(height-1) + row;
                                    max_col = stride*(width-1) + col;
                                end
                                
                            end 
                        end
                        
                        %result(max_row,max_col,depth) = pool_reshape(height,width,depth);
                        idx = h_in*w_in*(depth-1) + h_in*(max_col-1) + max_row;
                        input_od(idx,img) = pool_reshape(height,width,depth);
                        
                    end
                end
            end
            
        end
            
    case 'AVE'
        % work out the ave pooling backward and compute input_od        

        for img = 1:size(input.data,2)
          
            pool_reshape = reshape(output.diff(:,img),[h_out,w_out,c]);
            
            for depth = 1:c
                for width = 1:w_out
                    for height = 1:h_out
                        
                        for row=1:k
                            for col=1:k
                                 a = stride*(height-1)+row;
                                 b = stride*(width-1) + col;
                                 idx = h_in*w_in*(depth-1) + h_in*(b-1) + a;
                                 input_od(idx,img) = pool_reshape(height,width,depth)/(k*k);
                            end 
                        end
                        
                    end
                end
            end
            
        end
end

end