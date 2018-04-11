
% Start with the metrics per subject

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');

% Note: The grasping quality is computed in the robot reference frame and
% represents the adaptability of the hand to apply forces in this RF

% GQ columns - means 24 - 29; min 30 - 35; max 36 - 41

sk = S2_metrics_all(find(S2_metrics_all(:,3) == 1),:); % select skilled subjects only
nsk = S2_metrics_all(find(S2_metrics_all(:,3) == 0),:); % select unskilled subjects only

%% Avearage values across users
fprintf('\t avg gq tx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,24)), std(sk(:,24)), mean(nsk(:,24)), std(nsk(:,24)));
fprintf('\t avg gq ty \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,25)), std(sk(:,25)), mean(nsk(:,25)), std(nsk(:,25)));
fprintf('\t avg gq tz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,26)), std(sk(:,26)), mean(nsk(:,26)), std(nsk(:,26)));
fprintf('\t avg gq rx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,27)), std(sk(:,27)), mean(nsk(:,27)), std(nsk(:,27)));
fprintf('\t avg gq ry \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,28)), std(sk(:,28)), mean(nsk(:,28)), std(nsk(:,28)));
fprintf('\t avg gq rz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,29)), std(sk(:,29)), mean(nsk(:,29)), std(nsk(:,29)));

%% Plot avg values per user

for axs = 1:6
    
    figure; hold on; %ftitle = sprintf('Max F dir %d per user', axs); title(ftitle);
    

    % Plot separately a sk and unsk subject to generate a proper legend 
    stem(6, S2_metrics_all(6,35+axs), 'r', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    stem(7, S2_metrics_all(7,35+axs), 'b', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    legend('Skilled', 'Unskilled');

    % Now plot all
    for i = 1:37
        if S2_metrics_all(i,3) == 1
            stem(i, S2_metrics_all(i,35+axs), 'r', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
        else
            stem(i, S2_metrics_all(i,35+axs), 'b', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in blue
        end
    end
    
    flabel = sprintf('%s', nh{35+axs});
    ylabel(flabel);
    xlabel('Subjects');
    
    % Figure formatting
    set(gcf, 'Color', [1 1 1]); grid on;
    set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);
    
    set(findall(gcf,'type','text'), 'FontSize', 32);
    set(findall(gcf,'type','axes'), 'FontSize', 32);
    
    set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);
    
    set(gcf, 'Position', [206 195 1259 696]);
    set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

       
    fname = sprintf('max_GQ_ax%d_per_user.fig', axs);
    savefig(fname);
    fname = sprintf('max_GQ_ax%d_per_user.png', axs);
    saveas(gcf, fname);
    
end

%% Test correlations of skilled and unskilled users between the GQ and the force applied

% Skilled
sk_gqx_Fx = corr(sk(:,24), sk(:, 42), 'Type', 'Spearman');
sk_gqy_Fx = corr(sk(:,25), sk(:, 42), 'Type', 'Spearman');
sk_gqz_Fx = corr(sk(:,26), sk(:, 42), 'Type', 'Spearman');

fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqx_Fx, nh{24}, nh{42});
fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqy_Fx, nh{25}, nh{42});
fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqz_Fx, nh{26}, nh{42});

% Unskilled
nsk_gqx_Fx = corr(nsk(:,24), nsk(:, 42), 'Type', 'Spearman');
nsk_gqy_Fx = corr(nsk(:,25), nsk(:, 42), 'Type', 'Spearman');
nsk_gqz_Fx = corr(nsk(:,26), nsk(:, 42), 'Type', 'Spearman');

fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqx_Fx, nh{24}, nh{42});
fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqy_Fx, nh{25}, nh{42});
fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqz_Fx, nh{26}, nh{42});

%% Min values across users
fprintf('\t avg min gq tx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,30)), std(sk(:,30)), mean(nsk(:,30)), std(nsk(:,30)));
fprintf('\t avg min gq ty \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,31)), std(sk(:,31)), mean(nsk(:,31)), std(nsk(:,31)));
fprintf('\t avg min gq tz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,32)), std(sk(:,32)), mean(nsk(:,32)), std(nsk(:,32)));
fprintf('\t avg min gq rx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,33)), std(sk(:,33)), mean(nsk(:,33)), std(nsk(:,33)));
fprintf('\t avg min gq ry \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,34)), std(sk(:,34)), mean(nsk(:,34)), std(nsk(:,34)));
fprintf('\t avg min gq rz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,35)), std(sk(:,35)), mean(nsk(:,35)), std(nsk(:,35)));


%% Max values across users
fprintf('\t avg max gq tx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,36)), std(sk(:,36)), mean(nsk(:,36)), std(nsk(:,36)));
fprintf('\t avg max gq ty \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,37)), std(sk(:,37)), mean(nsk(:,37)), std(nsk(:,37)));
fprintf('\t avg max gq tz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,38)), std(sk(:,38)), mean(nsk(:,38)), std(nsk(:,38)));
fprintf('\t avg max gq rx \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,39)), std(sk(:,39)), mean(nsk(:,39)), std(nsk(:,39)));
fprintf('\t avg max gq ry \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,40)), std(sk(:,40)), mean(nsk(:,40)), std(nsk(:,40)));
fprintf('\t avg max gq rz \t sk: %.2f, std %.2f \t nsk: %.2f, std %.2f \n', mean(sk(:,41)), std(sk(:,41)), mean(nsk(:,41)), std(nsk(:,41)));


%% Test correlations with the scooped weight
% Skilled
sk_gqx_Fx = corr(sk(:,24), sk(:, 4), 'Type', 'Spearman');
sk_gqy_Fx = corr(sk(:,25), sk(:, 4), 'Type', 'Spearman');
sk_gqz_Fx = corr(sk(:,26), sk(:, 4), 'Type', 'Spearman');

fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqx_Fx, nh{24}, nh{4});
fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqy_Fx, nh{25}, nh{4});
fprintf('Skilled - Spearman corr %.2f \t %s - %s \n', sk_gqz_Fx, nh{26}, nh{4});

% Unskilled
nsk_gqx_Fx = corr(nsk(:,24), nsk(:, 4), 'Type', 'Spearman');
nsk_gqy_Fx = corr(nsk(:,25), nsk(:, 4), 'Type', 'Spearman');
nsk_gqz_Fx = corr(nsk(:,26), nsk(:, 4), 'Type', 'Spearman');

fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqx_Fx, nh{24}, nh{4});
fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqy_Fx, nh{25}, nh{4});
fprintf('Unskilled - Spearman corr %.2f \t %s - %s \n', nsk_gqz_Fx, nh{26}, nh{4});