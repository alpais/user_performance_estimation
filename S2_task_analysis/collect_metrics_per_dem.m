%% Metrics per demonstration

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

metrics_per_dem = [];
num_patches = 18;

for snum = 1:52
    if ismember(snum, excepted_subjects)
        continue
    else
        fprintf('Processing subject %d \n', snum);
        sfname = sprintf('../../ppdata_dtw/FT_good/S%.2d_ppdata_dtw_FT.mat', snum); load(sfname);
        sfname = sprintf('Sensor_data_processing/Grasp_analysis/S%.2d_GQ_Metric.mat', snum); load(sfname);
        sfname = sprintf('../../rawdata_sensors_parsed/hand/S%.2d_rawdata_hand.mat', snum); load(sfname);
        sfname = sprintf('Sensor_data_processing/VBS_segmentation_and_constraints/all_S_HD_constraints.mat'); load(sfname);
        sfname = sprintf('Sensor_data_processing/VBS_segmentation_and_constraints/sk_computed.mat'); load(sfname);
        sfname = sprintf('Sensor_data_processing/VBS_segmentation_and_constraints/sk_per_subject.mat'); load(sfname);
        
        
        if snum == 7
            GQ_Metric{1}.gq(1,:) = 0; GQ_Metric{2}.gq(1,:) = 0; GQ_Metric{3}.gq(1,:) = 0;
        end
        if snum == 9
            GQ_Metric{1}.gq(15,:) = 0; GQ_Metric{2}.gq(15,:) = 0; GQ_Metric{3}.gq(15,:) = 0;
        end
        if snum == 24
            GQ_Metric{1}.gq(2,:) = 0; GQ_Metric{2}.gq(2,:) = 0; GQ_Metric{3}.gq(2,:) = 0;
        end
        if snum == 29
            GQ_Metric{1}.gq(1,:) = 0; GQ_Metric{2}.gq(1,:) = 0; GQ_Metric{3}.gq(1,:) = 0;
        end
        if snum == 38
            GQ_Metric{1}.gq(2,:) = 0; GQ_Metric{2}.gq(2,:) = 0; GQ_Metric{3}.gq(2,:) = 0;
        end
        if snum == 39
            GQ_Metric{1}.gq(1,:) = 0; GQ_Metric{2}.gq(1,:) = 0; GQ_Metric{3}.gq(1,:) = 0;
        end
        
        for sgm_idx = 1:3
            
            % Determine non-valid demos - i.e. zero rows
            nv_demos = all(GQ_Metric{sgm_idx}.gq, 2);
            % Remove non-valid demos from the GQ Metric
            %            GQ_Metric{sgm_idx}.gq(all(~GQ_Metric{sgm_idx}.gq, 2), :) = [];
            good_demos_idx = find(nv_demos>0);
            GQ_Metric{sgm_idx}.gq = GQ_Metric{sgm_idx}.gq(good_demos_idx, :);
            % Remove them from the FT data
            % Look again at bad demos
            %             bd = find(nv_demos==0);
            %             for k = 1:length(bd)
            %                 if(sum(GQ_Metric{1}.gq(bd(k),:))>0)
            %                     good_demos_idx = [good_demos_idx; bd(k)]; % read the row if some elements are not zero
            %                 end
            %             end
            good_FT.X  = ppdata_dtw_FT.RF_Tool.ToolFT.X(good_demos_idx,:);
            good_FT.Y  = ppdata_dtw_FT.RF_Tool.ToolFT.Y(good_demos_idx,:);
            good_FT.Z  = ppdata_dtw_FT.RF_Tool.ToolFT.Z(good_demos_idx,:);
            good_FT.TX = ppdata_dtw_FT.RF_Tool.ToolFT.TX(good_demos_idx,:);
            good_FT.TY = ppdata_dtw_FT.RF_Tool.ToolFT.TY(good_demos_idx,:);
            good_FT.TZ = ppdata_dtw_FT.RF_Tool.ToolFT.TZ(good_demos_idx,:);
            
            mean_FT = [mean(good_FT.X,2) mean(good_FT.Y,2) mean(good_FT.Z,2) mean(good_FT.TX,2) mean(good_FT.TY,2) mean(good_FT.TZ,2)];
            max_FT = [max(good_FT.X')' max(good_FT.Y')' max(good_FT.Z')' max(good_FT.TX')' max(good_FT.TY')' max(good_FT.TZ')'];
            
            for jj = 1:length(good_demos_idx) % Nb of demos
                if (sgm_idx == 1)
                    start_idx = 1; end_idx = 100;
                elseif (sgm_idx == 2)
                    start_idx = find(abs(good_FT.X(jj,:)) > 5, 1);
                    if isempty(start_idx)
                        start_idx = find(abs(good_FT.X(jj,:)) > 1.5, 1);
                    end
                    end_idx = start_idx + 200;
                    sc = size(rawdata_hand{good_demos_idx(jj)}.finger_ja, 1) / size(good_FT.X(jj,:), 2); % Scaling factor
                    start_idx = floor(start_idx*sc);
                    end_idx = floor(end_idx*sc);
                elseif (sgm_idx == 3)
                    end_idx = size(rawdata_hand{good_demos_idx(jj)}.finger_ja, 1);
                    start_idx = end_idx - 100;
                end
                max_tactile(jj,:) = max(rawdata_hand{good_demos_idx(jj)}.tactile_front(start_idx:end_idx, :)); % nb demos x nb pacthes
                max_pressure_thumb  = max(max_tactile(:, 1: 2)')';
                max_pressure_index  = max(max_tactile(:, 3: 5)')';
                max_pressure_middle = max(max_tactile(:, 6: 8)')';
                max_pressure_ring   = max(max_tactile(:, 9:11)')';
                max_pressure_pinky  = max(max_tactile(:,12:14)')';
                max_pressure_palm   = max(max_tactile(:,15:17)')';
                
                pressure_stats{sgm_idx}.max_pressures = [max_pressure_thumb max_pressure_index max_pressure_middle max_pressure_ring ...
                    max_pressure_pinky max_pressure_palm];
            end
            
            metrics_per_dem = [metrics_per_dem; ...
                snum*ones(length(good_demos_idx),1) constraints{snum}.skill*ones(length(good_demos_idx),1) sk_sub{snum}.sk(1)*ones(length(good_demos_idx),1) sgm_idx*ones(length(good_demos_idx),1) [1:length(good_demos_idx)]' GQ_Metric{sgm_idx}.gq ...
                mean_FT max_FT pressure_stats{sgm_idx}.max_pressures ...
                repmat(sk_sub{snum}.sk(2:5), length(good_demos_idx), 1)...
                ];
            
            clear max_tactile
            clear max_pressure_index max_pressure_middle max_pressure_palm max_pressure_pinky
            clear max_pressure_ring max_pressure_thumb nv_demos
            
        end
        clear mean_FT max_FT Pressure_stats
    end
end

headers = {'Subject_ID', 'Skill_Hand', 'Skill_Computed', 'Sgm_ID', 'Dem', ...
    'GQ_X', 'GQ_Y', 'GQ_Z', 'GQ_RX', 'GQ_RY', 'GQ_RZ', ...
    'avg_F_X', 'avg_F_Y', 'avg_F_Z', 'avg_T_X', 'avg_T_Y', 'avg_T_Z', ...
    'max_F_X', 'max_F_Y', 'max_F_Z', 'max_T_X', 'max_T_Y', 'max_T_Z', ...
    'Pressure_Thumb', 'Pressure_Index', 'Pressure_Middle', 'Pressure_Ring', 'Pressure_Pinky', 'Pressure_Palm' ...
    'max_subsegments', 'subsegm_X', 'subsegm_Y', 'subsegm_Z' ...
    };

csvwrite_with_headers('metrics_all_per_dem.csv', metrics_per_dem, headers);
save('sensor_metrics_per_dem.mat', 'metrics_per_dem', '-mat');


