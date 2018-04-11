function [] = det_RF_Scooping_TASK(snum)
%DET_RF_SCOOPING_TASK Summary of this function goes here
%   Detailed explanation goes here

active_dir = 'D:\Dropbox\MyPhdWork\ALP_User_studies\USER_STUDY_Mellon_Scooping_RELOADED\ppdata_dtw\';

sname = sprintf('%sS%.2d_ppdata_dtw.mat', active_dir, snum);
load(sname);

Crit_RF_Tool_Bowl.X = CompCrit(ppdata_dtw.RF_Bowl.ToolPos.X);
Crit_RF_Tool_Bowl.Y = CompCrit(ppdata_dtw.RF_Bowl.ToolPos.Y);
Crit_RF_Tool_Bowl.Z = CompCrit(ppdata_dtw.RF_Bowl.ToolPos.Z);

Crit_RF_Tool_Robot.X = CompCrit(ppdata_dtw.RF_Robot.ToolPos.X);
Crit_RF_Tool_Robot.Y = CompCrit(ppdata_dtw.RF_Robot.ToolPos.Y);
Crit_RF_Tool_Robot.Z = CompCrit(ppdata_dtw.RF_Robot.ToolPos.Z);

Crit_RF_Tool_Wrist.X = CompCrit(ppdata_dtw.RF_HumanWrist.ToolPos.X);
Crit_RF_Tool_Wrist.Y = CompCrit(ppdata_dtw.RF_HumanWrist.ToolPos.Y);
Crit_RF_Tool_Wrist.Z = CompCrit(ppdata_dtw.RF_HumanWrist.ToolPos.Z);

figure; hold on;
subplot(3,1,1); hold on; plot(Crit_RF_Tool_Bowl.X, 'r'); plot(Crit_RF_Tool_Robot.X, 'k'); plot(Crit_RF_Tool_Wrist.X, 'b'); legend({'Bowl', 'Robot', 'Wrist'});
subplot(3,1,2); hold on; plot(Crit_RF_Tool_Bowl.Y, 'r'); plot(Crit_RF_Tool_Robot.Y, 'k'); plot(Crit_RF_Tool_Wrist.Y, 'b'); legend({'Bowl', 'Robot', 'Wrist'});
subplot(3,1,3); hold on; plot(Crit_RF_Tool_Bowl.Z, 'r'); plot(Crit_RF_Tool_Robot.Z, 'k'); plot(Crit_RF_Tool_Wrist.Z, 'b'); legend({'Bowl', 'Robot', 'Wrist'});


end

