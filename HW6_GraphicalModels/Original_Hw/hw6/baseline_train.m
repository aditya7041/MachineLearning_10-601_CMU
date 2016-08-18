
function [baseline_params] = baseline_train(state_seqs, obs_seqs, n, m)
    assert (length(state_seqs) == length(obs_seqs));

    c_gamma = zeros(n, m);

    %% Your code goes here. Collecting the co-occurrence statistics.

    baseline_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end
