
load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');

%%

for nvr = 76:80
    for i = 3:75
        nvc = corr(S2_metrics_all(:,nvr), S2_metrics_all(:,i), 'Type', 'Spearman');
        if (abs(nvc) > 0.2)
            fprintf('%.2f \t corr %s - %s \n', nvc, nh{nvr}, nh{i});
        end
    end
    fprintf('\n');
end