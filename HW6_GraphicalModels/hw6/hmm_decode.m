
function [pred_state_seqs] = hmm_decode(hmm_params, obs_seqs)

    % Working directly in log domain, as it is more numerically stable.
    log_theta = log(hmm_params.theta);
    log_theta_start = log(hmm_params.theta_start);
    log_theta_stop = log(hmm_params.theta_stop);
    log_gamma = log(hmm_params.gamma);
    [n, m] = size(log_gamma); 
    % n -> number of tags/states, m -> number of unique words

    pred_state_seqs = cell(1, length(obs_seqs));

    for k = 1:length(obs_seqs)
        
        ob_seq = obs_seqs{k};
        Tk = length(ob_seq); 

        pred_st_seq = zeros(1, Tk);

        % Tables for keeping the scores and backpointers.
        scores = zeros(n, Tk);
        back_pts = zeros(n, Tk);
        
        scores(:,1) = log_theta_start';

        %% Your code goes here. Maintain the Viterbi table and the 
        % backpointer table. Recover the most probable assignment.
        for curr_iter =1:Tk
            
            curr_obs = ob_seq(1,curr_iter);
            % For the first layer
            if curr_iter==1
                
                for s=1:n
                   scores(s,1) = scores(s,1) + log_gamma(s,curr_obs); 
                   back_pts(s,1) = s;
                end
               
                continue;
            end
            
            
            
            %fprintf('curr_iter = %d', curr_iter);
            for curr_state=1:n
               
                %Get the maximum score for this layers
                temp_score = zeros(1,n);
                for prev_s =1:n              
                    temp_score(1,prev_s) = scores(prev_s,curr_iter-1) + log_gamma(curr_state,ob_seq(1,curr_iter)) + log_theta(prev_s,curr_state);
                end
                
                max_score = max(temp_score);
                [max_score, max_idx] = max(temp_score);
                scores(curr_state,curr_iter) = max_score;
                %max_idx =  find(temp_score(1,:)==max_score);
                %fprintf(' max_idx = %d', max_idx);
                back_pts(curr_state,curr_iter) = max_idx;
            end
            
        end
            
        % Multiple the last row with theta_last
        for state=1:n
            scores(state,Tk) = scores(state,Tk) + log_theta_stop(state,1);
        end
        
        %Backtrace it to get the best path
        
        %Last layer best value 
        max_val = max(scores(:,Tk));
        max_idx = find(scores(:,Tk)==max_val);
        pred_st_seq(1,Tk)=max_idx;
        
        for layer=Tk:-1:2
            pred_st_seq(1,layer-1)=back_pts(max_idx,layer);
            max_idx= pred_st_seq(1,layer-1);
        end

        pred_state_seqs{k} = pred_st_seq;
    end

end

