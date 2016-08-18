
function [pred_state_seqs] = hmm_decode(hmm_params, obs_seqs)
    % Working directly in log domain, as it is more numerically stable.
    log_theta = log(hmm_params.theta);
    log_theta_start = log(hmm_params.theta_start);
    log_theta_stop = log(hmm_params.theta_stop);
    log_gamma = log(hmm_params.gamma);
    [n, m] = size(log_gamma); 

    pred_state_seqs = cell(1, length(obs_seqs));

    for k = 1:length(obs_seqs)
        ob_seq = obs_seqs{k};
        Tk = length(ob_seq);

        pred_st_seq = zeros(1, Tk);

        % Tables for keeping the scores and backpointers.
        scores = zeros(n, Tk);
        back_pts = zeros(n, Tk);

        %% Your code goes here. Maintain the Viterbi table and the 
        % backpointer table. Recover the most probable assignment.

        pred_state_seqs{k} = pred_st_seq;
    end
end

