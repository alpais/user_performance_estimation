function vr_ref_metrics_per_dem()

%% Video ratings
headers = {'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'VR_Skill', 'Task_Pace', ...
    'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};

load('../video_metrics_periate.mat');

%% Video rating per demonstration

% ---------  Current format

% Subject_ID, Demo_Nb, Rater_ID
% Performance               : 1 to 5
% Task Pace                 : 1 - too slow; 2 - normal; 3 - too fast
% Arm coordination          : 0 - OK; 1 - NOK (1 means it was checked as problem)
% Tool Grasp                : 0 - OK; 1 - NOK
% Direction of movement     : 0 - OK; 1 - NOK
% Force                     : 1 - too little; 2 - too much
% ------------------------------------------------------------------------

% Raters
% -------- Random subject, random demo ordering --------
% Alexandra 	- all subjects      - random order
% Cristina      - all subjects      - random order
% Nadia         - batch 1           - random order
% Mina          - batch 2           - random order
% Kevin         - batch 3           - random order
% -------- Per subject, Per demo ordering -------------
% Dinesh		- all subjects      - user ordering
% Samuel		- all subjects      - user ordering
% Jose          - batch 1           - user ordering
% Ilaria		- batch 2           - user ordering
% Brice         - batch 3           - user ordering

% -----------------------------------------------------
% Rater IDs - from the python script
%   raters = {'test'    : 0,
%             'test2'   : 0,
%             'lucia'   : 0,
%             'nadia'   : 1,
%             'mina'    : 2,
%             'kevin'   : 3,
%             'alex'    : 4,
%             'cristina': 5,
%             'dinesh'  : 6,
%             'samuel'  : 7,
%             'jose'    : 8,
%             'ilaria'  : 9,
%             'brice'   : 10}
% -----------------------------------------------------


%% Averge metrics across raters

% r1 = video_metrics_periate(1:5:end, :);
% r1 = video_metrics_periate(1:6:end, :);
% r2 = video_metrics_periate(2:6:end, :);
% r3 = video_metrics_periate(3:6:end, :);
% r4 = video_metrics_periate(4:6:end, :);
% r5 = video_metrics_periate(5:6:end, :);
% r6 = video_metrics_periate(6:6:end, :);
%
%
% vr_skill = [r1(:,5) r2(:,5) r3(:,5) r4(:,5) r5(:,5) r6(:,5)];
% vr_task_pace = [r1(:,6) r2(:,6) r3(:,6) r4(:,6) r5(:,6) r6(:,6)];
% vr_pb_coord = [r1(:,7) r2(:,7) r3(:,7) r4(:,7) r5(:,7) r6(:,7)];
% vr_pb_grasp = [r1(:,8) r2(:,8) r3(:,8) r4(:,8) r5(:,8) r6(:,8)];
% vr_pb_move = [r1(:,9) r2(:,9) r3(:,9) r4(:,9) r5(:,9) r6(:,9)];
% vr_ft = [r1(:,10) r2(:,10) r3(:,10) r4(:,10) r5(:,10) r6(:,10)];
%
%
%%
% idx = find(tmp_raters(:,3) == 6);
% r6 = tmp_raters(idx, :);
% r7 = tmp_raters((tmp_raters(:,3) == 7), :);
% corr(r6(:,5), r7(:,5));
%
% r6 = sortrows(r6, 1);
% r7 = sortrows(r7, 1);

%%

vr_ratings_dem = video_metrics_periate;

% Sort by subject number
vr_ratings_dem = sortrows(vr_ratings_dem,1);
% get subject ids
sid = unique(vr_ratings_dem(:,1));

for i = 1:length(sid)
    disp(i);
    sdata = vr_ratings_dem(find(vr_ratings_dem(:,1) == sid(i)), :); % Get all data for crt subject
    sdata = sortrows(sdata, 3); % Sort by the raters
    % every demo was rated by 6 raters so get rater ids and get data for
    % each rater separately
    
    rater_ids = unique(sdata(:,3));
    for r = 1:6
        rsdata{r} = sdata(find(sdata(:,3) == rater_ids(r)), :);
    end
    
    % Compute kappa for the skill rating
    kappa_sub_sk.sid{sid(i)} = zeros(10,10); %preallocate, for a total of 10 raters
    
    vr_sk_col = 5;       kappa_sub.sk.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_sk_col);
    vr_pace_col = 6;     kappa_sub.pace.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_pace_col);
    vr_pb_coord_col = 7; kappa_sub.pb_coord.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_pb_coord_col);
    vr_pb_grasp_col = 8; kappa_sub.pb_grasp.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_pb_grasp_col);
    vr_pb_move_col = 9;  kappa_sub.pb_move.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_pb_move_col);
    vr_ft_col = 10;      kappa_sub.vr_ft.sid{sid(i)} = compute_kappa_for_col(rater_ids, rsdata, vr_ft_col);
    
    
    
    %     for r1 = 1:6
    %         for r2 = (r1+1):6
    %             ch = crosstab(rsdata{r1}(:,vr_sk_col), rsdata{r2}(:,vr_sk_col));
    %             [nb_rows, nb_cols] = size(ch);
    %             if (nb_rows == 1) || (nb_cols == 1)
    %                 continue;
    %             else
    %                 kappa_sub_sk.sid{sid(i)}(rater_ids(r1), rater_ids(r2)) = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
    %                 clear ch;
    %             end
    %         end
    %     end
    
    clear sdata rsdata
end

save('kappa_sub.mat','kappa_sub','-mat');

end

function out_kappa = compute_kappa_for_col(rater_ids, rsdata, col)

out_kappa = zeros(10,10);
for r1 = 1:6
    for r2 = (r1+1):6
        ch = crosstab(rsdata{r1}(:,col), rsdata{r2}(:,col));
        [nb_rows, nb_cols] = size(ch);
        if (nb_rows == 1) || (nb_cols == 1)
            continue;
        else
            out_kappa(rater_ids(r1), rater_ids(r2)) = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
            clear ch;
        end
    end
end

end
