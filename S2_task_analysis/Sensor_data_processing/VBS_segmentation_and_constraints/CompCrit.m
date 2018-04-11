function [Crit] = CompCrit(data)

exceptions = [3 5];
%exceptions = [1 2 4 6:17 20 22:44 46:49]; 
%exceptions = [1  7 8 11]; 
%exceptions = [1 4];
crt = 1;
for i = 1:size(data,1)
   if ismember(i, exceptions)
       continue;
   else
       data_c(crt,:) = data(i,:);
       crt = crt + 1;
   end
end
%disp(size(data_c));

w_width = 1000; % Window width in time samples
th_sigma = 1; 
[var_tw, var_trial] = calculate_variance_of_window_and_trial(data_c, w_width);
[n_var_tw, n_var_trials] = normalize_variances(var_tw, var_trial, th_sigma);
n_var_trials = var_trial/norm(var_trial);
n_var_tw = var_tw/norm(var_tw);
Crit = n_var_trials - n_var_tw;

end