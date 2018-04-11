load('../S2_task_analysis/sensor_metrics_per_dem.mat');

dem_rating = zeros(1525,1);
dem_rating(find(metrics_per_dem(:,6) > 0.7)) = 1; % for force
%dem_rating(find(metrics_per_dem(:,9) > 0.7)) = 1; % For torque
disp(length(find(dem_rating) == 1));

headers_per_segm = {'Subject_ID', 'Skill_Hand', 'Skill_Computed', 'Sgm_ID', 'Dem', ...
    'GQ_X', 'GQ_Y', 'GQ_Z', 'GQ_RX', 'GQ_RY', 'GQ_RZ', ...
    'avg_F_X', 'avg_F_Y', 'avg_F_Z', 'avg_T_X', 'avg_T_Y', 'avg_T_Z', ...
    'max_F_X', 'max_F_Y', 'max_F_Z', 'max_T_X', 'max_T_Y', 'max_T_Z', ...
    'Pressure_Thumb', 'Pressure_Index', 'Pressure_Middle', 'Pressure_Ring', 'Pressure_Pinky', 'Pressure_Palm' ...
    'max_subsegments', 'subsegm_X', 'subsegm_Y', 'subsegm_Z' ...
    };
headers_per_segm = headers_per_segm';

sensor_metrics = [metrics_per_dem dem_rating];

% Get data for each segment
S1_reach_idx = find(metrics_per_dem(:,4) == 1);
S1_reach = sensor_metrics(S1_reach_idx, :);

S2_scoop_idx = find(metrics_per_dem(:,4) == 2);
S2_scoop = sensor_metrics(S2_scoop_idx, :);

S3_trash_idx = find(metrics_per_dem(:,4) == 3);
S3_trash = sensor_metrics(S3_trash_idx, :);

% select skilled / unskilled data = high/low dem rating
reach_sk = S1_reach(find(S1_reach(:, end) == 1), :);
reach_nsk = S1_reach(find(S1_reach(:, end) == 0), :);

scoop_sk = S2_scoop(find(S2_scoop(:, end) == 1), :);
scoop_nsk = S2_scoop(find(S2_scoop(:, end) == 0), :);

trash_sk = S3_trash(find(S3_trash(:, end) == 1), :);
trash_nsk = S3_trash(find(S3_trash(:, end) == 0), :);

gq_col = 10; % range 6 - 11
avg_for_hi_dem = [mean(reach_sk(:, gq_col)) mean(scoop_sk(:, gq_col)) mean(trash_sk(:, gq_col))];
std_for_hi_dem = [std(reach_sk(:, gq_col)) std(scoop_sk(:, gq_col)) std(trash_sk(:, gq_col))];

avg_for_lo_dem = [mean(reach_nsk(:, gq_col)) mean(scoop_nsk(:, gq_col)) mean(trash_nsk(:, gq_col))];
std_for_lo_dem = [std(reach_nsk(:, gq_col)) std(scoop_nsk(:, gq_col)) std(trash_nsk(:, gq_col))];

avg_for_dem = [avg_for_hi_dem; avg_for_lo_dem]';
std_for_dem = [std_for_hi_dem; std_for_lo_dem]';

sticklabels = {'Reach','Scoop', 'Trash'};
slegend = {'High quality demo', 'Low quality demo'};

plot_grouped_plot(avg_for_dem, std_for_dem, sticklabels, slegend);
format_grouped_plot('\vartheta_F','Segments', [0 2.5]);

%%
load('../S2_task_analysis/metrics_per_dem_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_per_dem_NVR.mat');

for i = 1:size(S2_metrics_per_dem_NVR,1)
    if S2_metrics_per_dem_NVR(i,7) > 0.7
        dem_rating(i) = 1;
    else
        dem_rating(i) = 0;
    end
end
dem_rating = dem_rating';

hi_dem = S2_metrics_per_dem_NVR(find(dem_rating(:) == 1),:); % select skilled subjects only
lo_dem = S2_metrics_per_dem_NVR(find(dem_rating(:) == 0),:); % select unskilled subjects only

avg_for_hi_dem = [mean(hi_dem(:, 24)) mean(hi_dem(:, 25)) mean(hi_dem(:, 26)) mean(hi_dem(:, 27)) mean(hi_dem(:, 28)) mean(hi_dem(:, 29))];
std_for_hi_dem = [std(hi_dem(:, 24)) std(hi_dem(:, 25)) std(hi_dem(:, 26)) std(hi_dem(:, 27)) std(hi_dem(:, 28)) std(hi_dem(:, 29))];

avg_for_lo_dem = [mean(lo_dem(:, 24)) mean(lo_dem(:, 25)) mean(lo_dem(:, 26)) mean(lo_dem(:, 27)) mean(lo_dem(:, 28)) mean(lo_dem(:, 29))];
std_for_lo_dem = [std(lo_dem(:, 24)) std(lo_dem(:, 25)) std(lo_dem(:, 26)) std(lo_dem(:, 27)) std(lo_dem(:, 28)) std(lo_dem(:, 29))];

avg_for_dem = [avg_for_hi_dem; avg_for_lo_dem]';
std_for_dem = [std_for_hi_dem; std_for_lo_dem]';

sticklabels = {'Reach','Scoop', 'Trash'};
slegend = {'High quality demo', 'Low quality demo'};

plot_grouped_plot(avg_for_dem, std_for_dem, sticklabels, slegend);
format_grouped_plot('\vartheta_F','Segments', [0 2.5]);