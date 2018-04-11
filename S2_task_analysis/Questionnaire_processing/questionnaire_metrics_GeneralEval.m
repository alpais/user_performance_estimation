

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


%% Dificult aspect - glove, robot arm, tool.

[arm, glove, tool] = get_sorted_stats_3cases(qdata, 8, [1 2 3]);

% average by skill
avgs{1} = [mean(glove(:,sk_col)) mean(arm(:,sk_col))  mean(tool(:,sk_col))];
stds{1} = [std(glove(:,sk_col)) std(arm(:,sk_col))  std(tool(:,sk_col))];

% Average by how familiar they were with the tool
fam_tool_col = 5;
avgs{2} = [mean(glove(:,fam_tool_col)) mean(arm(:,fam_tool_col))  mean(tool(:,fam_tool_col))];
stds{2} = [std(glove(:,fam_tool_col)) std(arm(:,fam_tool_col))  std(tool(:,fam_tool_col))];

sticklabels = {'glove', 'arm', 'tool'}; 
slegend = {'Sell assessed skill', 'Familiarity with the tool'};
plot_with_error_bar(avgs, stds, slegend, sticklabels);

ylim auto; ylabel('General ratings'); xlabel('Difficult aspect of the task');


%%

[avg_arm_nsk, std_arm_nsk, avg_arm_sk, std_arm_sk] = sort_by_skill(arm, sk_col, 8);
[avg_glove_nsk, std_glove_nsk, avg_glove_sk, std_glove_sk] = sort_by_skill(glove, sk_col, 8);
[avg_tool_nsk, std_tool_nsk, avg_tool_sk, std_tool_sk] = sort_by_skill(tool, sk_col, 8);

avgs{1} = [avg_arm_nsk avg_glove_nsk avg_tool_nsk]';
avgs{2} = [avg_arm_sk avg_glove_sk avg_tool_sk]';
stds{1} = [std_arm_nsk std_glove_nsk std_tool_nsk]';
stds{2} = [std_arm_sk std_glove_sk std_tool_sk]';

sticklabels = {'arm', 'glove', 'tool'}; 
slegend = {'Low skilled', 'High skilled'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim auto; ylabel('Self-assessed Skill'); xlabel('Difficult aspect of the task');

avg_sus_df = [avg_arm_nsk avg_arm_sk; avg_glove_nsk avg_glove_sk; avg_tool_nsk avg_tool_sk];
std_sus_df = [std_arm_nsk std_arm_sk; std_glove_nsk std_glove_sk; std_tool_nsk std_tool_sk];

plot_grouped_plot(avg_sus_df, std_sus_df, sticklabels, slegend);
format_grouped_plot('Self assessed skill','Difficult aspect of the task', [0 1.5]);
ylim auto

