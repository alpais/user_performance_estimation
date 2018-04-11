function [n_var_tw, n_var_trials] = normalize_variances(var_tw, var_trials, th_sigma)

%   
% Output:
%   These variance are normalized in this function.
%   1) First, the data points which indicate higher than (mean+th_sigma*sigma) are discarded.
%   2) Second, the variance are normalized by (var-min / max-min)

%% 
tic;

% discard the data points that have higher variance of trials
std_trial = std(var_trials);
mean_trial = mean(var_trials);

n_var_trials = (var_trials - mean_trial)./std_trial;
n_var_trials_index = find(n_var_trials < th_sigma);
tmp_trials = [n_var_trials(n_var_trials_index)];
n_var_trials = (tmp_trials - min(tmp_trials))./ (max(tmp_trials) - min(tmp_trials));

std_tw = std(var_tw);
mean_tw = mean(var_tw);
n_var_tw     = (var_tw - mean_tw)./std_tw;
n_var_tw_index = find(n_var_tw < th_sigma);
tmp_tw = [n_var_tw(n_var_tw_index)];
n_var_tw = (tmp_tw - min(tmp_tw))./ (max(tmp_tw) - min(tmp_tw));

toc
end

