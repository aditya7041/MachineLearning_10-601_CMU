
function [baseline_params] = baseline_train(state_seqs, obs_seqs, n, m)
    assert (length(state_seqs) == length(obs_seqs));

    c_gamma = zeros(n, m);
    assert (length(state_seqs) == length(obs_seqs));
        
   %% Your code goes here. Collecting the co-occurrence statistics.
    
    for exam_num=1:length(obs_seqs)
       
        word_arr = obs_seqs{1,exam_num};
        tag_arr = state_seqs{1,exam_num};
        
        %fprintf('sample %d word_arr_size %d \n',exam_num,size(word_arr,2));
        
        for idx=1:length(word_arr)
            word_idx = word_arr(1,idx);
            tag_idx = tag_arr(1,idx);
            %fprintf('word idx %d tag idx %d \n',word_idx,tag_idx);
            c_gamma(tag_idx,word_idx) =  c_gamma(tag_idx,word_idx)+1;
        end
     
    end
  
    baseline_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end
