

qdata = load('Responses_Raw_REF_only_Good_Subjects_numericONLY.txt');

qheaders = {'Subject_ID', 'Gender', 'Age', 'Easy teach', 'Familiar_w_tool', 'Self_Rating', ...
    'Cooking_Frequency', 'difficult_aspect', 'Handedness', 'overall_impression',...
    'use_system_frequently', 'system_too_complex', 'system_easy_to_use', 'need_technical_support', ...
    'system_well_integrated', 'system_inconsistency', 'people_would_learn_to_use_this_system_quickly', ...
    'system_cumbersome', 'confident_w_system', 'neeed_prior_learning', ...
    'mental_demand', 'physical_demand', 'task_pace', 'successful_in_accomplishing_the_task', ... 
    'work_hard_for_your_level_of_performance', 'insecure_discouraged_irritated_stressed_annoyed' ...
};

% SUS Rating vs Skill level

sk_col = 6;

%% For the 5 positive statements

usf_col = 11; % Use system frequently
[freq_L1_SD, freq_L2_D, freq_L3_N, freq_L4_A, freq_L5_SA] = get_sorted_stats_5Levels(qdata, usf_col, [1:5]);
avg_freq = [mean(freq_L1_SD(:,sk_col)) mean(freq_L2_D(:,sk_col)) mean(freq_L3_N(:,sk_col)) mean(freq_L4_A(:,sk_col)) mean(freq_L5_SA(:,sk_col))];
std_freq = [std(freq_L1_SD(:,sk_col)) std(freq_L2_D(:,sk_col)) std(freq_L3_N(:,sk_col)) std(freq_L4_A(:,sk_col)) std(freq_L5_SA(:,sk_col))];

seu_col = 13; % System easy to use
[seu_L1_SD, seu_L2_D, seu_L3_N, seu_L4_A, seu_L5_SA] = get_sorted_stats_5Levels(qdata, seu_col, [1:5]);
avg_seu = [mean(seu_L1_SD(:,sk_col)) mean(seu_L2_D(:,sk_col)) mean(seu_L3_N(:,sk_col)) mean(seu_L4_A(:,sk_col)) mean(seu_L5_SA(:,sk_col))];
std_seu = [std(seu_L1_SD(:,sk_col)) std(seu_L2_D(:,sk_col)) std(seu_L3_N(:,sk_col)) std(seu_L4_A(:,sk_col)) std(seu_L5_SA(:,sk_col))];

swi_col = 15; % System well integrated
[swi_L1_SD, swi_L2_D, swi_L3_N, swi_L4_A, swi_L5_SA] = get_sorted_stats_5Levels(qdata, swi_col, [1:5]);
avg_swi = [mean(swi_L1_SD(:,sk_col)) mean(swi_L2_D(:,sk_col)) mean(swi_L3_N(:,sk_col)) mean(swi_L4_A(:,sk_col)) mean(swi_L5_SA(:,sk_col))];
std_swi = [std(swi_L1_SD(:,sk_col)) std(swi_L2_D(:,sk_col)) std(swi_L3_N(:,sk_col)) std(swi_L4_A(:,sk_col)) std(swi_L5_SA(:,sk_col))];

sel_col = 17; % System easy to learn
[sel_L1_SD, sel_L2_D, sel_L3_N, sel_L4_A, sel_L5_SA] = get_sorted_stats_5Levels(qdata, sel_col, [1:5]);
sel_L1_SD = zeros(1,26);
avg_sel = [mean(sel_L1_SD(:,sk_col)) mean(sel_L2_D(:,sk_col)) mean(sel_L3_N(:,sk_col)) mean(sel_L4_A(:,sk_col)) mean(sel_L5_SA(:,sk_col))];
std_sel = [std(sel_L1_SD(:,sk_col)) std(sel_L2_D(:,sk_col)) std(sel_L3_N(:,sk_col)) std(sel_L4_A(:,sk_col)) std(sel_L5_SA(:,sk_col))];

cws_col = 19; % Confortable using the system
[cws_L1_SD, cws_L2_D, cws_L3_N, cws_L4_A, cws_L5_SA] = get_sorted_stats_5Levels(qdata, cws_col, [1:5]);
cws_L1_SD = zeros(1, 26);
avg_cws = [mean(cws_L1_SD(:,sk_col)) mean(cws_L2_D(:,sk_col)) mean(cws_L3_N(:,sk_col)) mean(cws_L4_A(:,sk_col)) mean(cws_L5_SA(:,sk_col))];
std_cws = [std(cws_L1_SD(:,sk_col)) std(cws_L2_D(:,sk_col)) std(cws_L3_N(:,sk_col)) std(cws_L4_A(:,sk_col)) std(cws_L5_SA(:,sk_col))];

avg_sus_pos = [avg_freq; avg_seu; avg_swi; avg_sel; avg_cws]';
std_sus_pos = [std_freq; std_seu; std_swi; std_sel; std_cws]';

avgs{1} = avg_freq(2:end); %avgs{2} = avg_seu(2:end); avgs{3} = avg_swi(2:end); 
avgs{2} = avg_sel(2:end); avgs{3} = avg_cws(2:end);
stds{1} = std_freq(2:end); %stds{2} = std_seu(2:end); stds{3} = std_swi(2:end); 
stds{2} = std_sel(2:end); stds{3} = std_cws(2:end);

sticklabels = 2:5; %{'1 - SD','2 - D', '3 - N', '4', '5'};
% sticklabels = {'1 - SD','2 - D', '3 - N', '4 - A', '5 - SA'};
% slegend = {'Use system frequently', 'System easy to use', 'System well integrated', 'System easy to learn', 'onfortable using the system'};
slegend = {'Use system frequently', 'System easy to learn', 'Confortable using system'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim auto; ylabel('Self-assessed Skill'); xlabel('SUS Factors');

% x_labels{1} = sprintf('1 \n Strongly \n Disagree');
% x_labels{2} = sprintf('2 \n Disagree');
% x_labels{3} = sprintf('3 \n Neutral');
% x_labels{4} = sprintf('4 \n Agree');
% x_labels{5} = sprintf('5 \n Strongly \n Agree');
% set(gca,'XTickLabel', {'','','', '', ''});
% [hx,hy] = format_ticks(gca,x_labels);

%% For the 3 negative statements
stc_col = 12; % System too complex
[stc_L1_SD, stc_L2_D, stc_L3_N, stc_L4_A, stc_L5_SA] = get_sorted_stats_5Levels(qdata, stc_col, [1:5]);
stc_L5_SA = zeros(1, 26);
avg_stc = [mean(stc_L1_SD(:,sk_col)) mean(stc_L2_D(:,sk_col)) mean(stc_L3_N(:,sk_col)) mean(stc_L4_A(:,sk_col))];% mean(stc_L5_SA(:,sk_col))];
std_stc = [std(stc_L1_SD(:,sk_col)) std(stc_L2_D(:,sk_col)) std(stc_L3_N(:,sk_col)) std(stc_L4_A(:,sk_col))]; % std(stc_L5_SA(:,sk_col))];

nts_col = 14; % Need technical support
[nts_L1_SD, nts_L2_D, nts_L3_N, nts_L4_A, nts_L5_SA] = get_sorted_stats_5Levels(qdata, nts_col, [1:5]);
avg_nts = [mean(nts_L1_SD(:,sk_col)) mean(nts_L2_D(:,sk_col)) mean(nts_L3_N(:,sk_col)) mean(nts_L4_A(:,sk_col)) mean(nts_L5_SA(:,sk_col))];
std_nts = [std(nts_L1_SD(:,sk_col)) std(nts_L2_D(:,sk_col)) std(nts_L3_N(:,sk_col)) std(nts_L4_A(:,sk_col)) std(nts_L5_SA(:,sk_col))];

sic_col = 16; % System inconsistency
[sic_L1_SD, sic_L2_D, sic_L3_N, sic_L4_A, sic_L5_SA] = get_sorted_stats_5Levels(qdata, sic_col, [1:5]);
sic_L5_SA = zeros(1, 26);
avg_sic = [mean(sic_L1_SD(:,sk_col)) mean(sic_L2_D(:,sk_col)) mean(sic_L3_N(:,sk_col)) mean(sic_L4_A(:,sk_col))]; % mean(sic_L5_SA(:,sk_col))];
std_sic = [std(sic_L1_SD(:,sk_col)) std(sic_L2_D(:,sk_col)) std(sic_L3_N(:,sk_col)) std(sic_L4_A(:,sk_col))]; % std(sic_L5_SA(:,sk_col))];

scs_col = 18; % System cumbersome
[scs_L1_SD, scs_L2_D, scs_L3_N, scs_L4_A, scs_L5_SA] = get_sorted_stats_5Levels(qdata, scs_col, [1:5]);
avg_scs = [mean(scs_L1_SD(:,sk_col)) mean(scs_L2_D(:,sk_col)) mean(scs_L3_N(:,sk_col)) mean(scs_L4_A(:,sk_col)) mean(scs_L5_SA(:,sk_col))];
std_scs = [std(scs_L1_SD(:,sk_col)) std(scs_L2_D(:,sk_col)) std(scs_L3_N(:,sk_col)) std(scs_L4_A(:,sk_col)) std(scs_L5_SA(:,sk_col))];

npl_col = 20; % Need prior learning
[npl_L1_SD, npl_L2_D, npl_L3_N, npl_L4_A, npl_L5_SA] = get_sorted_stats_5Levels(qdata, npl_col, [1:5]);
npl_L5_SA = zeros(1, 26);
avg_npl = [mean(npl_L1_SD(:,sk_col)) mean(npl_L2_D(:,sk_col)) mean(npl_L3_N(:,sk_col)) mean(npl_L4_A(:,sk_col))]; % mean(npl_L5_SA(:,sk_col))];
std_npl = [std(npl_L1_SD(:,sk_col)) std(npl_L2_D(:,sk_col)) std(npl_L3_N(:,sk_col)) std(npl_L4_A(:,sk_col))]; % std(npl_L5_SA(:,sk_col))];

clear avgs stds
%avgs{1} = avg_stc; 
avgs{1} = avg_nts; avgs{2} = avg_sic; %avgs{3} = avg_scs; 
avgs{3} = avg_npl;
%stds{1} = std_stc; 
stds{1} = std_nts; stds{2} = std_sic; %stds{3} = std_scs; 
stds{3} = std_npl;

sticklabels = 1:5; 
% sticklabels = {'1 - SD','2 - D', '3 - N', '4 - A', '5 - SA'};
% slegend = {'System too complex', 'Need technical support', 'System inconsistency', 'System cumbersome', 'Need prior learning'};
slegend = {'Need technical support', 'System inconsistency', 'Need prior learning'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim auto; ylabel('Self-assessed Skill'); xlabel('SUS Rating');

% avg_sus_neg = [avg_stc; avg_nts; avg_sic; avg_scs; avg_npl]';
% std_sus_neg = [std_stc; std_nts; std_sic; std_scs; std_npl]';
% 
% plot_grouped_plot(avg_sus_neg, std_sus_neg, sticklabels, slegend);
% format_grouped_plot('Self assessed skill','SUS Ratings', [0 1.5]);
% ylim auto


%% Test correlations

idx = [2:5 7:26];

for i = 1:26
    for j = 1:26
        corr_qdata(i,j) = corr(qdata(:,i), qdata(:, j));
        if (corr_qdata(i,j)>0.5 && i~=j)
            fprintf('r = %.2f - Pairs %d -  %d >> %s - %s\n', corr_qdata(i,j), i, j, headers{i}, headers{j});
        end
    end
end

%% Test anovas for SUS

for i = 21:26
    anova_sk_sus(i) = anova1(qdata(:,6), qdata(:, i));
end


%% Stats - low skilled - high skilled

sus_freq_nsk = [freq_L1_SD; freq_L2_D; freq_L3_N];
sus_freq_sk = [freq_L4_A; freq_L5_SA];

sus_freq_stats = [  mean(sus_freq_nsk(:, usf_col)) mean(sus_freq_sk(:,usf_col)); ...
                    std(sus_freq_nsk(:,usf_col)) std(sus_freq_sk(:, usf_col))]
%%
sus_seu_nsk = [seu_L1_SD; seu_L2_D; seu_L3_N];
sus_seu_sk = [seu_L4_A; seu_L5_SA];

sus_seu_stats = [  mean(sus_seu_nsk(:, seu_col)) mean(sus_seu_sk(:, seu_col)); ...
                    std(sus_seu_nsk(:, seu_col)) std(sus_seu_sk(:, seu_col))]
%% well integrated
sus_swi_nsk = [swi_L1_SD; swi_L2_D; swi_L3_N];
sus_swi_sk = [swi_L4_A; swi_L5_SA];

sus_swi_stats = [  mean(sus_swi_nsk(:, swi_col)) mean(sus_swi_sk(:, swi_col)); ...
                    std(sus_swi_nsk(:, swi_col)) std(sus_swi_sk(:, swi_col))]

%% easy to learn
sus_sel_nsk = [sel_L1_SD; sel_L2_D; sel_L3_N];
sus_sel_sk = [sel_L4_A; sel_L5_SA];

sus_sel_stats = [  mean(sus_sel_nsk(:, sel_col)) mean(sus_sel_sk(:, sel_col)); ...
                    std(sus_sel_nsk(:, sel_col)) std(sus_sel_sk(:, sel_col))]
%% confident
sus_cws_nsk = [cws_L1_SD; cws_L2_D; cws_L3_N];
sus_cws_sk = [cws_L4_A; cws_L5_SA];

sus_cws_stats = [  mean(sus_cws_nsk(:, cws_col)) mean(sus_cws_sk(:, cws_col)); ...
                    std(sus_cws_nsk(:, cws_col)) std(sus_cws_sk(:, cws_col))]
%% - --------- Negative statements

sus_stc_nsk = [stc_L1_SD; stc_L2_D; stc_L3_N];
sus_stc_sk = [stc_L4_A; stc_L5_SA];

sus_stc_stats = [  mean(sus_stc_nsk(:, stc_col)) mean(sus_stc_sk(:, stc_col)); ...
                    std(sus_stc_nsk(:, stc_col)) std(sus_stc_sk(:, stc_col))]
%% Need technical assistance

sus_nts_nsk = [nts_L1_SD; nts_L2_D; nts_L3_N];
sus_nts_sk = [nts_L4_A; nts_L5_SA];

sus_nts_stats = [  mean(sus_nts_nsk(:, nts_col)) mean(sus_nts_sk(:, nts_col)); ...
                    std(sus_nts_nsk(:, nts_col)) std(sus_nts_sk(:, nts_col))]

                
%% SORT BY SKILL
% Positive statements
[sus_pos_nsk(1,1), sus_pos_nsk(1,2), sus_pos_sk(1,1), sus_pos_sk(1,2)] = sort_by_skill(qdata, sk_col, 11);
[sus_pos_nsk(2,1), sus_pos_nsk(2,2), sus_pos_sk(2,1), sus_pos_sk(2,2)] = sort_by_skill(qdata, sk_col, 13);
[sus_pos_nsk(3,1), sus_pos_nsk(3,2), sus_pos_sk(3,1), sus_pos_sk(3,2)] = sort_by_skill(qdata, sk_col, 15);
[sus_pos_nsk(4,1), sus_pos_nsk(4,2), sus_pos_sk(4,1), sus_pos_sk(4,2)] = sort_by_skill(qdata, sk_col, 17);
[sus_pos_nsk(5,1), sus_pos_nsk(5,2), sus_pos_sk(5,1), sus_pos_sk(5,2)] = sort_by_skill(qdata, sk_col, 19);

%Negative statemeents
[sus_neg_nsk(1,1), sus_neg_nsk(1,2), sus_neg_sk(1,1), sus_neg_sk(1,2)] = sort_by_skill(qdata, sk_col, 12);
[sus_neg_nsk(2,1), sus_neg_nsk(2,2), sus_neg_sk(2,1), sus_neg_sk(2,2)] = sort_by_skill(qdata, sk_col, 14);
[sus_neg_nsk(3,1), sus_neg_nsk(3,2), sus_neg_sk(3,1), sus_neg_sk(3,2)] = sort_by_skill(qdata, sk_col, 16);
[sus_neg_nsk(4,1), sus_neg_nsk(4,2), sus_neg_sk(4,1), sus_neg_sk(4,2)] = sort_by_skill(qdata, sk_col, 18);
[sus_neg_nsk(5,1), sus_neg_nsk(5,2), sus_neg_sk(5,1), sus_neg_sk(5,2)] = sort_by_skill(qdata, sk_col, 20);
