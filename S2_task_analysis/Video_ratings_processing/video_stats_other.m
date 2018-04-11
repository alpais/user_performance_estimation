headers = { 'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'Skill', 'Task_Pace', ...
            'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};

load('video_rating.mat');

vrdata = video_metrics_per_dem;


%% Skill vs Estimated Force and Task pace

[L1, L2, L3, L4, L5] = get_sorted_stats_5Levels(vrdata, 5, 1:5);

eFT_col = 10;
avg_eFT = [mean(L1(:, eFT_col)) mean(L2(:, eFT_col)) mean(L3(:, eFT_col)) mean(L4(:, eFT_col)) mean(L5(:, eFT_col))];
std_eFT = [std(L1(:, eFT_col)) std(L2(:, eFT_col)) std(L3(:, eFT_col)) std(L4(:, eFT_col)) std(L5(:, eFT_col))];

pace_col = 6;
avg_pace = [mean(L1(:, pace_col)) mean(L2(:, pace_col)) mean(L3(:, pace_col)) mean(L4(:, pace_col)) mean(L5(:, pace_col))];
std_pace = [std(L1(:, pace_col)) std(L2(:, pace_col)) std(L3(:, pace_col)) std(L4(:, pace_col)) std(L5(:, pace_col))];

avgs{1} = avg_eFT; avgs{2} = avg_pace;
stds{1} = std_eFT; stds{2} = std_pace;

sticklabels = 1:5; 
slegend = {'Estimated Force', 'Task Pace'};

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim auto; ylabel('Ratings'); xlabel('Demonstration performance');


%%
[P1 P2 P3] = get_sorted_stats_3cases(vrdata, pace_col, 1:3);
avg_paceFT = [mean(P1(:,eFT_col)) mean(P3(:,eFT_col)) mean(P3(:,eFT_col))];
std_paceFT = [std(P1(:,eFT_col)) std(P3(:,eFT_col)) std(P3(:,eFT_col))];
sticklabels = {'Too slow','Normal','Too fast'}; 
slegend = {'Estimated force'};

clear avgs stds
avgs{1} = avg_paceFT;
stds{1} = std_paceFT;


plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim auto; ylabel('Estimated force'); xlabel('Task Pace');

