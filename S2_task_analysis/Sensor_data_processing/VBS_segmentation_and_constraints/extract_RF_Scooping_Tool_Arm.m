
initial_subject = 1;
final_subject = 52;

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];


%% Holding arm - Passive arm

figure('Name', 'RF Change for Holding Arm', 'NumberTitle', 'off'); hold on;


actual_idx = 0;
for snum = initial_subject:final_subject
    
    if ismember(snum, excepted_subjects)
        continue
    else
        
        actual_idx = actual_idx + 1;
        
        active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\';
        
        sname = sprintf('%sS%.2d_ppdata_dtw.mat', active_dir, snum);
        load(sname);
        
        
        for i = 1:size(ppdata_dtw.RF_Robot.ToolPos.X, 1)
            
            % make a copy of the data for current demo
            Robot_Pos_RF_Bowl = [ppdata_dtw.RF_Bowl.RobotPos.X(i,:); ppdata_dtw.RF_Bowl.RobotPos.Y(i,:); ppdata_dtw.RF_Bowl.RobotPos.Z(i,:)];
            Robot_Pos_RF_Tool = [ppdata_dtw.RF_Tool.RobotPos.X(i,:); ppdata_dtw.RF_Tool.RobotPos.Y(i,:); ppdata_dtw.RF_Tool.RobotPos.Z(i,:)];
%             Robot_Pos_RF_Wrist = [ppdata_dtw.RF_HumanWrist.RobotPos.X(i,:); ppdata_dtw.RF_HumanWrist.RobotPos.Y(i,:); ppdata_dtw.RF_HumanWrist.RobotPos.Z(i,:)];
            
            for jj = 1:size(Robot_Pos_RF_Bowl,2)
                Robot_Pos_RF_Bowl_norm(i,jj) = norm(Robot_Pos_RF_Bowl(:,jj));
                Robot_Pos_RF_Tool_norm(i,jj) = norm(Robot_Pos_RF_Tool(:,jj));
%                 Robot_Pos_RF_Wrist_norm(i,jj) = norm(Robot_Pos_RF_Wrist(:,jj));
            end
        end
        
        Crit_ROBOT_POS_Norm_RF_Bowl      = CompCrit(Robot_Pos_RF_Bowl_norm);
        Crit_ROBOT_POS_Norm_RF_Tool      = CompCrit(Robot_Pos_RF_Tool_norm);
%         Crit_ROBOT_POS_Norm_RF_Wrist      = CompCrit(Robot_Pos_RF_Wrist_norm);
        
        ns = 15;
%         Crit_Robot_POS_Norm = [smooth(Crit_ROBOT_POS_Norm_RF_Bowl', ns) smooth(Crit_ROBOT_POS_Norm_RF_Tool',ns) smooth(Crit_ROBOT_POS_Norm_RF_Wrist',ns)];
        Crit_Robot_POS_Norm = [smooth(Crit_ROBOT_POS_Norm_RF_Bowl', ns) smooth(Crit_ROBOT_POS_Norm_RF_Tool',ns)];
        Crit{snum}.Robot_POS_Norm = [smooth(Crit_ROBOT_POS_Norm_RF_Bowl', ns) smooth(Crit_ROBOT_POS_Norm_RF_Tool',ns)];
        
        %    subplot((final_subject-initial_subject+1)/2, , snum-29);
%         subplot(8, 5, snum-initial_subject+1); hold on; title(snum);
        subplot(8, 5, actual_idx); hold on; title(snum);
        plot(smooth(Crit_ROBOT_POS_Norm_RF_Bowl, ns),'b', 'LineWidth', 2);
        plot(smooth(Crit_ROBOT_POS_Norm_RF_Tool, ns),'r', 'LineWidth', 2);
%         plot(smooth(Crit_ROBOT_POS_Norm_RF_Wrist, ns),'k', 'LineWidth', 2);
        
%         legend('RF Bowl','RF Tool','RF Wrist');
        legend('RF Bowl','RF Tool');
        
        [ph] = detMaxCritInTimeWindow(Crit_Robot_POS_Norm,  100, 1.6);
        
        clear Robot_Pos_RF_Bowl Robot_Pos_RF_Bowl_norm Robot_Pos_RF_Tool Robot_Pos_RF_Tool_norm Robot_Pos_RF_Wrist Robot_Pos_RF_Wrist_norm
        clear ppdata_dtw
        clear Crit_Robot_POS_Norm Crit_ROBOT_POS_Norm_RF_Bowl Crit_ROBOT_POS_Norm_RF_Tool Crit_ROBOT_POS_Norm_RF_Wrist
    end
end

savefig('ALL_S_Crit_RF_Passive_Arm.fig');

%% Tool arm

figure('Name', 'RF Change for Tool Arm', 'NumberTitle', 'off'); hold  on;

actual_idx = 0;
for snum = initial_subject:final_subject
    
    if ismember(snum, excepted_subjects)
        continue
    else
        
        actual_idx = actual_idx+1;
        active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\';
        
        sname = sprintf('%sS%.2d_ppdata_dtw.mat', active_dir, snum);
        load(sname);
        
        % Compute Criteria for the change of RF - as norm of position
        for i = 1:size(ppdata_dtw.RF_Robot.ToolPos.X, 1)
            
            % make a copy of the data for current demp
            Tool_Pos_RF_Bowl = [ppdata_dtw.RF_Bowl.ToolPos.X(i,:); ppdata_dtw.RF_Bowl.ToolPos.Y(i,:); ppdata_dtw.RF_Bowl.ToolPos.Z(i,:)];
            Tool_Pos_RF_Robot = [ppdata_dtw.RF_Robot.ToolPos.X(i,:); ppdata_dtw.RF_Robot.ToolPos.Y(i,:); ppdata_dtw.RF_Robot.ToolPos.Z(i,:)];
            %Tool_Pos_RF_Wrist = [ppdata_dtw.RF_HumanWrist.ToolPos.X(i,:); ppdata_dtw.RF_HumanWrist.ToolPos.Y(i,:); ppdata_dtw.RF_HumanWrist.ToolPos.Z(i,:)];
            
            for jj = 1:size(Tool_Pos_RF_Bowl,2)
                Tool_Pos_RF_Bowl_norm(i,jj) = norm(Tool_Pos_RF_Bowl(:,jj));
                Tool_Pos_RF_Robot_norm(i,jj) = norm(Tool_Pos_RF_Robot(:,jj));
                %   Tool_Pos_RF_Wrist_norm(i,jj) = norm(Tool_Pos_RF_Wrist(:,jj));
            end
        end
        
        Crit_TOOL_POS_Norm_RF_Bowl      = CompCrit(Tool_Pos_RF_Bowl_norm);
        Crit_TOOL_POS_Norm_RF_Robot      = CompCrit(Tool_Pos_RF_Robot_norm);
        %Crit_TOOL_POS_Norm_RF_Wrist      = CompCrit(Tool_Pos_RF_Wrist_norm);
        
        ns = 15;
        Crit_TOOL_POS_Norm = [smooth(Crit_TOOL_POS_Norm_RF_Bowl', ns) smooth(Crit_TOOL_POS_Norm_RF_Robot',ns) ...
            %smooth(Crit_TOOL_POS_Norm_RF_Wrist',ns)...
            ];
        Crit{snum}.TOOL_POS_Norm = [smooth(Crit_TOOL_POS_Norm_RF_Bowl', ns) smooth(Crit_TOOL_POS_Norm_RF_Robot',ns) ...
            %smooth(Crit_TOOL_POS_Norm_RF_Wrist',ns)...
            ];
        
        %    subplot((final_subject-initial_subject+1)/2, , snum-29);
%        subplot(5, 3, snum-initial_subject-1); hold on; title(snum);
        subplot(8, 5, actual_idx); hold on; title(snum);
        plot(smooth(Crit_TOOL_POS_Norm_RF_Bowl, ns),'b', 'LineWidth', 2);
        plot(smooth(Crit_TOOL_POS_Norm_RF_Robot, ns),'r', 'LineWidth', 2);
        %plot(smooth(Crit_TOOL_POS_Norm_RF_Wrist, ns),'k', 'LineWidth', 2);
        
        legend('RF Bowl','RF Robot');
        %    legend('RF Bowl','RF Robot','RF Wrist');
        [ph] = detMaxCritInTimeWindow(Crit_TOOL_POS_Norm,  100, 1.6);
        
        clear Tool_Pos_RF_Bowl Tool_Pos_RF_Bowl_norm Tool_Pos_RF_Robot Tool_Pos_RF_Robot_norm Tool_Pos_RF_Wrist Tool_Pos_RF_Wrist_norm
        clear ppdata_dtw
        clear Crit_Tool_POS_Norm Crit_TOOL_POS_Norm_RF_Bowl Crit_TOOL_POS_Norm_RF_Robot Crit_TOOL_POS_Norm_RF_Wrist
    end
end

savefig('ALL_S_Crit_RF_Active_Arm.fig');
