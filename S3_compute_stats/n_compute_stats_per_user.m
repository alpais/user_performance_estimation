
% Segment 2

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');

%% Compute correlations all against all - Spearman correlation

% for i = 1:size(S2_metrics_all, 2)
%     for j = i:size(S2_metrics_all, 2)
for i = 62:66
    for j = i:66
        quest_corr_per_subjects(i,j) = corr(S2_metrics_all(:,i), S2_metrics_all(:,j), 'Type', 'Spearman');
        %        if (corr_per_subjects(i,j) < 0.4 && corr_per_subjects(i,j) > 0.2 && i~=j)
%         if (abs(corr_per_subjects(i,j)) > 0.5 && i~=j)
            fprintf('%.2f, %s - %s \n', quest_corr_per_subjects(i,j), nh{i}, nh{j} );
%         end
    end
end

%% Correlate questionnaire ratings for skilled vs unskilled rated automatically

% Select all skilled subjects
sk_auto_skill = S2_metrics_all(find(S2_metrics_all(:,3) == 1), :);

% Select all unskilled subjects
nsk_auto_skill = S2_metrics_all(find(S2_metrics_all(:,3) == 0), :);

% Compute correlations just for the first subgroup - aka skilled ones
for i = 51:75 % Correlate questionnaire reponses with the scooped amount
    fprintf('%.2f %s \n', corr(sk_auto_skill(:,i), sk_auto_skill(:,4), 'Type', 'Spearman'), nh{i}); 
end

%
for i = 51:75 % Correlate questionnaire reponses with the scooped amount
    for j = i+1:75 % Correlate questionnaire responses 
        fprintf('%.2f %s - %s\n', corr(nsk_auto_skill(:,i), nsk_auto_skill(:,j), 'Type', 'Spearman'), nh{i}, nh{j});
    end
end

%% TLX

% Test the effect of the teaching rating (i.e. how easy it was to teach the
% robot) on the perceived temporal demand (aka TLX Task Pace)
anova1(S2_metrics_all(:,72), S2_metrics_all(:,53))
corr(S2_metrics_all(:,53), S2_metrics_all(:,72), 'Type', 'Spearman')

% physical load correlated with scooping a higher amount
corr(S2_metrics_all(:,71), S2_metrics_all(:,4), 'Type', 'Spearman')

% TLX corr mental load - need for technical feedback
corr(S2_metrics_all(:,70), S2_metrics_all(:,63), 'Type', 'Spearman')
anova1(S2_metrics_all(:,70), S2_metrics_all(:,63), 'Type', 'Spearman')


%% Compute ANOVA

% ANOVA FACTORS
auto_skill  = S2_metrics_all(:, 3); % Skill determined automatically through the task constraints
self_skill  = S2_metrics_all(:,55); % Self rating of skill by the users in the post-exp questionnaire
rated_skill = S2_metrics_all(:,76); % Skill assessed by the external video raters

anova_stats_per_user.auto_skill  = zeros(size(S2_metrics_all,2), 2);
anova_stats_per_user.self_skill  = zeros(size(S2_metrics_all,2), 2);
anova_stats_per_user.rated_skill = zeros(size(S2_metrics_all,2), 2);


%% Compute Anova for sensor metrics

exp = [7 48 49 50 55 76];

fprintf(2, '\nAnova stats for the auto-skill factor \n');

for i = 4:size(S2_metrics_all,2)
    if ismember(i, exp)
        continue
    else
        [a,b] = anova1(S2_metrics_all(:,i), auto_skill, 'off');
        fprintf('F = %.3f, p-value = %.3f, Factor: auto-skill; Metric: column %d - %s ', b{2,5}, a, i, nh{i});
        if (a < 0.05)
            fprintf('\t <<<<< Significant');
        end
        fprintf('\n')
        anova_stats_per_user.metric{i} = nh{i};
        anova_stats_per_user.auto_skill(i,1) = b{2,5};
        anova_stats_per_user.auto_skill(i,2) = a;      
        clear a b
    end
end

%% Self - skill

fprintf(2, '\nAnova stats for the self-skill factor \n');

for i = 4:size(S2_metrics_all,2)
    if ismember(i, exp)
        continue
    else
        [a,b] = anova1(S2_metrics_all(:,i), self_skill, 'off');
        fprintf('F = %.3f, p-value = %.3f, Factor: self-skill; Metric: column %d - %s ', b{2,5}, a, i, nh{i});
        if (a < 0.05)
            fprintf(' <<<<< Significant');
        end
        fprintf('\n')
        anova_stats_per_user.self_skill(i,1) = b{2,5};
        anova_stats_per_user.self_skill(i,2) = a;      
        clear a b
    end
end

%% Rated - skill

fprintf(2, '\nAnova stats for the rated-skill factor \n');

for i = 4:size(S2_metrics_all,2)
    if ismember(i, exp)
        continue
    else
        [a,b] = anova1(S2_metrics_all(:,i), rated_skill, 'off');
        fprintf('F = %.3f, p-value = %.3f, Factor: rated-skill; Metric: column %d - %s ', b{2,5}, a, i, nh{i});
        if (a < 0.05)
            fprintf(' <<<<< Significant');
        end
        fprintf('\n')
        anova_stats_per_user.rated_skill(i,1) = b{2,5};
        anova_stats_per_user.rated_skill(i,2) = a;      
        clear a b
    end
end

%% Save anova metrics
save('anova_stats_per_user_Segm2.mat','anova_stats_per_user','-mat')

%% Other anova stats:

% Use as factors the questionnaire ratings on the sensor and video metrics

quest_fact = 51:75;
exp = [exp quest_fact];

for quest_fact = 51:75
    for i = 4:size(S2_metrics_all,2)
        if ismember(i, exp)
            continue
        else
            [a,b] = anova1(S2_metrics_all(:,i), S2_metrics_all(:,quest_fact), 'off');
            if (a < 0.05) % Display only significant interactions
                fprintf('F = %.3f, p-value = %.3f, Factor: %d - %s; Metric: column %d - %s ', b{2,5}, a, quest_fact, nh{quest_fact}, i, nh{i});
                fprintf(' <<<<< Significant');
                fprintf('\n')
            end
            clear a b
        end
    end
end

