function [var_tw, var_trial] = calculate_variance_of_window_and_trial(data ,w_width)
%% Description:
% Computes the variances over a time window and trials for a given variable
% datset (e.g. n measurements of force). The variable should be in the RF
% of the desired object and already DTW alligned.
%
% Input: data as matrix (ndem x nsamples) and w_width is the time window width 
%

%%
tic;

max_span = size(data,2); % number of time samples in data 

var_trial = zeros(1, max_span);
mean_trial = zeros(1, max_span);
each_var_time = zeros(size(data,1), max_span);
mean_each_var_time = zeros(1, max_span);

% Variance over trials (the variance of all data points at time t)
for t = 1:max_span
    var_trial(t) = var(data(:,t));
    mean_trial(t) = mean(data(:,t));
end

% Variance over a time window
for t = 1:max_span
    if t >= w_width 
        each_var_time(:,t)    = var(data(:,t+1-w_width:t),0,2);  % computes variance on rows
        mean_each_var_time(t) = mean(each_var_time(:,t));
    else
       % disp(t);
        each_var_time(:,t)    = var(data(:,1:t),0,2);
        mean_each_var_time(t) = mean(each_var_time(:,t));
    end
end
var_tw = mean_each_var_time;

toc
end

