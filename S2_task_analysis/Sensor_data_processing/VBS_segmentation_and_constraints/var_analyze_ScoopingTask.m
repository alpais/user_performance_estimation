function [Crit] = var_analyze_ScoopingTask( SDataDTW)
%Computes Variance and Criteria 

figure; hold on;
%%
% On X Axis

Crit_EEPOS_X = CompCrit(SDataDTW.DTW_EEPOS.X);
Crit_EEFOR_X = CompCrit(SDataDTW.DTW_EEFOR.X);
Crit_EETQS_X = CompCrit(SDataDTW.DTW_EETQS.X);

Crit_TOOLPOS_X = CompCrit(SDataDTW.DTW_TOOLPOS.X);
Crit_TOOLFOR_X = CompCrit(SDataDTW.DTW_TOOLFOR.X);
Crit_TOOLTQS_X = CompCrit(SDataDTW.DTW_TOOLTQS.X);

subplot(3,2,1); hold on;
plot(Crit_EEPOS_X,'b');
plot(Crit_EEFOR_X,'r');
plot(Crit_EETQS_X,'k');
legend('POS','FOR','TQS');
title('X Axis - EE Crit');

subplot(3,2,2); hold on;
plot(Crit_TOOLPOS_X,'b');
plot(Crit_TOOLFOR_X,'r');
plot(Crit_TOOLTQS_X,'k');
legend('POS','FOR','TQS');
title('X Axis - TOOL Crit');

Crit.EE.X = [Crit_EEPOS_X' Crit_EEFOR_X' Crit_EETQS_X'];
Crit.TOOL.X = [Crit_TOOLPOS_X' Crit_TOOLFOR_X' Crit_TOOLTQS_X'];
%%
% On Y Axis

Crit_EEPOS_Y = CompCrit(SDataDTW.DTW_EEPOS.Y);
Crit_EEFOR_Y = CompCrit(SDataDTW.DTW_EEFOR.Y);
Crit_EETQS_Y = CompCrit(SDataDTW.DTW_EETQS.Y);

Crit_TOOLPOS_Y = CompCrit(SDataDTW.DTW_TOOLPOS.Y);
Crit_TOOLFOR_Y = CompCrit(SDataDTW.DTW_TOOLFOR.Y);
Crit_TOOLTQS_Y = CompCrit(SDataDTW.DTW_TOOLTQS.Y);

subplot(3,2,3); hold on;
plot(Crit_EEPOS_Y,'b');
plot(Crit_EEFOR_Y,'r');
plot(Crit_EETQS_Y,'k');
legend('POS','FOR','TQS');
title('Y AYis - EE Crit');

subplot(3,2,4); hold on;
plot(Crit_TOOLPOS_Y,'b');
plot(Crit_TOOLFOR_Y,'r');
plot(Crit_TOOLTQS_Y,'k');
legend('POS','FOR','TQS');
title('Y AYis - TOOL Crit');

Crit.EE.Y = [Crit_EEPOS_Y' Crit_EEFOR_Y' Crit_EETQS_Y'];
Crit.TOOL.Y = [Crit_TOOLPOS_Y' Crit_TOOLFOR_Y' Crit_TOOLTQS_Y'];
%%
% On Z Axis

Crit_EEPOS_Z = CompCrit(SDataDTW.DTW_EEPOS.Z);
Crit_EEFOR_Z = CompCrit(SDataDTW.DTW_EEFOR.Z);
Crit_EETQS_Z = CompCrit(SDataDTW.DTW_EETQS.Z);

Crit_TOOLPOS_Z = CompCrit(SDataDTW.DTW_TOOLPOS.Z);
Crit_TOOLFOR_Z = CompCrit(SDataDTW.DTW_TOOLFOR.Z);
Crit_TOOLTQS_Z = CompCrit(SDataDTW.DTW_TOOLTQS.Z);

subplot(3,2,5); hold on;
plot(Crit_EEPOS_Z,'b');
plot(Crit_EEFOR_Z,'r');
plot(Crit_EETQS_Z,'k');
legend('POS','FOR','TQS');
title('Z AZis - EE Crit');

subplot(3,2,6); hold on;
plot(Crit_TOOLPOS_Z,'b');
plot(Crit_TOOLFOR_Z,'r');
plot(Crit_TOOLTQS_Z,'k');
legend('POS','FOR','TQS');
title('Z AZis - TOOL Crit');

Crit.EE.Z = [Crit_EEPOS_Z' Crit_EEFOR_Z' Crit_EETQS_Z'];
Crit.TOOL.Z = [Crit_TOOLPOS_Z' Crit_TOOLFOR_Z' Crit_TOOLTQS_Z'];

end

function [Crit] = CompCrit(data)

w_width = 2000; % Window width in time samples
th_sigma = 1; 
[var_tw, var_trial] = calculate_variance_of_window_and_trial(data, w_width);
% [n_var_tw, n_var_trials] = normalize_variances(var_tw, var_trial, th_sigma);
n_var_trials = var_trial/norm(var_trial);
n_var_tw = var_tw/norm(var_tw);
Crit = n_var_trials - n_var_tw;

end