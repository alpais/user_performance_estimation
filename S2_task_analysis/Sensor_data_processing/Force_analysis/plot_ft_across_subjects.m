active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\FT_good\';

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];


load('../VBS/all_S_HD_Constraints.mat');
%% X axis Force

sfigname = sprintf('Tool Force - X Axis - Across Subjects');
figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
set(gcf, 'Color', [1 1 1]);
set(0,'DefaultAxesColorOrder', winter(10));

idx = 0;
for snum = 1:52
   
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);  load(sname); 
    
    idx = idx + 1;
    subplot(8,5,idx); hold on; grid on; box on; sfig = sprintf('Subject %d', snum); title(sfig);
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.X);
    plot(ppdata_dtw_FT.RF_Tool.ToolFT.X');
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.X), 'r', 'LineWidth',3);
    ylim([0 50]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
end

savefig('all_S_FX_w_mean.fig');


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
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.Y), 'r', 'LineWidth',3);
    ylim([0 50]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
   
end

savefig('all_S_FY_w_mean.fig');

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
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.X), 'r', 'LineWidth',3);
    ylim([-20 20]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
    
end

savefig('all_S_FZ_w_mean.fig');

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
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.TX), 'r', 'LineWidth',3);
    ylim([-5 5]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
    
end

savefig('all_S_TX_w_mean.fig');

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
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.TY), 'r', 'LineWidth',3);
    ylim([-5 5]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
    
end

savefig('all_S_TY_w_mean.fig');

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
    plot(mean(ppdata_dtw_FT.RF_Tool.ToolFT.TZ), 'r', 'LineWidth',3);
    ylim([-5 5]);
    if (constraints{snum}.skill==0)
        set(gca, 'Color', [0.85 0.85 0.85]);
    else
        set(gca, 'Color', [1 1 1]);
    end
        
end

savefig('all_S_TZ_w_mean.fig');

