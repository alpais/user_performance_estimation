load('../S2_task_analysis/metrics_per_dem_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_per_dem_NVR.mat');


%% Get skilled and unskilled separately

sk = S2_metrics_per_dem_NVR(find(S2_metrics_per_dem_NVR(:,3) == 1),:); % select skilled subjects only
nsk = S2_metrics_per_dem_NVR(find(S2_metrics_per_dem_NVR(:,3) == 0),:); % select unskilled subjects only

%% Compute correlations - for skilled

for ftcol = 12:23
    for i = 24:29
        nvc = corr(sk(:,ftcol), sk(:,i), 'Type', 'Spearman');
        fprintf('%.2f \t skilled corr %s - %s \n', nvc, headers_per_dem_NVR{ftcol}, headers_per_dem_NVR{i});
    end
    fprintf('\n');
    
end

%% Compute correlations - for unskilled

for ftcol = 12:23
    for i = 24:29
        nvc = corr(nsk(:,ftcol), nsk(:,i), 'Type', 'Spearman');
        fprintf('%.2f \t unskilled corr %s - %s \n', nvc, headers_per_dem_NVR{ftcol}, headers_per_dem_NVR{i});
    end
    fprintf('\n');
    
end


%% Plot pressure per hand part in skilled and unskilled users

% normalize pressure values

for press_col = 24:29
        S2_metrics_per_dem_NVR(:,press_col) =  ...
            (S2_metrics_per_dem_NVR(:,press_col) - min(S2_metrics_per_dem_NVR(:,press_col))) / ...
            (max(S2_metrics_per_dem_NVR(:,press_col)) - min(S2_metrics_per_dem_NVR(:,press_col)));
end

sk = S2_metrics_per_dem_NVR(find(S2_metrics_per_dem_NVR(:,3) == 1),:); % select skilled subjects only
nsk = S2_metrics_per_dem_NVR(find(S2_metrics_per_dem_NVR(:,3) == 0),:); % select unskilled subjects only

% Plot
avg_pressure_sk = [mean(sk(:, 24)) mean(sk(:, 25)) mean(sk(:, 26)) mean(sk(:, 27)) mean(sk(:, 28)) mean(sk(:, 29))];
std_pressure_sk = [std(sk(:, 24)) std(sk(:, 25)) std(sk(:, 26)) std(sk(:, 27)) std(sk(:, 28)) std(sk(:, 29))];

avg_pressure_nsk = [mean(nsk(:, 24)) mean(nsk(:, 25)) mean(nsk(:, 26)) mean(nsk(:, 27)) mean(nsk(:, 28)) mean(nsk(:, 29))];
std_pressure_nsk = [std(nsk(:, 24)) std(nsk(:, 25)) std(nsk(:, 26)) std(nsk(:, 27)) std(nsk(:, 28)) std(nsk(:, 29))];

avg_gq_x = [avg_pressure_sk; avg_pressure_nsk]';
std_gq_x = [std_pressure_sk; std_pressure_nsk]';

sticklabels = {'Thumb','Index', 'Middle','Ring','Pinky','Palm'};
slegend = {'Skilled', 'Unskilled'};

plot_grouped_plot(avg_gq_x, std_gq_x, sticklabels, slegend);
format_grouped_plot('normalized pressure','Hand parts', [0 0.8]);

%% Run ANOVA for pressure on each hand part - factor user skill

for i = 24:29
    [a,b] = anova1(S2_metrics_per_dem_NVR(:,i), S2_metrics_per_dem_NVR(:,3), 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: auto_skill; Metric: column %d - %s \n', b{2,5}, a, i, headers_per_dem_NVR{i});

end
fprintf('\n');


%% Plot pressure per hand part in low vs high quality demonstrations

for i = 1:size(S2_metrics_per_dem_NVR,1)
    if S2_metrics_per_dem_NVR(i,7) > 0.7
        dem_rating(i) = 1;
    else
        dem_rating(i) = 0;
    end
end
dem_rating = dem_rating';

hi_dem = S2_metrics_per_dem_NVR(find(dem_rating(:) == 1),:); % select skilled subjects only
lo_dem = S2_metrics_per_dem_NVR(find(dem_rating(:) == 0),:); % select unskilled subjects only

avg_pressure_hi_dem = [mean(hi_dem(:, 24)) mean(hi_dem(:, 25)) mean(hi_dem(:, 26)) mean(hi_dem(:, 27)) mean(hi_dem(:, 28)) mean(hi_dem(:, 29))];
std_pressure_hi_dem = [std(hi_dem(:, 24)) std(hi_dem(:, 25)) std(hi_dem(:, 26)) std(hi_dem(:, 27)) std(hi_dem(:, 28)) std(hi_dem(:, 29))];

avg_pressure_lo_dem = [mean(lo_dem(:, 24)) mean(lo_dem(:, 25)) mean(lo_dem(:, 26)) mean(lo_dem(:, 27)) mean(lo_dem(:, 28)) mean(lo_dem(:, 29))];
std_pressure_lo_dem = [std(lo_dem(:, 24)) std(lo_dem(:, 25)) std(lo_dem(:, 26)) std(lo_dem(:, 27)) std(lo_dem(:, 28)) std(lo_dem(:, 29))];

avg_gq_x = [avg_pressure_hi_dem; avg_pressure_lo_dem]';
std_gq_x = [std_pressure_hi_dem; std_pressure_lo_dem]';

sticklabels = {'Thumb','Index', 'Middle','Ring','Pinky','Palm'};
slegend = {'High quality demo', 'Low quality demo'};

plot_grouped_plot(avg_gq_x, std_gq_x, sticklabels, slegend);
format_grouped_plot('normalized pressure','Hand parts', [0 0.8]);

%% Run ANOVA for pressure on each hand part - factor demonstration rating

for i = 24:29
    [a,b] = anova1(S2_metrics_per_dem_NVR(:,i), dem_rating, 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: dem_rating; Metric: column %d - %s \n', b{2,5}, a, i, headers_per_dem_NVR{i});

end
fprintf('\n');
