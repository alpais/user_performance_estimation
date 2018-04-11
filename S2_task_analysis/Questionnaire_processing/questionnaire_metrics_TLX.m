

qdata = load('Responses_Raw_REF_only_Good_Subjects_numericONLY.txt');

headers = {'Subject_ID', 'Gender', 'Age', 'Easy teach', 'Familiar_w_tool', 'Self_Rating', ...
    'Cooking_Frequency', 'difficult_aspect', 'Handedness', 'overall_impression',...
    'use_system_frequently', 'system_too_complex', 'system_easy_to_use', 'need_technical_support', ...
    'system_well_integrated', 'system_inconsistency', 'people_would_learn_to_use_this_system_quickly', ...
    'system_cumbersome', 'confident_w_system', 'neeed_prior_learning', ...
    'mental_demand', 'physical_demand', 'task_pace', 'successful_in_accomplishing_the_task', ... 
    'work_hard_for_your_level_of_performance', 'insecure_discouraged_irritated_stressed_annoyed' ...
};

sk_col = 6;

%% Group TLX responses 
% TLX is on a scale of 1 - 21, so we group:
%  1 -  7  as low
%  8 - 14  as medium
% 15 - 21  as high

% TLX Columns 21 - 26

mental_load_col = 21;
physical_load_col = 22; 
temp_load_col = 23;
success_col = 24;
effort_col = 25;
frustration_col = 26;

[tlx_nsk(1,1), tlx_nsk(1,2), tlx_sk(1,1), tlx_sk(1,2)] = sort_by_skill(qdata, sk_col, mental_load_col);
[tlx_nsk(2,1), tlx_nsk(2,2), tlx_sk(2,1), tlx_sk(2,2)] = sort_by_skill(qdata, sk_col, physical_load_col);
[tlx_nsk(3,1), tlx_nsk(3,2), tlx_sk(3,1), tlx_sk(3,2)] = sort_by_skill(qdata, sk_col, temp_load_col);
[tlx_nsk(4,1), tlx_nsk(4,2), tlx_sk(4,1), tlx_sk(4,2)] = sort_by_skill(qdata, sk_col, success_col);
[tlx_nsk(5,1), tlx_nsk(5,2), tlx_sk(5,1), tlx_sk(5,2)] = sort_by_skill(qdata, sk_col, effort_col);
[tlx_nsk(6,1), tlx_nsk(6,2), tlx_sk(6,1), tlx_sk(6,2)] = sort_by_skill(qdata, sk_col, frustration_col);

%% TLX Plots

%% 1. Frustration vs USe system frequently

[L1, L2, L3, L4, L5] = get_sorted_stats_5Levels(qdata, 18, 1:5);

avgs{1} = [mean(L1(:,success_col)) mean(L2(:,success_col)) mean(L3(:,success_col)) mean(L4(:,success_col)) mean(L5(:,success_col))];
stds{1} = [std(L1(:,success_col)) std(L2(:,success_col)) std(L3(:,success_col)) std(L4(:,success_col)) std(L5(:,success_col))];

figure; hold on;

sticklabels = 1:5; 
slegend = {'System Cumbersome'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);

x_labels{1} = sprintf('1 - Strongly \n Disagree');
x_labels{2} = sprintf('2 - Disagree');
x_labels{3} = sprintf('3 - Neutral');
x_labels{4} = sprintf('4 - Agree');
x_labels{5} = sprintf('5 - Strongly \n Agree');
set(gca,'XTickLabel', {'','','','',''});
[hx,hy] = format_ticks(gca, x_labels, [], [], [], 45, -0.2);

% ylabel('TLX Success rate');
% ylim([0 20]); yticks(1:5:20);

%% 1. Frustration vs USe system frequently

[L1, L2, L3, L4, L5] = get_sorted_stats_5Levels(qdata, 11, 1:5);

avgs{1} = [mean(L1(:,26)) mean(L2(:,26)) mean(L3(:,26)) mean(L4(:,26)) mean(L5(:,26))];
stds{1} = [std(L1(:,26)) std(L2(:,26)) std(L3(:,26)) std(L4(:,26)) std(L5(:,26))];

figure; hold on;

sticklabels = 1:5; 
slegend = {''};

plot_with_error_bar(avgs, stds, slegend, sticklabels);

x_labels{1} = sprintf('1 - Strongly \n Disagree');
x_labels{2} = sprintf('2 - Disagree');
x_labels{3} = sprintf('3 - Neutral');
x_labels{4} = sprintf('4 - Agree');
x_labels{5} = sprintf('5 - Strongly \n Agree');
set(gca,'XTickLabel', {'','','','',''});
[hx,hy] = format_ticks(gca, x_labels, [], [], [], 45, -0.2);


% format_tick(h,tickx,ticky,tickposx,tickposy,rotx,roty,offset,...
%                      varargin);

%% <various> vs Perceived success rate

% By skill
[L1, L2, L3, L4, L5] = get_sorted_stats_5Levels(qdata, sk_col, 1:5);
avgs{1} = [mean(L2(:,success_col)) mean(L3(:,success_col)) mean(L4(:,success_col)) mean(L5(:,success_col))];
stds{1} = [std(L2(:,success_col)) std(L3(:,success_col)) std(L4(:,success_col)) std(L5(:,success_col))];

% By cumbersome
% [L1, L2, L3, L4, L5] = get_sorted_stats_5Levels(qdata, 6, 1:5);
% avgs{1} = [mean(L1(:,26)) mean(L2(:,26)) mean(L3(:,26)) mean(L4(:,26)) mean(L5(:,26))];
% stds{1} = [std(L1(:,26)) std(L2(:,26)) std(L3(:,26)) std(L4(:,26)) std(L5(:,26))];



sticklabels = 1:4; 
slegend = {'Self asessed skill'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);

%x_labels{1} = sprintf('1 - Strongly \n Disagree');
x_labels{1} = sprintf('2 - Low');
x_labels{2} = sprintf('3 - Medium');
x_labels{3} = sprintf('4 - High');
x_labels{4} = sprintf('5 - Very \n High');
set(gca,'XTickLabel', {'','','',''});
[hx,hy] = format_ticks(gca, x_labels, [], [], [], 45, -0.2);

ylabel('Perceived success rate');

set(gcf, 'Position', [290   102   716   894]);
set(gca, 'Position ', [0.1732    0.2514    0.7968    0.6986]);

%% Test Anova on TLX

factors_cols = [2:20]; 

for i = 1:6
    for jj = 1:length(factors_cols)
        anova_tlx{i}(jj) = anova1(qdata(:,i+20), qdata(:,factors_cols(jj)));
        if (anova_tlx{i}(jj) <= 0.05)
            fprintf('Factor %d %s - effect on TLX %d %s,  \n', factors_cols(jj), headers{factors_cols(jj)}, i, headers{i+20});
        end
    end
end
    
