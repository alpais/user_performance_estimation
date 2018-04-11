%% Stiffness of the active arm

% First plot per user

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');


% col 21 - 22 - 23 - Stiffness passive arm X, Y, Z
% auto_skill column 3

for axs = 1:3
    
    figure; hold on; %ftitle = sprintf('Max F dir %d per user', axs); title(ftitle);
    

    % Plot separately a sk and unsk subject to generate a proper legend 
    stem(6, S2_metrics_all(6,20+axs), 'r', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    stem(7, S2_metrics_all(7,20+axs), 'b', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    legend('Skilled', 'Unskilled');

    % Now plot all
    for i = 1:37
        if S2_metrics_all(i,3) == 1
            stem(i, S2_metrics_all(i,20+axs), 'r', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
        else
            stem(i, S2_metrics_all(i,20+axs), 'b', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in blue
        end
    end
    
    ylabel('Stiffness modulation - Active arm');
    xlabel('Subjects');
    
    % Figure formatting
    set(gcf, 'Color', [1 1 1]); grid on;
    set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);
    
    set(findall(gcf,'type','text'), 'FontSize', 32);
    set(findall(gcf,'type','axes'), 'FontSize', 32);
    
    set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);
    
    set(gcf, 'Position', [206 195 1259 696]);
    set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

       
    fname = sprintf('lambda_active_arm_ax%d_per_user.fig', axs);
    savefig(fname);
    fname = sprintf('lambda_active_arm_ax%d_per_user.png', axs);
    saveas(gcf, fname);
    
end

%% Compute anovas

for i = 21:23
    [a,b] = anova1(S2_metrics_all(:,i), S2_metrics_all(:,3), 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: auto-skill; Metric: column %d - %s \n', b{2,5}, a, i, nh{i});
end

%% Compute correlations

for i = 21:23
    for j = 3:11
        ctmp = corr(S2_metrics_all(:,i), S2_metrics_all(:,j), 'Type', 'Spearman');
        fprintf('%.2f, \t \t corr %s - %s \n', ctmp, nh{i}, nh{j});
    end
end

%% Compute mean and averages for skilled and unskilled

% Passive arm
% x axis
fprintf('\n');
sk_active_stiff_X = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 21); % select skilled subjects only
fprintf('axis 1 - active arm - %d skilled \t - avg stiff %.2f, std %.2f \n', ...
    length(sk_active_stiff_X), mean(sk_active_stiff_X), std(sk_active_stiff_X));
nsk_active_X = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 21); % select skilled subjects only
fprintf('axis 1 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_active_X), mean(nsk_active_X), std(nsk_active_X));

% with threshold
% fprintf('axis 1 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_X < 0.4)), mean(nsk_ps_X(find(nsk_ps_X < 0.4))), std(nsk_ps_X(find(nsk_ps_X < 0.4))));
% fprintf('axis 1 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_X > 0.4)), mean(nsk_ps_X(find(nsk_ps_X > 0.4))), std(nsk_ps_X(find(nsk_ps_X > 0.4))));


% y axis
fprintf('\n');
sk_active_stiff_Y = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 22); % select skilled subjects only
fprintf('axis 2 - active arm - %d skilled \t - avg stiff %.2f, std %.2f \n', ...
    length(sk_active_stiff_Y), mean(sk_active_stiff_Y), std(sk_active_stiff_Y));
nsk_active_Y = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 22); % select skilled subjects only
fprintf('axis 2 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_active_Y), mean(nsk_active_Y), std(nsk_active_Y));

% with threshold
% fprintf('axis 2 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Y < 0.4)), mean(nsk_ps_Y(find(nsk_ps_Y < 0.4))), std(nsk_ps_Y(find(nsk_ps_Y < 0.4))));
% fprintf('axis 2 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Y > 0.4)), mean(nsk_ps_Y(find(nsk_ps_Y > 0.4))), std(nsk_ps_Y(find(nsk_ps_Y > 0.4))));

% Z axis
fprintf('\n');
sk_active_stiff_Z = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 23); % select skilled subjects only
fprintf('axis 3 - active arm - %d skilled \t - avg stiff %.2f, std %.2f \n', ...
    length(sk_active_stiff_Z), mean(sk_active_stiff_Z), std(sk_active_stiff_Z));
nsk_active_Z = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 23); % select skilled subjects only
fprintf('axis 3 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_active_Z), mean(nsk_active_Z), std(nsk_active_Z));

% with threshold
% fprintf('axis 3 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Z < 0.4)), mean(nsk_ps_Z(find(nsk_ps_Z < 0.4))), std(nsk_ps_Z(find(nsk_ps_Z < 0.4))));
% fprintf('axis 3 - active arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Z > 0.4)), mean(nsk_ps_Z(find(nsk_ps_Z > 0.4))), std(nsk_ps_Z(find(nsk_ps_Z > 0.4))));
