


good_subjects = [7,8,9,10,11,13,17,18,19,20,21,22,24,25,27,29,30,31,32,33,34,35,36,37,38,39,40,41,44,45,46,47,48,49,50,51,52];


for i = 1:length(good_subjects)
    cs = good_subjects(i);
    dem(i,1) = good_subjects(i);
    dem(i,2) = length(find(metrics_per_dem(:,1)==cs))/3; %sensor metrics per dem
    dem(i,3) = length(find(video_metrics_per_dem(:,1)==cs))/6;
    
    if (dem(i,2) ~= round(dem(i,2)))
        fprintf('Check Subject %d on dem no \n', good_subjects(i));
    elseif  (dem(i,2) ~= dem(i,3))
        fprintf('Check Subject %d on video ratings \n', good_subjects(i));
    end
end


% Video ratings
headers = {'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'Skill', 'Task_Pace', ...
    'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};


%%

% sort by raters
nb_raters = 6;

for i = 1:length(good_subjects)
    
    % Get indexes for subject
    clear temp_idx
    temp_idx = find(video_metrics_per_dem(:,1)== i);
    
    % Get data
    clear temp_data
    temp_data = video_metrics_per_dem(temp_idx,:);
    
    % Case A - more video ratings than demos
    %First order by raters
    for jj = 1:nb_raters
        r_stats.subject{i}.rater{jj} = temp_data(jj:6:end,:);
    end
end

%% ===================== Cohen's KAPPA ==============================

for kappa_col = 5:10; % Column for which to compute Cohen's kappa
    
    % Concatenate by subject and keep raters distinct
    rating_all_sub = [];
    
    for rater_num = 1:nb_raters
        rating = [];
        for i = 1:length(good_subjects)
            rating = [rating; r_stats.subject{i}.rater{rater_num}(:, kappa_col)];
        end
        rating_all_sub.rater{rater_num} = rating;
    end
    
    
    % Compute k - interrater agreement
    
    raters_kappa= [];
    for jj = 1:nb_raters
        for kk = jj+1:nb_raters
            fprintf('>>>>>>>>>> Computing Kappa for raters %d %d \n \n', jj, kk);
            ch = crosstab(rating_all_sub.rater{jj}, rating_all_sub.rater{kk});
            [nb_rows, nb_cols] = size(ch);
            raters_kappa(jj,kk) = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
            fprintf('============================================== \n');
            clear ch
        end
    end
    
    zz = reshape(raters_kappa, 1, 30);
    zidx = find(zz~=0);
    all_avg = mean(zz(zidx));
    all_max = max(zz(zidx));
    
    % Check kappa values just for skilled vs unskilled user rating
    
    rating_sk_sub = [];
    rating_nsk_sub = [];
    
    for rater_num = 1:nb_raters
        rating_sk = []; rating_nsk = [];
        for i = 1:37
            if (sk(i,2) == 1) % Skilled by sensor metrics
                rating_sk = [rating_sk; r_stats.subject{i}.rater{rater_num}(:,kappa_col)];
            else
                rating_nsk = [rating_nsk; r_stats.subject{i}.rater{rater_num}(:,kappa_col)];
            end
        end
        rating_sk_sub.rater{rater_num} = rating_sk;
        rating_nsk_sub.rater{rater_num} = rating_nsk;
    end
    
    
    % Compute K for skilled
    raters_sk_kappa= [];
    for jj = 1:nb_raters
        for kk = jj+1:nb_raters
            fprintf('>>>>>>>>>> Computing Kappa for raters %d %d \n \n', jj, kk);
            ch = crosstab(rating_sk_sub.rater{jj}, rating_sk_sub.rater{kk});
            [nb_rows, nb_cols] = size(ch);
            raters_sk_kappa(jj,kk) = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
            fprintf('============================================== \n');
            clear ch
        end
    end
    
    zz = reshape(raters_sk_kappa, 1, 30);
    zidx = find(zz~=0);
    sk_avg = mean(zz(zidx));
    sk_max = max(zz(zidx));
    
    
    % Compute K for unskilled
    raters_nsk_kappa= [];
    for jj = 1:nb_raters
        for kk = jj+1:nb_raters
            fprintf('>>>>>>>>>> Computing Kappa for raters %d %d \n \n', jj, kk);
            ch = crosstab(rating_nsk_sub.rater{jj}, rating_nsk_sub.rater{kk});
            [nb_rows, nb_cols] = size(ch);
            raters_nsk_kappa(jj,kk) = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
            fprintf('============================================== \n');
            clear ch
        end
    end
    
    zz = reshape(raters_nsk_kappa, 1, 30);
    zidx = find(zz~=0);
    nsk_avg = mean(zz(zidx));
    nsk_max = max(zz(zidx));
    
    
    kappa_means(kappa_col - 4, :) = [all_avg all_max sk_avg sk_max nsk_avg nsk_max];
    
end