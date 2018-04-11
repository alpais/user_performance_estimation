function [sk, avg_sk, std_sk ] = sort_by_skill(metrics, col)
%SORT_BY_SKILL - also provides avg and std for a given column for each
%skill

% Sort arrays by skill >>> assume skill is on column 5
sk_sorted = sortrows(metrics, 5);
% Get indexes where skill changes
idx = [1; find(diff(sk_sorted(:,5)) == 1); size(sk_sorted,1)];

for i = 1:length(idx)-1    
    sk{i} = sk_sorted(idx(i):idx(i+1),:);
end

avg_sk = [mean(sk{1}(:,col)) mean(sk{2}(:,col)) mean(sk{3}(:,col)) mean(sk{4}(:,col)) mean(sk{5}(:,col))];
std_sk = [std(sk{1}(:,col)) std(sk{2}(:,col)) std(sk{3}(:,col)) std(sk{4}(:,col)) std(sk{5}(:,col))];

end

