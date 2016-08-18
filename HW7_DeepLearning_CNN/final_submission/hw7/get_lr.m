function lr_t = get_lr(iter, epsilon, gamma, power)
% get the learning rate at step iter
    lr_t=0;
    denom = (1+ gamma*iter).^power;
    lr_t = epsilon/denom;
end
