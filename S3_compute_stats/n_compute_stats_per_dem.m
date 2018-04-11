
%% Load data per dem

load('../S2_task_analysis/metrics_per_dem_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_per_dem_NVR.mat');

%% Compute anova for the forces

col_Max_Fx = 18;
col_Max_Fy = 19;
col_Max_Fz = 20;

% For factor subject ID

subject_id = S2_metrics_per_dem_NVR(:,1);

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fx), subject_id, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: subject_id; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fx, headers_per_dem_NVR{col_Max_Fx});

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fy), subject_id, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: subject_id; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fy, headers_per_dem_NVR{col_Max_Fy});

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fz), subject_id, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: subject_id; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fz, headers_per_dem_NVR{col_Max_Fz});


%% For factor computed skill
auto_skill = S2_metrics_per_dem_NVR(:,3);

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fx), auto_skill, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: auto_skill; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fx, headers_per_dem_NVR{col_Max_Fx});

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fy), auto_skill, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: auto_skill; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fy, headers_per_dem_NVR{col_Max_Fy});

[a,b] = anova1(S2_metrics_per_dem_NVR(:,col_Max_Fz), auto_skill, 'off');
fprintf('F = %.2f, p-value = %.3f, Factor: auto_skill; Metric: column %d - %s \n', b{2,5}, a, col_Max_Fz, headers_per_dem_NVR{col_Max_Fz});

%% Check corr for forces with other things:

for i = 12:15 % 18:20
    for j = 31:37
        vtmp = corr(S2_metrics_per_dem_NVR(:,i), S2_metrics_per_dem_NVR(:,j), 'Type', 'Spearman');
        fprintf('%.2f \t Spearman corr \t %s - %s \n', vtmp, headers_per_dem_NVR{i}, headers_per_dem_NVR{j});
    end
end

%% ANOVAs for the GQ and FT

% For factor auto-skill
auto_skill = S2_metrics_per_dem_NVR(:,3);

for i = 6:29
    [a,b] = anova1(S2_metrics_per_dem_NVR(:,i), auto_skill, 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: auto_skill; Metric: column %d - %s \n', b{2,5}, a, i, headers_per_dem_NVR{i});
end
    

% For factor dem_rating

for i = 1:size(S2_metrics_per_dem_NVR,1)
    if S2_metrics_per_dem_NVR(i,7) > 0.7
        dem_rating(i) = 1;
    else
        dem_rating(i) = 0;
    end
end
dem_rating = dem_rating';

for i = 6:29
    [a,b] = anova1(S2_metrics_per_dem_NVR(:,i), dem_rating, 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: dem_rating; Metric: column %d - %s \n', b{2,5}, a, i, headers_per_dem_NVR{i});
end
    