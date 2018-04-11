active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\FT\';

for snum = 38
    clrmap = colormap('winter');
    sname = sprintf('%sS%.2d_ppdata_dtw_FT.mat', active_dir, snum);
    load(sname);  disp(sname);
    
    sfigname = sprintf('Subject %d - Tool FT', snum);
    figure('Name', sfigname, 'NumberTitle', 'off'); hold on;
    set(gcf, 'Color', [1 1 1]); 
    set(0,'DefaultAxesColorOrder', winter(10));
%     set(gcf, 'Position', [404   345   919   524]);

    nrdem = size(ppdata_dtw_FT.RF_Tool.ToolFT.X,1);
    clrmap = clrmap(round(linspace(1, 64, 2*nrdem)),:);

    subplot(3,2,1); hold on; grid on; box on;
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.X); ylabel('F_x');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.X(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end
    
    subplot(3,2,3); hold on; grid on; box on;
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.Y); ylabel('F_y');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.Y(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end

    subplot(3,2,5); hold on; grid on; box on;
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.Z); ylabel('F_z');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.Z(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end


    % Torques
    subplot(3,2,2); hold on; grid on; box on;
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.RX); ylabel('T_x');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.RX(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end
    
    subplot(3,2,4); hold on; grid on; box on;
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.RY); ylabel('T_y');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.RY(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end

       
    subplot(3,2,6); hold on; grid on; box on;
    ppdata_dtw_FT.RF_Tool.ToolFT.RZ = ppdata_dtw_FT.RF_Tool.ToolFT.RZ - mean(ppdata_dtw_FT.RF_Tool.ToolFT.RZ(1:50), 2);
    plotVarianceTube(ppdata_dtw_FT.RF_Tool.ToolFT.RZ); ylabel('T_z');
    for jj = 1:nrdem
        plot(ppdata_dtw_FT.RF_Tool.ToolFT.RZ(jj,:), 'LineWidth', 2, 'Color', clrmap(1+2*(jj-1),:));
    end
    
    
    
%    ylabel('$$T~(Nm)$$', 'Interpreter', 'Latex');
% %     set_x_in_seconds(size(SData.TOOLFOR.X,2));
%     xlabel('Task Duration (s)');  
%     axis([0 8000 -0.5 1.5]);    
%     set_x_in_seconds(8000);
    
    % Figure Formatting
%     set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45]);
%     set(gca, 'Position', [0.1347    0.2481    0.8370    0.6183]);
%     set(findall(gcf,'type','text'), 'FontSize', 32);
%     set(findall(gcf,'type','axes'), 'FontSize', 32);

%     set(gca,'LooseInset',get(gca,'TightInset'));
    
     sfigname = sprintf('S%.2d_FT.fig', snum);
     savefig(sfigname);
%     
%     sfigpng = sprintf('TQS_Y_S%d.png', snum);
%     saveas(gcf,sfigpng);

end