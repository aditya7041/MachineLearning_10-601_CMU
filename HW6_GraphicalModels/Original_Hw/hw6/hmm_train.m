
function [hmm_params] = hmm_train(state_seqs, obs_seqs, n, m, alpha_obs, alpha_trans)

    assert (length(state_seqs) == length(obs_seqs));

    % Initialization of the tables for the counts.
    c_theta = zeros(n, n);
    c_theta_start = zeros(1, n);
    c_theta_stop = zeros(n, 1);
    c_gamma = zeros(n, m);

    %% Your code goes here. Collect the statistics from the data.

    % Adding smoothing.
    c_theta = c_theta + alpha_trans;
    c_theta_start = c_theta_start + alpha_trans;
    c_theta_stop = c_theta_stop + alpha_trans;
    c_gamma = c_gamma + alpha_obs;

    % The sum of the transitions out of each of the states.
    c_trans = sum(c_theta, 2) + sum(c_theta_stop, 2);

    hmm_params.theta = c_theta ./ repmat(c_trans, 1, n);
    hmm_params.theta_start = c_theta_start ./ sum(c_theta_start, 2);
    hmm_params.theta_stop = c_theta_stop ./ c_trans;
    hmm_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end

