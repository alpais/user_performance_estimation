active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\FT_good\';

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

%% X axis Force

sfigname = sprintf('Robot Force - X Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.X);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.X');
        
end

savefig('all_S_FX_ROBOT.fig');


%% Y axis Force

sfigname = sprintf('Robot Force - Y Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.Y);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.Y');
    
end

savefig('all_S_FY_ROBOT.fig');

%% Z axis Force

sfigname = sprintf('Robot Force - Z Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.Z);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.Z');
    
end

savefig('all_S_FZ_ROBOT.fig');

%% X axis Torque

sfigname = sprintf('Robot Torque - X Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.TX);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.TX');
    
end

savefig('all_S_TX_ROBOT.fig');

%% Y axis Torque

sfigname = sprintf('Robot Torque - Y Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.TY);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.TY');    
end

savefig('all_S_TY_ROBOT.fig');

%% Z axis Torque

sfigname = sprintf('Robot Torque - Z Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Robot.RobotFT.TZ);
    plot(ppdata_dtw_FT.RF_Robot.RobotFT.TZ');
        
end

savefig('all_S_TZ_ROBOT.fig');

