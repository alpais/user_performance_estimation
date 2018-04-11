
%% First plot per user

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');

% col 42 - 43 - 44 - max Fx, max Fy, max Fz
% auto_skill column 3

for axs = 1:3
    
    figure; hold on; %ftitle = sprintf('Max F dir %d per user', axs); title(ftitle);
    

    % Plot separately a sk and unsk subject to generate a proper legend 
    stem(6, S2_metrics_all(6,41+axs), 'r', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    stem(7, S2_metrics_all(7,41+axs), 'b', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    legend('Skilled', 'Unskilled');

    % Now plot all
    for i = 1:37
        if S2_metrics_all(i,3) == 1
            stem(i, S2_metrics_all(i,41+axs), 'r', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
        else
            stem(i, S2_metrics_all(i,41+axs), 'b', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in blue
        end
    end
    
    ylabel('Force (N)');
    xlabel('Subjects');
    
    % Figure formatting
    set(gcf, 'Color', [1 1 1]); grid on;
    set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);
    
    set(findall(gcf,'type','text'), 'FontSize', 32);
    set(findall(gcf,'type','axes'), 'FontSize', 32);
    
    set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);
    
    set(gcf, 'Position', [206 195 1259 696]);
    set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

       
    fname = sprintf('max_F_ax%d_per_user.fig', axs);
    savefig(fname);
    fname = sprintf('max_F_ax%d_per_user.png', axs);
    saveas(gcf, fname);
    
end


%%
% For the z axis 
sk_Fz = metrics_all(find(metrics_all(:,3) == 1), 44); % select skilled subjects only
mean(sk_Fz(find(sk_Fz < 5))) %see how many of the skilled subjects applied less than 5N
fprintf('%d skilled subjects applied %.2f N, std %.2f on axis 3 \n', length(find(sk_Fz < 5)), mean(sk_Fz(find(sk_Fz < 5))), std(sk_Fz(find(sk_Fz < 5))));


nsk_Fz = metrics_all(find(metrics_all(:,3) == 0), 44); % select un skilled subjects only
mean(nsk_Fz)
max(nsk_Fz)

fprintf('%d unskilled subjects applied %.2f N, std %.2f on axis 3 \n', length(nsk_Fz), mean(nsk_Fz), std(nsk_Fz));


% For the y axis 
sk_Fy = metrics_all(find(metrics_all(:,3) == 1), 43); % select skilled subjects only

mean(sk_Fy) %see how many of the skilled subjects applied less than 5N

nsk_Fy = metrics_all(find(metrics_all(:,3) == 0), 43); % un select skilled subjects only
mean(nsk_Fy(find(nsk_Fy < 12)))

fprintf('%d unskilled subjects applied %.2f N, std %.2f on axis 2 \n', length(find(nsk_Fy < 12)), mean(nsk_Fy(find(nsk_Fy < 12))), std(nsk_Fy(find(nsk_Fy < 12))));
fprintf('%d unskilled subjects applied %.2f N, std %.2f on axis 2', length(find(nsk_Fy > 12)), mean(nsk_Fy(find(nsk_Fy > 12))), std(nsk_Fy(find(nsk_Fy > 12))));

% For the x axis 
sk_Fx = metrics_all(find(metrics_all(:,3) == 1), 42); % select skilled subjects only

fprintf('Avg F aplied by skilled subjects on axis 1 was %.2f N, std %.2f \n', mean(sk_Fx), std(sk_Fx)) %see how many of the skilled subjects applied less than 5N

nsk_Fx = metrics_all(find(metrics_all(:,3) == 0), 42); % un select skilled subjects only
mean(nsk_Fx(find(nsk_Fx < 12)))

fprintf('%d unskilled subjects applied %.2f N, std %.2f on axis 1 \n', length(find(nsk_Fx < 15)), mean(nsk_Fx(find(nsk_Fx < 15))), std(nsk_Fy(find(nsk_Fx < 15))));
fprintf('%d unskilled subjects applied %.2f N, std %.2f on axis 1 \n', length(find(nsk_Fx > 15)), mean(nsk_Fx(find(nsk_Fx > 15))), std(nsk_Fy(find(nsk_Fx > 15))));


%% Plot avg per dem