% Averages per subject 

total_subjects = 52;
excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

excepted_demos{48} = [1 2 3 11];
excepted_demos{51} = [1];
excepted_demos{52} = [14 15];

metrics_all = [];
total_sgm = 3;

load('Sensor_data_processing/VBS_segmentation_and_constraints/sk_computed.mat');
load('External_metrics/scooped_weight.mat');

good_subjects = [7,8,9,10,11,13,17,18,19,20,21,22,24,25,27,29,30,31,32,33,34,35,36,37,38,39,40,41,44,45,46,47,48,49,50,51,52];

scw = scooped_weight(good_subjects);

for snum = 1:total_subjects
    if ismember(snum, excepted_subjects)
        continue
    else
        
        %         sfname = sprintf('../../rawdata_sensors_parsed/traj/S%.2d_rawdata.mat', snum); load(sfname);
        sfname = sprintf('../../ppdata_dtw/FT_good/S%.2d_ppdata_dtw_FT.mat', snum); load(sfname);
        sfname = sprintf('Sensor_data_processing/Grasp_analysis/S%.2d_GQ_Metric.mat', snum); load(sfname);
        sfname = sprintf('Sensor_data_processing/VBS_segmentation_and_constraints/Stiffness/S%.2d_Stiffness_Modulation.mat', snum); load(sfname);
        load('Sensor_data_processing/VBS_segmentation_and_constraints/all_S_HD_constraints.mat');
        
        time_total = size(ppdata_dtw_FT.RF_Tool.ToolFT.X,2)/100;
        dem_total = size(ppdata_dtw_FT.RF_Tool.ToolFT.X, 1);
        
        for sgm_id = 2
            
            % Constraints related metrics
            sgm_len = constraints{snum}.sgm{sgm_id}.segm_idx(2) - constraints{snum}.sgm{sgm_id}.segm_idx(1);
            sgm_sub = constraints{snum}.sgm{sgm_id}.subsegments;
            RF_P = constraints{snum}.sgm{sgm_id}.RF.Passive;
            RF_A = constraints{snum}.sgm{sgm_id}.RF.Active;
            var_int = constraints{snum}.sgm{sgm_id}.var_int;
            Stiff_P = [mean(Stiff{sgm_id}.Passive.X) mean(Stiff{sgm_id}.Passive.Y) mean(Stiff{sgm_id}.Passive.Z)];
            Stiff_A = [mean(Stiff{sgm_id}.Active.X) mean(Stiff{sgm_id}.Active.Y) mean(Stiff{sgm_id}.Active.Z)];
            
            % GQ Metrics
            GQ_Metric{sgm_id}.gq(all(~GQ_Metric{sgm_id}.gq, 2), :) = [];  % Remove zero rows
            % >> TODO: normalize GQ
            % >> Check RF for computing GQ
            meanGQ  = mean(GQ_Metric{sgm_id}.gq);
            minGQ   = min(GQ_Metric{sgm_id}.gq);
            maxGQ   = max(GQ_Metric{sgm_id}.gq);
            
            % FT metrics
            meanFT = [mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.X')) mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.Y')) mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.Z')) ...
                mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.TX')) mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.TY')) mean(max(ppdata_dtw_FT.RF_Tool.ToolFT.TZ'))];
            
            metrics_all = [metrics_all; ....
                snum constraints{snum}.skill time_total dem_total sgm_id sgm_len sgm_sub ...
                RF_P RF_A var_int Stiff_P Stiff_A  meanGQ minGQ maxGQ meanFT;
                ];
            
        end
        
    end
end

metrics_all = [metrics_all(:, 1:2) sk(:,2) scw metrics_all(:,3:end)];

s_headers = {'Subject_ID', 'Skill_Hand', 'Skill_Computed','Scooped_Weight','Total_Time', 'Total_demos', 'Sgm_id', 'Sgm_Duration', 'Subsegments', ...
    'RF_Passive','RF_Active','Var_Int_P_X','Var_Int_P_Y','Var_Int_P_Z','Var_Int_A_X','Var_Int_A_Y','Var_Int_A_Z', ...
    'Stiff_P_X','Stiff_P_Y','Stiff_P_Z', 'Stiff_A_X', 'Stiff_A_Y', 'Stiff_A_Z', ...
    'meanGQ_X','meanGQ_Y','meanGQ_Z','meanGQ_RX','meanGQ_RY','meanGQ_RZ',...
    'minGQ_X','minGQ_Y','minGQ_Z','minGQ_RX','minGQ_RY','minGQ_RZ', ...
    'maxGQ_X','maxGQ_Y','maxGQ_Z','maxGQ_RX','maxGQ_RY','maxGQ_RZ', ...
    'maxF_X', 'maxF_Y', 'maxF_Z', 'maxT_X', 'maxT_Y', 'maxT_Z', ...
    };

%% Append Video data

load('../../video_data/users.txt');

r1 = users(1:3:end,:);
r2 = users(2:3:end,:);
r3 = users(3:3:end,:);

vr_overall_skill = round(mean([r1(:,3) r2(:,3) r3(:,3)], 2));
vr_improve = round(mean([r1(:,4) r2(:,4) r3(:,4)], 2));
vr_setup = round(mean([r1(:,5) r2(:,5) r3(:,5)], 2));

vr_metrics = [vr_overall_skill vr_improve vr_setup];
vr_headers = {'VR_Overall_skill','VR_Improve_over_trials','VR_Manage_Setup'};

%% Append questionnaire data

load('../Questionnaire/qdata_w_OverallImpression.mat');
q_metrics = qdata(:, 2:26);

q_headers = {'Subject_ID', 'Gender', 'Age', 'Easy teach', 'Familiar_w_tool', 'Self_Rating', ...
    'Cooking_Frequency', 'difficult_aspect', 'Handedness', 'overall_impression',...
    'use_system_frequently', 'system_too_complex', 'system_easy_to_use', 'need_technical_support', ...
    'system_well_integrated', 'system_inconsistency', 'people_would_learn_to_use_this_system_quickly', ...
    'system_cumbersome', 'confident_w_system', 'neeed_prior_learning', ...
    'TLX_mental_demand', 'TLX_physical_demand', 'TLX_task_pace', 'TLX_success', ... 
    'TLX_Effort', 'TLX_Stress' ...
};

metrics_all = [metrics_all vr_metrics q_metrics];
hs = [s_headers vr_headers q_headers{2:26}];

csvwrite_with_headers('all_metrics_per_subject_Segm2.csv', metrics_all, hs);
save('all_metrics_per_subject_Segm2.mat','metrics_all','-mat');

%% Compute correlations - all vs all


for i = 1:size(metrics_all, 2)
    for j = i:size(metrics_all, 2)
        corr_per_subjects(i,j) = corr(metrics_all(:,i), metrics_all(:,j));
        if (corr_per_subjects(i,j) < 0.4 && corr_per_subjects(i,j) > 0.2 && i~=j)
            fprintf('%.2f, %s - %s \n', corr_per_subjects(i,j), hs{i}, hs{j} );
        end
    end
end


%% Per subject - per demonstration - per segment

%  1 - subject ID            2 - Demo ID                 3 - Demo Length
%  4 - Demo Quality          5 - Total no of segments    6 - Segm ID
%  7 - Segm Length
%  8 -  9 - 10 - Var Interest   Passive arm X Y Z
% 11 - 12 - 13 - Var Interest   Active arm  X Y Z
% 14 - 15 - 16 - Avg Stiffness  Passive arm X Y Z
% 17 - 18 - 19 - Avg Stiffness  Active arm  X Y Z
% 20 - 21 - 22 - Avg Shakiness  Passive arm X Y Z
% 23 - 24 - 25 - Avg Shakiness  Active arm  X Y Z
% Segment 1 - Reaching
% 26 - 27 - 28 - Avg GQ  X  Y  Z
% 29 - 30 - 31 - Avg GQ RX RY RZ
% Segment 2 - Scooping
% 26 - 27 - 28 - Avg GQ  X  Y  Z
% 29 - 30 - 31 - Avg GQ RX RY RZ
% Segment 3 - Trashing
% 26 - 27 - 28 - Avg GQ  X  Y  Z
% 29 - 30 - 31 - Avg GQ RX RY RZ
% 32 - 33 - 34 - Max Fx Fy Fz
% 35 - 36 - 37 - Max Tz Ty Tz
% 38 - 39 - 40 - 41 - 42 - 43 - Max Pressure Thumb Index Middle Ring Pinky

% metrics_pd = []; % Metrics per demonstration
%
% total_subjects = 52;
% excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];
%
% excepted_demos{48} = [1 2 3 11];
% excepted_demos{51} = [1];
% excepted_demos{52} = [14 15];
%
% sidx = 0; % subject real index, since snum are not consecutive values
%
% metrics_all = [];
% for snum = 1:total_subjects
%     if ismember(snum, excepted_subjects)
%         continue
%     else
%         sfname = sprintf('../../rawdata_sensors_parsed/traj/S%.2d_rawdata.mat', snum); load(sfname);
%         sfname = sprintf('../Hand_GQ/S%.2d_GQ_Metric.mat', snum); load(sfname);
%
%         sidx = sidx + 1;
%         dem_idx = 0;
%         for dem = 1:length(rawdata)-length(excepted_demos{snum})
%             if ismember(dem, excepted_demos{snum})
%                 continue
%             else
%                 dem_idx = dem_idx + 1;
%                 metrics_time(dem_idx) = rawdata{dem}.tak_duration;
%
%                 metrics_gq = [ones(size(GQ_Metric{1}.gq, 1),1) ...  % Segment ID = 1 - Reaching
%                     GQ_Metric{1}.gq; ...                            % GQ metrics for segment 1
%                     ones(size(GQ_Metric{1}.gq, 1),1)*2 ...          % Segment ID = 2 - Scooping
%                     GQ_Metric{2}.gq; ...                            % GQ metrics for segment 2
%                     ones(size(GQ_Metric{1}.gq, 1),1)*3 ...          % Segment ID = 3 - Trashing
%                     GQ_Metric{3}.gq ...                             % GQ metrics for segment 3
%                     ];
%             end
%         end
%     end
%     metrics_subj_dem_segm = [metrics_all; metrics_gq];
%
%     avg_time{snum} = mean(metrics_time);
%     clear rawdata metrics_time metrics_gq
%
%     %     metrics_subj
% end
%
