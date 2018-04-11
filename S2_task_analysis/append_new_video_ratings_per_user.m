urating = load('second_video_rating\users.txt');
% File structure:
% col 1 - subject no
% col 2 - rater no
% col 3 - overall performance (1 - 5)
% col 4 - improved over trials (yes/no)
% col 5 - manage setup well (yes/no)
% col 6 - pb: 1 - arm coord; 2 - tool grasp; 3 - direction of mov; 4 - none

% sort by rater id >> 2 raters x 37 total subjects
urating = sortrows(urating, 2);

% Discretize the skill column
for i = 1:size(urating, 1)
    if urating(i,3) <= 2
        urating(i,3) = 0;
    else
        urating(i,3) = 1;
    end
end

% Separate the ratings of the two raters
r1 = urating( 1:37, :);
r2 = urating(38:74, :);

%% Average ratings over raters

vr_skill = mean([r1(:,3) r2(:,3)], 2);
vr_improv = mean([r1(:,4) r2(:,4)], 2);
vr_manage_setup = mean([r1(:,5) r2(:,5)], 2);

% Look first only at grasping problems
grasp_ratings = [r1(:,6) r2(:,6)];
grasp_ratings(ismember(grasp_ratings, 4)) = 0; % mark no problem with 0
grasp_ratings(ismember(grasp_ratings, 1)) = 0; % mark arm_coord with 0
grasp_ratings(ismember(grasp_ratings, 3)) = 0; % mark direction of movememnt with zero
grasp_ratings(ismember(grasp_ratings, 2)) = 1; % mark grasping problems with 1

vr_grasp_pb = mean([grasp_ratings(:,1) grasp_ratings(:,2)],2);

% Look at arm coordination and direction of movement together
vr_mov_pb = [r1(:,6) r2(:,6)];
vr_mov_pb(ismember(vr_mov_pb, 4)) = 0; % mark no problem with 0
vr_mov_pb(ismember(vr_mov_pb, 3)) = 1; % mark direction of movememnt with 1
vr_mov_pb(ismember(vr_mov_pb, 2)) = 0; % mark grasping problems with 0

vr_mov_pb = mean([vr_mov_pb(:,1) vr_mov_pb(:,2)],2);

%%

nvr_headers = {'NVR_Skill','NVR_Improve_over_trials','NVR_Manage_Setup','NVR_Grasp_Pb','NVR_Mov_Pb'};

%% load metrics all

headers_metrics_all = {'Subject_ID','Skill_Hand','Skill_Computed','Scooped_Weight','Total_Time', ...
    'Total_demos','Sgm_id','Sgm_Duration','Subsegments','RF_Passive','RF_Active', ...
    'Var_Int_P_X','Var_Int_P_Y','Var_Int_P_Z','Var_Int_A_X','Var_Int_A_Y','Var_Int_A_Z', ...
    'Stiff_P_X','Stiff_P_Y','Stiff_P_Z','Stiff_A_X','Stiff_A_Y','Stiff_A_Z', ...
    'meanGQ_X','meanGQ_Y','meanGQ_Z','meanGQ_RX','meanGQ_RY','meanGQ_RZ', ...
    'minGQ_X','minGQ_Y','minGQ_Z','minGQ_RX','minGQ_RY','minGQ_RZ', ...
    'maxGQ_X','maxGQ_Y','maxGQ_Z','maxGQ_RX','maxGQ_RY','maxGQ_RZ', ...
    'maxF_X','maxF_Y','maxF_Z','maxT_X','maxT_Y','maxT_Z',...
    'VR_Overall_skill','VR_Improve_over_trials','VR_Manage_Setup', ...
    'Gender','Age','Easy teach','Familiar_w_tool','Self_Rating','Cooking_Frequency', ...
    'difficult_aspect','Handedness','overall_impression','use_system_frequently', ...
    'system_too_complex','system_easy_to_use','need_technical_support','system_well_integrated', ...
    'system_inconsistency','people_would_learn_to_use_this_system_quickly','system_cumbersome', ...
    'confident_w_system','neeed_prior_learning','TLX_mental_demand','TLX_physical_demand', ...
    'TLX_task_pace','TLX_success','TLX_Effort','TLX_Stress'};

load('all_metrics_per_subject_Segm1.mat'); S1_metrics_all = metrics_all;
load('all_metrics_per_subject_Segm2.mat'); S2_metrics_all = metrics_all;
load('all_metrics_per_subject_Segm3.mat'); S3_metrics_all = metrics_all;

%% Append New VR Ratings

S1_metrics_all = [S1_metrics_all vr_skill vr_improv vr_manage_setup vr_grasp_pb vr_mov_pb];
S2_metrics_all = [S2_metrics_all vr_skill vr_improv vr_manage_setup vr_grasp_pb vr_mov_pb];
S3_metrics_all = [S3_metrics_all vr_skill vr_improv vr_manage_setup vr_grasp_pb vr_mov_pb];

nh = [headers_metrics_all nvr_headers];

csvwrite_with_headers('metrics_all_per_subject_Segm1_NVR.csv', S1_metrics_all, nh);
save('metrics_all_per_subject_Segm1_NVR.mat','S1_metrics_all','-mat');

csvwrite_with_headers('metrics_all_per_subject_Segm2_NVR.csv', S2_metrics_all, nh);
save('metrics_all_per_subject_Segm2_NVR.mat','S2_metrics_all','-mat');

csvwrite_with_headers('metrics_all_per_subject_Segm3_NVR.csv', S3_metrics_all, nh);
save('metrics_all_per_subject_Segm3_NVR.mat','S3_metrics_all','-mat');

save('headers_metrics_all_per_user_NVR.mat','nh','-mat');
