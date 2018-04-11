%% Get skilled and unskilled data per segment

load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');

load('../S2_task_analysis/metrics_all_per_subject_Segm1_NVR.mat');
sgm_reach_data = S1_metrics_all;

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
sgm_scoop_data = S2_metrics_all;

load('../S2_task_analysis/metrics_all_per_subject_Segm3_NVR.mat');
sgm_trash_data = S3_metrics_all;

sk_idx = find(S1_metrics_all(:,3) == 1);
nsk_idx = find(S1_metrics_all(:,3) == 0);

reach_sk_data = sgm_reach_data(sk_idx, :);
reach_nsk_data = sgm_reach_data(nsk_idx, :);

scoop_sk_data = sgm_scoop_data(sk_idx, :);
scoop_nsk_data = sgm_scoop_data(nsk_idx, :);

trash_sk_data = sgm_trash_data(sk_idx, :);
trash_nsk_data = sgm_trash_data(nsk_idx, :);

% Sgm duration - col 8

%% Compute ANOVA

% For skill rating
[a,b] = anova1(sgm_reach_data(:,8), sgm_reach_data(:,3), 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: auto-skill; Metric: Segment 1 - %s \n', b{2,5}, a, nh{8});

[a,b] = anova1(sgm_scoop_data(:,8), sgm_scoop_data(:,3));
fprintf('F = %.2f, p-value = %.3f, Factor: auto-skill; Metric: Segment 2 - %s \n', b{2,5}, a, nh{8});

[a,b] = anova1(sgm_trash_data(:,8), sgm_trash_data(:,3));
fprintf('F = %.2f, p-value = %.3f, Factor: auto-skill; Metric: Segment 3 - %s \n', b{2,5}, a, nh{8});

%% Compute ANOVA for dem rating

% For dem arting
for i = 1:size(sgm_scoop_data,1) 
    if sgm_scoop_data(i,28)>0.8 
        dem_rate(i) = 1; 
    else dem_rate(i) = 0; 
    end; 
end

[a,b] = anova1(sgm_reach_data(:,8), dem_rate, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: dem-rate; Metric: Segment 1 - %s \n', b{2,5}, a, nh{8});

[a,b] = anova1(sgm_scoop_data(:,8), dem_rate, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: dem-rate; Metric: Segment 2 - %s \n', b{2,5}, a, nh{8});

[a,b] = anova1(sgm_trash_data(:,8), dem_rate, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: dem-rate; Metric: Segment 3 - %s \n', b{2,5}, a, nh{8});

%% Compute correlations for segment duration

for i = 1:size(S2_metrics_all,2)
    vcr = corr(S2_metrics_all(:,i), S2_metrics_all(:,8), 'Type', 'Spearman');
    if (abs(vcr) > 0.3)
        fprintf('%.2f \t Spearman corr - %s - %s \n', vcr, nh{8}, nh{i});
    end
end

%% Compute correlations for Task total duration

for i = 1:size(S2_metrics_all,2)
    vcr = corr(S2_metrics_all(:,i), S2_metrics_all(:,5), 'Type', 'Spearman');
    if (abs(vcr) > 0.2)
        fprintf('%.2f \t Spearman corr - %s - %s \n', vcr, nh{5}, nh{i});
    end
end

%% Print stats

fprintf('\n');
fprintf('S1 - Reach Duration, skilled: %.2f, std %.2f \n', mean(reach_sk_data(:,8))/sampling_freq, std(reach_sk_data(:,8))/sampling_freq);
fprintf('S2 - Scoop Duration, skilled: %.2f, std %.2f \n', mean(scoop_sk_data(:,8))/sampling_freq, std(scoop_sk_data(:,8))/sampling_freq);
fprintf('S3 - Trash Duration, skilled: %.2f, std %.2f \n', mean(trash_sk_data(:,8))/sampling_freq, std(trash_sk_data(:,8))/sampling_freq);
fprintf('\n');
fprintf('S1 - Reach Duration, unskilled: %.2f, std %.2f \n', mean(reach_nsk_data(:,8))/sampling_freq, std(reach_nsk_data(:,8))/sampling_freq);
fprintf('S2 - Scoop Duration, unskilled: %.2f, std %.2f \n', mean(scoop_nsk_data(:,8))/sampling_freq, std(scoop_nsk_data(:,8))/sampling_freq);
fprintf('S3 - Trash Duration, unskilled: %.2f, std %.2f \n', mean(trash_nsk_data(:,8))/sampling_freq, std(trash_nsk_data(:,8))/sampling_freq);
fprintf('\n');
fprintf('Total task time - skilled: %.2f, std %.2f \n', mean(S2_metrics_all(sk_idx,5)), std(S2_metrics_all(sk_idx,5)));
fprintf('Total task time - unskilled: %.2f, std %.2f \n', mean(S2_metrics_all(nsk_idx,5)), std(S2_metrics_all(nsk_idx,5)));

%% Plotting

sampling_freq = 100;

avg_sgm_len_sk = [mean(reach_sk_data(:,8)) mean(scoop_sk_data(:,8)) mean(trash_sk_data(:,8)) ]/sampling_freq;
std_sgm_len_sk = [std(reach_sk_data(:,8)) std(scoop_sk_data(:,8)) std(trash_sk_data(:,8))]/sampling_freq;

avg_sgm_len_nsk = [mean(reach_nsk_data(:,8)) mean(scoop_nsk_data(:,8)) mean(trash_nsk_data(:,8)) ]/sampling_freq;
std_sgm_len_nsk = [std(reach_nsk_data(:,8)) std(scoop_nsk_data(:,8)) std(trash_nsk_data(:,8)) ]/(sampling_freq);

avgs{1} = [avg_sgm_len_sk mean(S2_metrics_all(sk_idx,5))];   stds{1} = [std_sgm_len_sk std(S2_metrics_all(sk_idx,5))];
avgs{2} = [avg_sgm_len_nsk mean(S2_metrics_all(nsk_idx,5))];  stds{2} = [std_sgm_len_nsk std(S2_metrics_all(nsk_idx,5))];

sticklabels = {'Reach','Scoop', 'Trash', 'Total'};
slegend = {'Skilled', 'Unskilled'};

avg_len = [avg_sgm_len_sk; avg_sgm_len_nsk]';
std_len = [std_sgm_len_sk; std_sgm_len_nsk]';
plot_grouped_plot(avg_len, std_len, sticklabels, slegend);
format_grouped_plot('Duration (s)','Segments', [0 30]);

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylabel('Duration (s)'); xlabel('Segment');
