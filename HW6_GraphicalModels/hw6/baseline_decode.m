
function [pred_state_seqs] = baseline_decode(baseline_params, obs_seqs)
    gamma = baseline_params.gamma;
    pred_state_seqs = cell(1, length(obs_seqs));

    %% Remove from here
    for k = 1:length(obs_seqs)
        
        ob_seq = obs_seqs{k};
        Tk = length(ob_seq);

        % Independent prediction for each symbol.
        pred_st_seq = zeros(1, Tk);

        %% Your code goes here. Independent prediction of each label.
        for idx=1:Tk
             max_val = max(gamma(:,ob_seq(idx)));
             pred_st_seq(1,idx)=find(gamma(:,ob_seq(idx))==max_val);
        end
        
        pred_state_seqs{k} = pred_st_seq;
    end
    
end

