%%

video_metrics_per_dem(55:90,:) = [];
video_metrics_per_dem(289:294,:) = [];
video_metrics_per_dem(493:498,:) = [];
video_metrics_per_dem(745:750,:) = [];
video_metrics_per_dem(829:840,:) = [];
video_metrics_per_dem(901:906,:) = [];
video_metrics_per_dem(1159:1164,:) = [];
video_metrics_per_dem(1231:1242,:) = [];
video_metrics_per_dem(1843:1854,:) = [];
video_metrics_per_dem(2161:2172,:) = [];
video_metrics_per_dem(2365:2370,:) = [];
video_metrics_per_dem(2545:2562,:) = [];
video_metrics_per_dem(2731:2760,:) = [];
video_metrics_per_dem(2851:2874,:) = [];
video_metrics_per_dem(2923:2946,:) = [];
video_metrics_per_dem(2971:3006,:) = [];
%video_metrics_per_dem(1303:1392,:) = []; % Removing subject 28 completely
video_metrics_periate = video_metrics_per_dem;
%%
load('sensor_metrics_per_dem.mat');

sdata = metrics_per_dem;

idx_S1 = find(sdata(:,4) == 1); % Remove Segment 1 - Reaching
sdata(idx_S1,:) = [];

idx_S3 = find(sdata(:,4) == 3); % Remove S3 - Trashing
sdata(idx_S3,:) = [];

sdata(218:231, :) = [];
sdata(238:240, :) = [];
sdata(322, :) = [];
sdata(398:399, :) = [];
sdata(432, :) = [];
sensor_metrics_periate = sdata;

good_subjects = [7,8,9,10,11,13,17,18,19,20,21,22,24,25,27,29,30,31,32,33,34,35,36,37,38,39,40,41,44,45,46,47,48,49,50,51,52];


for i = 1:length(good_subjects)
    cs = good_subjects(i);
    dem(i,1) = good_subjects(i);
    dem(i,2) = length(find(sdata(:,1)==cs)); %sensor metrics per dem
    dem(i,3) = length(find(video_metrics_periate(:,1)==cs))/6;
    
    if (dem(i,2) ~= round(dem(i,2)))
        fprintf('Check Subject %d on dem no \n', good_subjects(i));
    elseif  (dem(i,2) ~= dem(i,3))
        fprintf('Check Subject %d on video ratings \n', good_subjects(i));
    end        
end

%% sort by raters
nb_raters = 6;

for i = 1:length(good_subjects)
    
    % Get indexes for subject
    clear temp_idx
    temp_idx = find(video_metrics_periate(:,1)== i);
    
    % Get data
    clear temp_data
    temp_data = video_metrics_periate(temp_idx,:);
    
    % Case A - more video ratings than demos
    %First order by raters
    for jj = 1:nb_raters
        r_stats.subject{i}.rater{jj} = temp_data(jj:5:end,:);
    end
end

%% Concatenate by subject and keep raters distinct
rating_all_sub = [];

for rater_num = 1:nb_raters
    rating = [];
    for i = 1:length(good_subjects)
        rating = [rating; r_stats.subject{i}.rater{rater_num}(:,:)];
    end
    rating_all_sub.rater{rater_num} = rating;
end


%% Sensor metrics

headers = {'Subject_ID', 'Skill_Hand', 'Skill_Computed', 'Sgm_ID', 'Dem', ...
    'GQ_X', 'GQ_Y', 'GQ_Z', 'GQ_RX', 'GQ_RY', 'GQ_RZ', ...
    'avg_F_X', 'avg_F_Y', 'avg_F_Z', 'avg_T_X', 'avg_T_Y', 'avg_T_Z', ...
    'max_F_X', 'max_F_Y', 'max_F_Z', 'max_T_X', 'max_T_Y', 'max_T_Z', ...
    'Pressure_Thumb', 'Pressure_Index', 'Pressure_Middle', 'Pressure_Ring', 'Pressure_Pinky', 'Pressure_Palm' ...
    'max_subsegments', 'subsegm_X', 'subsegm_Y', 'subsegm_Z' ...
    };

%% Video ratings
headers = {'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'Skill', 'Task_Pace', ...
    'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};

%% Averge metrics across raters

r1 = video_metrics_periate(1:5:end, :);
r1 = video_metrics_periate(1:6:end, :);
r2 = video_metrics_periate(2:6:end, :);
r3 = video_metrics_periate(3:6:end, :);
r4 = video_metrics_periate(4:6:end, :);
r5 = video_metrics_periate(5:6:end, :);
r6 = video_metrics_periate(6:6:end, :);


vr_skill = [r1(:,5) r2(:,5) r3(:,5) r4(:,5) r5(:,5) r6(:,5)];
vr_task_pace = [r1(:,6) r2(:,6) r3(:,6) r4(:,6) r5(:,6) r6(:,6)];
vr_pb_coord = [r1(:,7) r2(:,7) r3(:,7) r4(:,7) r5(:,7) r6(:,7)];
vr_pb_grasp = [r1(:,8) r2(:,8) r3(:,8) r4(:,8) r5(:,8) r6(:,8)];
vr_pb_move = [r1(:,9) r2(:,9) r3(:,9) r4(:,9) r5(:,9) r6(:,9)];
vr_ft = [r1(:,10) r2(:,10) r3(:,10) r4(:,10) r5(:,10) r6(:,10)];
%%
vr_skill_mean = round(mean(vr_skill, 2));
vr_task_pace_mean = round(mean(vr_task_pace, 2));
vr_pb_coord_mean = round(mean(vr_pb_coord, 2));
vr_pb_grasp_mean = round(mean(vr_pb_grasp, 2));
vr_pb_move_mean = round(mean(vr_pb_move, 2));
vr_ft = round(mean(vr_ft, 2));

vr_avgs = [vr_skill_mean vr_task_pace_mean vr_pb_coord_mean vr_pb_grasp_mean vr_pb_move_mean vr_ft];
%%
sdata_w_vr = [sensor_metrics_periate vr_avgs];

save('sensor_metrics_with_video_metrics', 'sdata_w_vr', '-mat');

headers = {'Subject_ID', 'Skill_Hand', 'Skill_Computed', 'Sgm_ID', 'Dem', ...
    'GQ_X', 'GQ_Y', 'GQ_Z', 'GQ_RX', 'GQ_RY', 'GQ_RZ', ...
    'avg_F_X', 'avg_F_Y', 'avg_F_Z', 'avg_T_X', 'avg_T_Y', 'avg_T_Z', ...
    'max_F_X', 'max_F_Y', 'max_F_Z', 'max_T_X', 'max_T_Y', 'max_T_Z', ...
    'Pressure_Thumb', 'Pressure_Index', 'Pressure_Middle', 'Pressure_Ring', 'Pressure_Pinky', 'Pressure_Palm' ...
    'max_subsegments', 'subsegm_X', 'subsegm_Y', 'subsegm_Z', ...
    'avg_VR_Skill', 'avg_VR_TaskPace', 'avg_VR_pbCoord', 'avg_VR_pbGrasp', 'avg_VR_pbMove', 'avg_VR_EstimatedFT' ...
    };

csvwrite_with_headers('sensor_metrics_with_video_metrics.csv', sdata_w_vr, headers);

%%

% Compute correlations

for i = 1:size(sdata_w_vr,2)
    for j = 1:size(sdata_w_vr,2)
        corr_sd(i,j) = corr(sdata_w_vr(:,i), sdata_w_vr(:,j));
        if (corr_sd(i,j) > 0.4 && i ~=j)
            fprintf('%.2f %s - %s \n', corr_sd(i,j), headers{i}, headers{j});
        end
    end
end


%% Compute anovas

for i = 4:39 
    [anova_p(i) tmp] = anova1(sdata_w_vr(:,i), sdata_w_vr(:,3)); 
    anova_F(i) = tmp{2,5};
    if (anova_p(i) < 0.05)
        fprintf('%.2f %.2f %s \n', anova_F(i), anova_p(i), headers{i});
    end
end

%% Rating for dem

dem_rating = zeros(494,1);
dem_rating(find(sdata_w_vr(:,6)>1.2)) = 1;
length(find(dem_rating) == 1)

for i = 4:39 
    [dem_anova_p(i) tmp] = anova1(sdata_w_vr(:,i), dem_rating); 
    dem_anova_F(i) = tmp{2,5};
    if (dem_anova_p(i) < 0.05)
        fprintf('%.2f %.2f %s \n', dem_anova_F(i), dem_anova_p(i), headers{i});
    end
end
