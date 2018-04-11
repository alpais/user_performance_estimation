avg_weight = metrics_all(:,4)./metrics_all(:,6); % Compute avg weight based on the total number of demos

% Check correlations with the auto computed skill
corr(metrics_all(:,3), avg_weight, 'Type', 'Spearman')
corr(metrics_all(sk_all,3), avg_weight(sk_all), 'Type', 'Spearman')
corr(metrics_all(nsk_all,3), avg_weight(nsk_all), 'Type', 'Spearman')

% Now just for skilled subjects
sk_all = [6,8,9,15,19,24,29,30,37];
avg_weight(sk_all)
mean(avg_weight(sk_all))
std(avg_weight(sk_all))

% and for unskilled ones
nsk_all = [1,2,3,4,5,7,10,11,12,13,14,16,17,18,20,21,22,23,25,26,27,28,31,32,33,34,35,36];
avg_weight(nsk_all)
mean(avg_weight(nsk_all))
std(avg_weight(nsk_all))
min(avg_weight(nsk_all))
max(avg_weight(nsk_all))

%% Check correlations with forces being applied

wFX = corr(avg_weight, metrics_all(:,42), 'Type', 'Spearman');
wFY = corr(avg_weight, metrics_all(:,43), 'Type', 'Spearman');
wFZ = corr(avg_weight, metrics_all(:,44), 'Type', 'Spearman');

wTx = corr(avg_weight, metrics_all(:,45), 'Type', 'Spearman');
wTy = corr(avg_weight, metrics_all(:,46), 'Type', 'Spearman');
wTz = corr(avg_weight, metrics_all(:,47), 'Type', 'Spearman');

fprintf(' wFx = %.3f, wFy = %.3f, wFz = %.3f \n', wFX, wFY, wFZ);
fprintf(' wTx = %.3f, wTy = %.3f, wTz = %.3f \n', wTx, wTy, wTz);

%% Check correlations with forces being applied - JUST SKILLED
disp('correlations with forces being applied - JUST SKILLED');

wFX = corr(avg_weight(sk_all), metrics_all((sk_all),42), 'Type', 'Spearman');
wFY = corr(avg_weight(sk_all), metrics_all((sk_all),43), 'Type', 'Spearman');
wFZ = corr(avg_weight(sk_all), metrics_all((sk_all),44), 'Type', 'Spearman');

wTx = corr(avg_weight(sk_all), metrics_all((sk_all),45), 'Type', 'Spearman');
wTy = corr(avg_weight(sk_all), metrics_all((sk_all),46), 'Type', 'Spearman');
wTz = corr(avg_weight(sk_all), metrics_all((sk_all),47), 'Type', 'Spearman');

fprintf(' wFx = %.3f, wFy = %.3f, wFz = %.3f \n', wFX, wFY, wFZ);
fprintf(' wTx = %.3f, wTy = %.3f, wTz = %.3f \n', wTx, wTy, wTz);

%% Check correlations with forces being applied - JUST UNSKILLED

disp('correlations with forces being applied - JUST UNSKILLED');

wFX = corr(avg_weight(nsk_all), metrics_all((nsk_all),42), 'Type', 'Spearman');
wFY = corr(avg_weight(nsk_all), metrics_all((nsk_all),43), 'Type', 'Spearman');
wFZ = corr(avg_weight(nsk_all), metrics_all((nsk_all),44), 'Type', 'Spearman');

wTx = corr(avg_weight(nsk_all), metrics_all((nsk_all),45), 'Type', 'Spearman');
wTy = corr(avg_weight(nsk_all), metrics_all((nsk_all),46), 'Type', 'Spearman');
wTz = corr(avg_weight(nsk_all), metrics_all((nsk_all),47), 'Type', 'Spearman');

fprintf(' wFx = %.3f, wFy = %.3f, wFz = %.3f \n', wFX, wFY, wFZ);
fprintf(' wTx = %.3f, wTy = %.3f, wTz = %.3f \n', wTx, wTy, wTz);

%% Stiffnesses
wSX = corr(avg_weight, metrics_all(:,18), 'Type', 'Spearman');
wSY = corr(avg_weight, metrics_all(:,19), 'Type', 'Spearman');
wSZ = corr(avg_weight, metrics_all(:,20), 'Type', 'Spearman');

fprintf(' wSx = %.3f, wSy = %.3f, wSz = %.3f \n', wSX, wSY, wSZ);

%% GQ
wGQX = corr(avg_weight, metrics_all(:,36), 'Type', 'Spearman');
wGQY = corr(avg_weight, metrics_all(:,37), 'Type', 'Spearman');
wGQZ = corr(avg_weight, metrics_all(:,38), 'Type', 'Spearman');

fprintf(' wGQx = %.3f, wGQy = %.3f, wGQz = %.3f \n', wGQX, wGQY, wGQZ);
