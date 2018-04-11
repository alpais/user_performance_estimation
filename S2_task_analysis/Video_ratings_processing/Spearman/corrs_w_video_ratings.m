urating = load('D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\second_video_rating\users.txt');
urating = sortrows(urating, 2);

% Discretize the skill column
 for i = 1:size(urating, 1)
     if urating(i, 3) <= 3
         urating(i, 3) = 0;
     else
         urating(i, 3) = 1;
     end
 end
 
r1 = urating( 1:37, :);
r2 = urating(38:74, :);

%%
skr = [r1(:,3) r2(:,3)]; avg_usr = mean(skr')';



corr(metrics_all(:,3), r2(:,4), 'Type', 'Spearman')

corr(metrics_all(:,4), avg_usr)

%%
fprintf('\n\n ========================================\n');

% dim = 3;
% avg_dim = mean([r1(:, dim) r2(:, dim)]')';

for i = 1:37 
    if (r1(i, 3) == 1 && r2(i, 3) == 1)
        just_goods(i,1) = 1;
    else
        just_goods(i,1) = 0;
    end
end

for i = 1:75
    tv(i) = corr(metrics_all(:,i), just_goods, 'Type', 'Spearman');
    if abs(tv(i)) > 0.5
        fprintf('%s \n',headers_metrics_all{i});
    end    
end

%% Compuse cate doua

fprintf('\n\n ========================================\n');
% dim = 3;
% avg_dim = floor([r1(:, dim) r2(:, dim)]')';

for i = 3:76
    for j = (i+1):76
        tst = metrics_all(:,i).*metrics_all(:,j);
        tst_sp = corr(tst, just_goods, 'Type', 'Spearman');
        if abs(tst_sp >0.5) 
            fprintf('%.2f >> %d, %d - %s - %s \n', tst_sp, i,j, headers_metrics_all{i}, headers_metrics_all{j}); 
        end;         
    end
end


%% Compuse cate trei 

fprintf('\n\n ========================================\n');
dim = 3;
avg_dim = floor(mean([r1(:, dim) r2(:, dim)]')');

for i = 3:75
    for j = (i+1):75
        for k = (j+1):75
            tst = metrics_all(:,i).*metrics_all(:,j).*metrics_all(:,k);
            tst_sp = corr(tst, just_goods, 'Type', 'Spearman');
            if abs(tst_sp >0.5)
                fprintf('%.2f >> %d, %d, %d - %s - %s - %s \n', tst_sp, i,j,k, headers_metrics_all{i}, headers_metrics_all{j}, headers_metrics_all{k});
            end;
        end
    end
end


%% Use other ratings from this eval
simprov = [r1(:,4) r2(:,4)]; avg_simprov = mean(simprov')';
metrics_all = [metrics_all avg_simprov];

%% COrrelation with my metrics

corr(metrics_all(1:11,3), just_goods(1:11,:), 'Type', 'Spearman')
corr(metrics_all(12:27,3), just_goods(12:27,:), 'Type', 'Spearman')
corr(metrics_all(28:37,3), just_goods(28:37,:), 'Type', 'Spearman')
