

% Makes a column for every rater >> to be able to concatenate with the
% existing objective metrics

load('video_rating.mat');

% Columns in this data
col_SID = 1;
col_demoID = 2;
col_raterID = 3;
col_skill = 5;

metrics_sorted = sortrows(video_metrics_per_dem, col_raterID);
idx = [1; find(diff(metrics_sorted(:,col_raterID)) == 1); size(metrics_sorted,1)];


%headers = {'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'Skill', 'Task_Pace', 'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};
for i = 1:length(idx)-1    
    rater{i} = metrics_sorted(idx(i):idx(i+1),:);
end

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];
subjects_all = 1:52;
subjects_all(excepted_subjects) = [];


for rater_num = 1:length(rater)
    for item = 1:size(rater,1)
        srated = unique(rater{rater_num}(:,1)); % The subjects that this rater has rated
        for jj = 1:length(subjects_all)-length(srated)
        if ismember()
    end
end
