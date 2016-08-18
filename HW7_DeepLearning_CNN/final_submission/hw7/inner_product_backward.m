function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

%% function input
% output.data: output data of inner_product_forward
% output.diff: the gradient w.r.t otuput.data

%% function output
% param_grad.w: gradient w.r.t param.w
% param_grad.b: gradient w.r.t param.b
% input_od: gradient w.r.t input.data

%% here begins inner product backward computation

% initialize the gradient w.r.t param
param_grad.w = zeros(size(param.w)); % gradient w.r.t param.w
param_grad.b = zeros(size(param.b)); % gradient w.r.t param.b
input_od = zeros(size(input.data));

% Data/params initialization
batch_size = size(input_od,2);
out_nu_size = size(param.w,1);
in_nu_size = size(param.w,2);

% Debug msgs of dimensions
fprintf('\n------------IP backward------------\n');
fprintf(' w dimen %d %d \n',size(param.w,1),size(param.w,2));
fprintf(' b dimen %d %d \n',size(param.b,1),size(param.b,2));
fprintf(' input_od size %d %d \n',size(input_od,1),size(input_od,2));
fprintf(' batch size %d num_neuron(IP layer) %d \n',batch_size,in_nu_size);
fprintf(' output.diff size %d %d \n',size(output.diff,1),size(output.diff,2));
fprintf(' output.data size %d %d \n',size(output.data,1),size(output.data,2));
fprintf(' input.data size %d %d \n',size(input.data,1),size(input.data,2));

% start to work here to compute param_grad.w, param_grad.b, input_od 

for img_num=1:batch_size
    
    % update differential w.r.t w

    for out_nu = 1:out_nu_size
        sum=0;
        for in_nu = 1:in_nu_size
            %fprintf('out_nu %d in_nu %d output.diff()',output.diff(in_nu,img_num));
            param_grad.w(out_nu,in_nu) = param_grad.w(out_nu,in_nu) + output.diff(in_nu,img_num)*input.data(out_nu,img_num);
            sum = sum + output.diff(in_nu,img_num)*param.w(out_nu,in_nu);
        end
        input_od(out_nu,img_num)=sum;
    end
    
end

% update differential w.r.t b
for img_num=1:batch_size
    for in_nu = 1:in_nu_size
        param_grad.b(1,in_nu) =  param_grad.b(1,in_nu) + output.diff(in_nu,img_num);
    end
end
    
