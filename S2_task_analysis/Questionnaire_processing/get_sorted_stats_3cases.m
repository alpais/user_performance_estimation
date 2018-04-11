function [case_A, case_B, case_C] = get_sorted_stats_3cases( metrics, column, values)
%GET_SORTED_STATS_3CASES Summary of this function goes here
%   Detailed explanation goes here

case_A = []; case_B = []; case_C = [];

for i = 1:size(metrics,1)
    if metrics(i,column) == values(1)
        case_A = [case_A; metrics(i,:)];
    elseif metrics(i,column) == values(2)
        case_B = [case_B; metrics(i,:)];
    elseif metrics(i,column) == values(3)
        case_C = [case_C; metrics(i,:)];
    else
        disp('Unknown case');
    end
end

end

