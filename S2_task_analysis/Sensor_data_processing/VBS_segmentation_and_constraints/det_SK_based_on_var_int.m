% Automatically determined skill based on the criteria

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];


% Var_Int coding
% 1 - Position
% 2 - Force
% 3 - Torque

sk = [];
subsegm = [];

for snum = 1:52
    if ismember(snum, excepted_subjects)
        continue
    end
    
    sfname = sprintf('Var_Int/S%.2d_Crit_Var_Int.mat',snum); load(sfname);
    
    [ph, var_int_X] = detMaxCritInTimeWindow(Crit.TOOL.X, 100, 0.8, false);
    [ph, var_int_Y] = detMaxCritInTimeWindow(Crit.TOOL.Y, 100, 0.8, false);
    [ph, var_int_Z] = detMaxCritInTimeWindow(Crit.TOOL.Z, 100, 0.8, false);
    
    % consider force and torque as one segment
    var_int_X(find(var_int_X == 3)) = 2;
    var_int_Y(find(var_int_Y == 3)) = 2;
    var_int_Z(find(var_int_Z == 3)) = 2;
    
    % Indexes of FT segment per axis
    FT_idx_X = find(var_int_X == 2);
    FT_len_X = FT_idx_X(end) - FT_idx_X(1) + 1; % in seconds
    
    FT_idx_Y = find(var_int_Y == 2);
    FT_len_Y = FT_idx_Y(end) - FT_idx_Y(1) + 1; % in seconds
    
    FT_idx_Z = find(var_int_Z == 2);
    FT_len_Z = FT_idx_Z(end) - FT_idx_Z(1) + 1; % in seconds
    
    % Get the start and end indexes of the FT segment as anvelope for all
    % axes
    FT_start = min([FT_idx_X(1) FT_idx_Y(1) FT_idx_Z(1)]);
    FT_end = max([FT_idx_X(end) FT_idx_Y(end) FT_idx_Z(end)]);
%    FT_len = FT_end - FT_start + 1; % in secdons
    FT_len = FT_end - FT_start; % in secdons
    
    % Segm Len
    sgm_reach_len = FT_start;
    sgm_scoop_len = FT_len;
    sgm_trash_len = size(var_int_X,1) - sgm_scoop_len - sgm_reach_len;
    
    % Search for position occurences in between the FT
    tst_pos_X = find(var_int_X(FT_start:FT_end) == 1);
    tst_pos_Y = find(var_int_Y(FT_start:FT_end) == 1);
    tst_pos_Z = find(var_int_Z(FT_start:FT_end) == 1);
    
    % Count the number of times the variable changes
    sub_X = sum(abs(diff(tst_pos_X))) + 1;
    sub_Y = sum(abs(diff(tst_pos_Y))) + 1;
    sub_Z = sum(abs(diff(tst_pos_Z))) + 1;
    
    
    subsegm = [subsegm; snum max([sub_X sub_Y sub_Z]) sub_X sub_Y sub_Z];
    
    if max([sub_X sub_Y sub_Z]) == 1
        crt_sk = 1;
    else
        crt_sk = 0;
    end
    
    sk = [sk; snum crt_sk];
    
    sk_sub{snum}.sk = [ crt_sk max([sub_X sub_Y sub_Z]) sub_X sub_Y sub_Z];
    
end

save('sk_computed.mat','sk','-mat');
save('sk_subsegm_computed.mat','subsegm','-mat');
save('sk_per_subject.mat','sk_sub','-mat');
