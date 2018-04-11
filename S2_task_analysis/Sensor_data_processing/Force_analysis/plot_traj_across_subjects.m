active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\';

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

%% X axis Traj


idx = 0;
for snum = 1:52
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sfigname = sprintf('Tool Traj - X Axis - Across Subjects');
    figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
    set(gcf, 'Color', [1 1 1]);
    set(0,'DefaultAxesColorOrder', winter(10));

    sname = sprintf('%sS%.2d_ppdata_dtw.mat', active_dir, snum);
    load(sname); 
    
    idx = idx + 1;
%     subplot(8,5,idx); 
    hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
%     plotVarianceTube(ppdata_dtw.RF_Robot.ToolPos.X);
%     plot(ppdata_dtw.RF_Robot.ToolPos.X');

    for jj = 1:size(ppdata_dtw.RF_Robot.ToolPos.X,1)
        plot3(ppdata_dtw.RF_Robot.ToolPos.X(jj, :), ppdata_dtw.RF_Robot.ToolPos.Y(jj, :), ppdata_dtw.RF_Robot.ToolPos.Z(jj, :));
    end
    view(3);
        
    sfname = sprintf('S%.2d_Pos_3D.fig', snum);
    savefig(sfname);
end

% savefig('all_S_POS_3D.fig');


%% Y axis Force

sfigname = sprintf('Tool Force - Y Axis - Across Subjects');
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
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.Y);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.Y');
    
end

savefig('all_S_FY.fig');

%% Z axis Force

sfigname = sprintf('Tool Force - Z Axis - Across Subjects');
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
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.Z);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.Z');
    
end

savefig('all_S_FZ.fig');

%% X axis Torque

sfigname = sprintf('Tool Torque - X Axis - Across Subjects');
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
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.TX);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.TX');
    
end

savefig('all_S_TX.fig');

%% Y axis Torque

sfigname = sprintf('Tool Torque - Y Axis - Across Subjects');
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
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.TY);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.TY');    
end

savefig('all_S_TY.fig');

%% Z axis Torque

sfigname = sprintf('Tool Torque - Z Axis - Across Subjects');
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
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.TZ);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.TZ');
        
end

savefig('all_S_TZ.fig');

