
% Load existing sensor metrics - per demonstration 

load('sensor_metrics_per_dem.mat');

headers = {'Subject_ID', 'Skill_Hand', 'Skill_Computed', 'Sgm_ID', 'Dem', ...
    'GQ_X', 'GQ_Y', 'GQ_Z', 'GQ_RX', 'GQ_RY', 'GQ_RZ', ...
    'avg_F_X', 'avg_F_Y', 'avg_F_Z', 'avg_T_X', 'avg_T_Y', 'avg_T_Z', ...
    'max_F_X', 'max_F_Y', 'max_F_Z', 'max_T_X', 'max_T_Y', 'max_T_Z', ...
    'Pressure_Thumb', 'Pressure_Index', 'Pressure_Middle', 'Pressure_Ring', 'Pressure_Pinky', 'Pressure_Palm' ...
    'max_subsegments', 'subsegm_X', 'subsegm_Y', 'subsegm_Z' ...
    };

%% Separate the metrics on segments

col_sgm_id = 4; % index of column containing the segment ID
metrics_per_dem = sortrows(metrics_per_dem, col_sgm_id); % sort by segmnet ID

% See where a new segment start
[a, a_idx] = unique(metrics_per_dem(:,col_sgm_id));
S1_metrics_per_dem = metrics_per_dem(1:a_idx(2)-1, :);
S2_metrics_per_dem = metrics_per_dem(a_idx(2):a_idx(3)-1, :);
S3_metrics_per_dem = metrics_per_dem(a_idx(3):end, :);

%% Load video rating per trial

vr_dem = load('second_video_rating\trials.txt');

% File structure - 7 columns:
% col 1 - subject number
% col 2 - dem number
% col 3 - rater number
% col 4 - scooped amount (1 - too little; 2 - normal; 3 - too much)
% col 5 - did this person perform the task with ease? (1 - yes / 2 - no)
% col 6 - task pace (1 - too slow; 2 - normal; 3 - too fast)
% col 7 - force aplied (1 - too little; 2 - normal; 3 - too much)

% sort by rater ID
vr_dem = sortrows(vr_dem, 3);
vr_dem_R1 = vr_dem(1:size(vr_dem,1)/2, :);
vr_dem_R2 = vr_dem(size(vr_dem,1)/2+1:end, :);

% average the response of the two raters for each question

%vr_grasp_pb = mean([grasp_ratings(:,1) grasp_ratings(:,2)],2);

vr_estim_weight = mean([vr_dem_R1(:,4) vr_dem_R2(:,4)],2);
vr_estim_ease   = mean([vr_dem_R1(:,5) vr_dem_R2(:,5)],2);
vr_task_pace    = mean([vr_dem_R1(:,6) vr_dem_R2(:,6)],2);
vr_estim_force  = mean([vr_dem_R1(:,7) vr_dem_R2(:,7)],2);

vr_means = [vr_dem_R1(:,1) vr_estim_weight vr_estim_ease vr_task_pace vr_estim_force];

vr_headers_per_dem = {'VR_Estim_Weight', 'VR_Estim_Ease', 'VR_Task_Pace', 'VR_Estim_Force'};

% Append these rating to the sensor metrics per dem for Segm 2
[us2, usidx2] = unique(S2_metrics_per_dem(:,1)); % get unique users
S2_ndem_per_user = [diff(usidx2); size(S2_metrics_per_dem,1)-usidx2(end)+1]; % get nb of dem per user

S2_metrics_per_dem_NVR = [];

for i = 1:length(us2) 
    sm_tmp = S2_metrics_per_dem(find(S2_metrics_per_dem(:,1) == us2(i)), :); % get all corresponding sensor metrics for subject i
    vr_tmp = vr_means(find(vr_means(:,1) == us2(i)), :);
    vdemos = min(size(sm_tmp,1), size(vr_tmp,1)); % determine number of common demos
    S2_metrics_per_dem_NVR = [  S2_metrics_per_dem_NVR; ...
                                [sm_tmp(1:vdemos, :) vr_tmp(1:vdemos, 2:end)]];
    clear sm_tmp vr_tmp
end

headers_per_dem_NVR = [headers vr_headers_per_dem];

csvwrite_with_headers('metrics_per_dem_Segm2_NVR.csv', S2_metrics_per_dem_NVR, headers_per_dem_NVR);
save('metrics_per_dem_Segm2_NVR.mat','S2_metrics_per_dem_NVR','-mat');

save('headers_metrics_per_dem_NVR.mat','headers_per_dem_NVR','-mat');

%% See how many demonstrations for each user in each segment
% Segment 1
% [us, usidx] = unique(S1_metrics_per_dem(:,1)); % get unique users
% S1_ndem_per_user = [diff(usidx); size(S1_metrics_per_dem,1)-usidx(end)+1]; % get nb of dem per user
% 
% % Segment 2
% [us2, usidx2] = unique(S2_metrics_per_dem(:,1)); % get unique users
% S2_ndem_per_user = [diff(usidx2); size(S2_metrics_per_dem,1)-usidx2(end)+1]; % get nb of dem per user
% 
% % Segment 3
% [us3, usidx3] = unique(S3_metrics_per_dem(:,1)); % get unique users
% S3_ndem_per_user = [diff(usidx3); size(S3_metrics_per_dem,1)-usidx3(end)+1]; % get nb of dem per user
% 
% ndem_per_segm = [S1_ndem_per_user S2_ndem_per_user S3_ndem_per_user];