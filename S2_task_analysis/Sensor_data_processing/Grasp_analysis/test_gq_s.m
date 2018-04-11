
excepted_subjects = [1 2 3 4 5 6 12 14 15 16 23 26 28 42 43];

warning off

gq_all = [];

for snum = 8
    
    if ismember(snum, excepted_subjects)
        continue
    else
        
        smsg = sprintf(' >>>>>> Processing Subject %d !!! <<<<<<', snum);
        disp(smsg);
        
        sname = sprintf('../../rawdata_sensors_parsed/hand/S%.2d_rawdata_hand.mat',snum); load(sname);
        sname = sprintf('../../rawdata_sensors_parsed/traj/S%.2d_rawdata.mat',snum); load(sname);
        sname = sprintf('../../rawdata_sensors_parsed/FT/S%.2d_rawdata_FT.mat',snum); load(sname);
        
        nb_actions = 3;
        
        for jj = 1:length(rawdata_hand) % nb of demonstrations
            if (isempty(rawdata_hand{jj}))
                continue
            end
            for k = 1:nb_actions
                if (k == 1)
                    smsg = sprintf('Subject %d, Demo %d, Reaching', snum, jj); disp(smsg);
                    start_idx = 1; end_idx = 100;
                    [tactilePressure ] = putGloveDataInRavinFormat(rawdata_hand{jj}.tactile_front(start_idx:end_idx, :), rawdata_hand{jj}.tactile_side(start_idx:end_idx, :));
                    glove_JA = rawdata_hand{jj}.finger_ja(start_idx:end_idx, :);
                elseif (k == 2)
                    smsg = sprintf('Subject %d, Demo %d, Scooping', snum, jj); disp(smsg);
                    start_idx = find(abs(rawdata_FT{jj}.Tool_FT(1,:)) > 5, 1);
                    if isempty(start_idx)
                        start_idx = find(abs(rawdata_FT{jj}.Tool_FT(1,:)) > 2, 1);
                    end
                    end_idx = start_idx + 200;
                    sc = size(rawdata_hand{jj}.finger_ja, 1) / size(rawdata_FT{jj}.Tool_FT(1,:), 2); % Scaling factor
                    [tactilePressure ] = putGloveDataInRavinFormat(rawdata_hand{jj}.tactile_front(round(start_idx*sc):floor(end_idx*sc), :), rawdata_hand{jj}.tactile_side(round(start_idx*sc):floor(end_idx*sc), :));
                    glove_JA = rawdata_hand{jj}.finger_ja(round(start_idx*sc):floor(end_idx*sc), :);
                elseif (k == 3)
                    smsg = sprintf('Subject %d, Demo %d, Trashing', snum, jj); disp(smsg);
                    end_idx = size(rawdata_hand{jj}.finger_ja, 1);
                    start_idx = end_idx - 100;
                    [tactilePressure ] = putGloveDataInRavinFormat(rawdata_hand{jj}.tactile_front(start_idx:end_idx, :), rawdata_hand{jj}.tactile_side(start_idx:end_idx, :));
                    glove_JA = rawdata_hand{jj}.finger_ja(start_idx:end_idx, :);
                end
%                 disp(start_idx);
%                 disp(end_idx);
               
               
                rpos = [quat2rotm(rawdata{jj}.RF_World.RobotRot(floor((end_idx - start_idx)/2),:)) rawdata{jj}.RF_World.RobotPos(floor((end_idx - start_idx)/2),:)'; [0 0 0 1]];
%                 wpos = [quat2rotm(rawdata{jj}.RF_World.HumanWristRot(floor((end_idx - start_idx)/2),:)) rawdata{jj}.RF_World.HumanWristPos(floor((end_idx - start_idx)/2),:)'; [0 0 0 1]];

%                 wpos = [quat2rotm(rawdata{jj}.RF_Robot.HumanWristRot(floor((end_idx - start_idx)/2),:)) rawdata{jj}.RF_Robot.HumanWristPos(floor((end_idx - start_idx)/2),:)'; [0 0 0 1]];
                wpos = [quat2rotm(rawdata{jj}.RF_Bowl.HumanWristRot(floor((end_idx - start_idx)/2),:)) rawdata{jj}.RF_Bowl.HumanWristPos(floor((end_idx - start_idx)/2),:)'; [0 0 0 1]];
                bpos = [quat2rotm(rawdata{jj}.RF_World.BowlRot(floor((end_idx - start_idx)/2),:)) rawdata{jj}.RF_World.BowlPos(floor((end_idx - start_idx)/2),:)'; [0 0 0 1]];
                
                if (k == 1 || k == 2) % In reaching and scooping actions we use RF Robot
                    gquality = compute_GQ_instanteneous(glove_JA, tactilePressure, rpos, wpos);
                elseif (k == 3) % In the trashing action we use RF bowl
                    gquality = compute_GQ_instanteneous(glove_JA, tactilePressure, bpos, wpos);
                end
                
                grid on; box on; axis equal; view(3); axis auto;
                stitle = sprintf('Subject %d - Demo %d - Segment %d ', snum, jj, k); title(stitle);
%                 sfigname = sprintf('Hand_Plots/S%d_Segm%d_Dem%d.fig', snum, k, jj); savefig(sfigname);
%                 sfigpng = sprintf('Hand_Images/S%d_Segm%d_Dem%d.png', snum, k, jj); saveas(gcf,sfigpng);
                
                GQ_Metric{k}.gq(jj,:) = gquality;
                
            end
        end
        
        soutname = sprintf('S%.2d_GQ_Metric_Wrist_in_Bowl.mat', snum);
        save(soutname, 'GQ_Metric', '-mat');
        
        clear gq_out
        
        gq_out = [GQ_Metric{1}.gq GQ_Metric{2}.gq GQ_Metric{3}.gq]; % For each action
        gq_all = [gq_all; [ones(length(rawdata_hand),1)*snum [1:length(rawdata_hand)]' gq_out]]; % Subject number | demo number | GQ
        
        clear GQ_Metric glove tactile_front tactile_side
        
        close all
    end
end

disp('Done!!!');

%%
% Concatenate GQ from diff users
%
% total_subjects = 10;
%
% gq_all = [];
% for i = 1:total_subjects
%     sname = sprintf('S%d_GQ_Metric.mat', i);
%     disp(sname);
%     load(sname);
%     gq_out = [GQ_Metric{1}.gq GQ_Metric{2}.gq GQ_Metric{3}.gq];
%     num_dem = size(gq_out, 1);
%     gq_all = [gq_all; [ones(num_dem,1)*i [1:num_dem]' gq_out]];
% end

