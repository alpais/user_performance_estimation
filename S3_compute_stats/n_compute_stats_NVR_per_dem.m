

load('../S2_task_analysis/metrics_per_dem_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_per_dem_NVR.mat');

% NVR ratings 
% col 34 - scooped amount
% col 35 - ease
% col 36 - task pace
% col 37 - force

%%
for nvr = 34:37
    for i = 3:33
        nvc = corr(S2_metrics_per_dem_NVR(:,nvr), S2_metrics_per_dem_NVR(:,i), 'Type', 'Spearman');
        if (abs(nvc) > 0.2)
            fprintf('%.2f \t corr %s - %s \n', nvc, headers_per_dem_NVR{nvr}, headers_per_dem_NVR{i});
        end
    end
    fprintf('\n');
end

%% Compute the weight corr

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
% Col 4 - Total scooped weight
% col 5 - Total demos
avg_w_per_user = S2_metrics_all(:,4)./S2_metrics_all(:,5);
sid_w = [S2_metrics_all(:,1) avg_w_per_user];

avg_weight_per_dem = zeros(size(S2_metrics_per_dem_NVR,1),1);
for i = 1:size(sid_w,1)
    idx_demos_crt_sub = find(S2_metrics_per_dem_NVR(:,1) == sid_w(i,1));
    avg_weight_per_dem(idx_demos_crt_sub) = sid_w(i,2); 
end

vr_w = corr(S2_metrics_per_dem_NVR(:,34), avg_weight_per_dem, 'Type', 'Spearman')


%% Compute the segm len

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
% Col 4 - Total scooped weight
% col 5 - Total demos
avg_t_per_user = S2_metrics_all(:,8);
sid_t = [S2_metrics_all(:,1) avg_t_per_user];

avg_time_per_dem = zeros(size(S2_metrics_per_dem_NVR,1),1);
for i = 1:size(sid_t,1)
    idx_demos_crt_sub = find(S2_metrics_per_dem_NVR(:,1) == sid_t(i,1));
    avg_time_per_dem(idx_demos_crt_sub) = sid_t(i,2); 
end

vr_w = corr(S2_metrics_per_dem_NVR(:,36), avg_time_per_dem, 'Type', 'Spearman');


%% Compute the corr with total task time

load('../S2_task_analysis/metrics_all_per_subject_Segm1_NVR.mat');
load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/metrics_all_per_subject_Segm3_NVR.mat');
% Col 4 - Total scooped weight
% col 5 - Total demos
total_t_per_user = S1_metrics_all(:,8) + S2_metrics_all(:,8) + S3_metrics_all(:,8);
sid_t = [S2_metrics_all(:,1) total_t_per_user];

total_time_per_dem = zeros(size(S2_metrics_per_dem_NVR,1),1);
for i = 1:size(sid_t,1)
    idx_demos_crt_sub = find(S2_metrics_per_dem_NVR(:,1) == sid_t(i,1));
    total_time_per_dem(idx_demos_crt_sub) = sid_t(i,2); 
end

vr_w = corr(S2_metrics_per_dem_NVR(:,36), total_time_per_dem, 'Type', 'Spearman')
