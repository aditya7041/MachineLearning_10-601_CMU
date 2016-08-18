function [params, param_winc] = sgd_momentum(rate, mu, weight_decay, params, param_winc, param_grad)
% update the parameter with sgd with momentum

%% function input
% rate: learning rate at current step
% mu: momentum
% weight_decay: weigth decay of w
% params: original weight parameter
% param_winc: buffer to store history gradient accumulation
% param_grad: gradient of parameter

%% function output
% params: updated parameters
% param_winc: updated buffer

fprintf(' SGD momentum...');

% Length(params) = 7

for idx =1:length(params)
    
    param_winc{idx}.b = mu.*param_winc{idx}.b + rate.*param_grad{idx}.b;
    params{idx}.b = params{idx}.b - param_winc{idx}.b;
   
    reg_grad = param_grad{idx}.w + weight_decay.*params{idx}.w;
    param_winc{idx}.w = mu.*param_winc{idx}.w + rate.*reg_grad;
    params{idx}.w = params{idx}.w - param_winc{idx}.w;
    
end

end
