load lr_train.mat;

% initialize
epsilon = 1e-6;
num_iter = 1;

w = rand(size(train.X, 1), 1) * 1e-4;
d = length(w);
err = zeros(d, 1);

[f, g] = fv_grad(w, train.X, train.y);

for i = 1 : num_iter
    grad_approx = zeros(d, 1);
   
    for j = 1 : d
        % my code
    end
    err(i) = 1 / d * sum(abs(grad_approx - g));
end

if mean(err) < 1e-6
    fprintf('pass!')
else
    fprintf('fail.')
end