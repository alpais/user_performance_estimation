initial_subject = 1;
final_subject = 52;

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

for snum = initial_subject:final_subject
    
    if ismember(snum, excepted_subjects)
        continue
    else
             
        active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\';
        
        sname = sprintf('%sS%.2d_ppdata_dtw.mat', active_dir, snum); load(sname);
        sname = sprintf('%s/FT_good/S%.2d_ppdata_dtw_FT.mat', active_dir, snum); load(sname);

        sfname = sprintf('Variables of Interest for subject %.2d', snum);
        
        figure('Name', sfname, 'NumberTitle', 'off'); hold on;

        % X Axis
        Crit_EEPOS_X = CompCrit(ppdata_dtw.RF_Bowl.RobotPos.X);
        Crit_EEFOR_X = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.X);
        Crit_EETQS_X = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.TX);
        
        Crit_TOOLPOS_X = CompCrit(ppdata_dtw.RF_Robot.ToolPos.X);
        Crit_TOOLFOR_X = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.X);
        Crit_TOOLTQS_X = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.TX);
        
        Crit.EE.X = [Crit_EEPOS_X' Crit_EEFOR_X' Crit_EETQS_X'];
        Crit.TOOL.X = [Crit_TOOLPOS_X' Crit_TOOLFOR_X' Crit_TOOLTQS_X'];

        subplot(3,2,1); hold on;
        plot(Crit_EEPOS_X,'b', 'LineWidth', 2);
        plot(Crit_EEFOR_X,'r', 'LineWidth', 2);
        plot(Crit_EETQS_X,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('X Axis - EE Crit');
        [ph] = detMaxCritInTimeWindow(Crit.EE.X,  100, 0.8, true);

        subplot(3,2,2); hold on;
        plot(Crit_TOOLPOS_X,'b', 'LineWidth', 2);
        plot(Crit_TOOLFOR_X,'r', 'LineWidth', 2);
        plot(Crit_TOOLTQS_X,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('X Axis - TOOL Crit');
        [ph] = detMaxCritInTimeWindow(Crit.TOOL.X,  100, 0.8, true);
        
        % Y Axis
        Crit_EEPOS_Y = CompCrit(ppdata_dtw.RF_Bowl.RobotPos.Y);
        Crit_EEFOR_Y = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.Y);
        Crit_EETQS_Y = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.TY);
        
        Crit_TOOLPOS_Y = CompCrit(ppdata_dtw.RF_Robot.ToolPos.Y);
        Crit_TOOLFOR_Y = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.Y);
        Crit_TOOLTQS_Y = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.TY);
        
        Crit.EE.Y = [Crit_EEPOS_Y' Crit_EEFOR_Y' Crit_EETQS_Y'];
        Crit.TOOL.Y = [Crit_TOOLPOS_Y' Crit_TOOLFOR_Y' Crit_TOOLTQS_Y'];

        subplot(3,2,3); hold on;
        plot(Crit_EEPOS_Y,'b', 'LineWidth', 2);
        plot(Crit_EEFOR_Y,'r', 'LineWidth', 2);
        plot(Crit_EETQS_Y,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('Y Axis - EE Crit');
        [ph] = detMaxCritInTimeWindow(Crit.EE.Y,  100, 0.8);

        subplot(3,2,4); hold on;
        plot(Crit_TOOLPOS_Y,'b', 'LineWidth', 2);
        plot(Crit_TOOLFOR_Y,'r', 'LineWidth', 2);
        plot(Crit_TOOLTQS_Y,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('Y Axis - TOOL Crit');
        [ph] = detMaxCritInTimeWindow(Crit.TOOL.Y,  100, 0.8, true);

        % Z Axis
        Crit_EEPOS_Z = CompCrit(ppdata_dtw.RF_Bowl.RobotPos.Z);
        Crit_EEFOR_Z = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.Z);
        Crit_EETQS_Z = CompCrit(ppdata_dtw_FT.RF_Robot.RobotFT.TZ);
        
        Crit_TOOLPOS_Z = CompCrit(ppdata_dtw.RF_Robot.ToolPos.Z);
        Crit_TOOLFOR_Z = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.Z);
        Crit_TOOLTQS_Z = CompCrit(ppdata_dtw_FT.RF_Tool.ToolFT.TZ);
        
        Crit.EE.Z = [Crit_EEPOS_Z' Crit_EEFOR_Z' Crit_EETQS_Z'];
        Crit.TOOL.Z = [Crit_TOOLPOS_Z' Crit_TOOLFOR_Z' Crit_TOOLTQS_Z'];

        subplot(3,2,5); hold on;
        plot(Crit_EEPOS_Z,'b', 'LineWidth', 2);
        plot(Crit_EEFOR_Z,'r', 'LineWidth', 2);
        plot(Crit_EETQS_Z,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('Z Axis - EE Crit');
        [ph] = detMaxCritInTimeWindow(Crit.EE.Z,  100, 0.8, true);

        subplot(3,2,6); hold on;
        plot(Crit_TOOLPOS_Z,'b', 'LineWidth', 2);
        plot(Crit_TOOLFOR_Z,'r', 'LineWidth', 2);
        plot(Crit_TOOLTQS_Z,'k', 'LineWidth', 2);
        legend('POS','FOR','TQS');
        title('Z Axis - TOOL Crit');
        [ph] = detMaxCritInTimeWindow(Crit.TOOL.Z,  100, 0.8, true);

        sfigname = sprintf('S%.2d_Crit_Var_Int.fig', snum);
        savefig(sfigname);
        
        soutname = sprintf('S%.2d_Crit_Var_Int.mat', snum);
        save(soutname, 'Crit', '-mat');
        
        clear Crit_EEPOS_X Crit_EEPOS_Y Crit_EEPOS_Z
        clear Crit_EEFOR_X Crit_EEFOR_Y Crit_EEFOR_Z
        clear Crit_EETQS_X Crit_EEFOR_Y Crit_EEFOR_Z
        
        clear Crit_TOOLPOS_X Crit_TOOLPOS_Y Crit_TOOLPOS_Z
        clear Crit_TOOLFOR_X Crit_TOOLFOR_Y Crit_TOOLFOR_Z
        clear Crit_TOOLTQS_X Crit_TOOLFOR_Y Crit_TOOLFOR_Z
        
        clear Crit        
    end
end