function [avg_nsk, std_nsk, avg_sk, std_sk ] = sort_by_skill(metrics, skill_col, col_to_avg)
%SORT_BY_SKILL - also provides avg and std for a given column for each
%skill

sk_sorted = sortrows(metrics, skill_col);

% we group by skill level such that:
% Levels 1 - 3 represent low skill 
% Levels 4 - 5 high skill

a = find(sk_sorted(:,6)<4);

nsk = sk_sorted(1:length(a),:);
sk = sk_sorted(length(a)+1:end,:);

avg_nsk = mean(nsk(:,col_to_avg));
std_nsk = std(nsk(:,col_to_avg));

avg_sk = mean(sk(:,col_to_avg));
std_sk = std(sk(:,col_to_avg));

end

