function [case_A, case_B, case_C, case_D, case_E] = get_sorted_stats_5Levels(metrics, column, values)
%for 5 - Level Likert scale evaluations

case_A = []; case_B = []; case_C = []; case_D = []; case_E = [];

if (length(values)~=5)
    disp('wrong selection column');
    exit;
end

for i = 1:size(metrics,1)
    if metrics(i,column) == values(1)
        case_A = [case_A; metrics(i,:)];
    elseif metrics(i,column) == values(2)
        case_B = [case_B; metrics(i,:)];
    elseif metrics(i,column) == values(3)
        case_C = [case_C; metrics(i,:)];
    elseif metrics(i,column) == values(4)
        case_D = [case_D; metrics(i,:)];
    elseif metrics(i,column) == values(5)
        case_E = [case_E; metrics(i,:)];
    else
        disp('Unknown case');
    end
end

end

