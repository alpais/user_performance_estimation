function [case_A, case_B] = get_sorted_stats( metrics, column, values )

% For two values, returns two vectors

case_A = []; case_B = [];

for i = 1:size(metrics,1)
    if metrics(i,column) == values(1)
        case_A = [case_A; metrics(i,:)];
    elseif metrics(i,column) == values(2)
        case_B = [case_B; metrics(i,:)];
    else
        disp('Unknown case');
    end
end

end

