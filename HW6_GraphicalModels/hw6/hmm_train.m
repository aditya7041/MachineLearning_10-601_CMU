
function [hmm_params] = hmm_train(state_seqs, obs_seqs, n, m, alpha_obs, alpha_trans)

    assert (length(state_seqs) == length(obs_seqs));

    % n -> number of tags/states, m -> number of unique words
    % Initialization of the tables for the counts.
    c_theta = zeros(n, n);
    c_theta_start = zeros(1, n);
    c_theta_stop = zeros(n, 1);
    c_gamma = zeros(n, m);

    %% Your code goes here. Collect the statistics from the data.
    for sen_idx =1:length(state_seqs)
        
        sentence_seq = state_seqs{sen_idx};
        
        %fprintf('\n sentence seq len = %d', length(sentence_seq));
        %sentence_seq
        
        for idx=1:length(sentence_seq)
            
            state_idx=sentence_seq(1,idx);
            %fprintf(' \n idx = %d, state = %d : ',idx, state_idx);
            
            if idx == 1
                c_theta_start(1,state_idx) = c_theta_start(1,state_idx)+1;
                %fprintf('theta_start(%d) = %d ',state_idx,c_theta_start(1,state_idx));
            end
  
            if idx == length(sentence_seq)
                c_theta_stop(state_idx,1) = c_theta_stop(state_idx,1)+1;
                 %fprintf('theta_stop(%d) = %d ',state_idx,c_theta_stop(state_idx,1));
            end
            
            if idx ~= length(sentence_seq)
                c_theta(sentence_seq(idx),sentence_seq(idx+1)) = c_theta(sentence_seq(idx),sentence_seq(idx+1))+1 ;
                %fprintf('c_theta(%d,%d) = %d ',sentence_seq(idx),sentence_seq(idx+1),c_theta(sentence_seq(idx),sentence_seq(idx+1)));
            end
        
        end
    end
    
    for exam_num=1:length(obs_seqs)
       
        word_arr = obs_seqs{1,exam_num};
        tag_arr = state_seqs{1,exam_num};
        
        %fprintf('sample %d word_arr_size %d \n',exam_num,size(word_arr,2));
        
        for idx=1:length(word_arr)
            word_idx = word_arr(1,idx);
            tag_idx = tag_arr(1,idx);
            c_gamma(tag_idx,word_idx) = c_gamma(tag_idx,word_idx)+1;
        end
     
    end
    
    %% c_gamma from the other function
    %c_gamma = baseline_train(state_seqs,obs_seqs, n, m);   
    
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

