function [ ph, var_int ] = detMaxCritInTimeWindow( Crit, win_size, scaling_factor, enable_plotting)
%DETMAXCRITINTIMEWINDOW_BATTERYTASK Summary of this function goes here
%   Detailed explanation goes here


% for i = 1:win_size:size(Crit.X,1)
%     for j = 1:win_size
%         max = max(Crit)
%     end
% end

var_int = [];

[tt tmp_idx] = max(Crit, [], 2);
% detremine maximum along the whole vector
% tt contains the maximum value
% tmp_idx contains the number of the column where the maximum was found at
% that time step


counter = 1; % the number of segmnets
% save the initial values i.e. the starting of the first segment
sgm_var(counter) = tmp_idx(1); 
sgm_pos(counter) = 1; 

for i = 2:length(tmp_idx) 
    if (tmp_idx(i) - tmp_idx(i-1) ~=0) 
      counter = counter + 1; 
      sgm_var(counter) = tmp_idx(i);
      sgm_pos(counter) = i;
    end; 
end

%% Patch separetely only the maximum of each variable
% figure; hold on;
%color(1) = 'c'; color(2) = 'm'; color(3) = 'grey';

color(1,:) = [0.7686 0.9412 0.9451]; % Light blue for position
color(2,:) = [0.9608 0.8824 0.9725]; % Light red for Force
color(3,:) = [0.8627 0.9227 0.8627]; % Light grey for Torque


% for i = 1:length(sgm_pos)-1
%     px = [sgm_pos(i) sgm_pos(i) sgm_pos(i+1) sgm_pos(i+1)];
%     py = [-0.05 0.05 0.05 -0.05]; % * sgm_var(i);
%     ph = patch(px, py, color(sgm_var(i),:));
%     uistack(ph,'bottom');
% end



%% Analyze in a given window
for i = 1:ceil(length(tmp_idx)/win_size)

    interval_start = win_size * (i-1) + 1;
    interval_end = win_size * i;
    
    if (interval_end > length(tmp_idx)) 
        interval_end = length(tmp_idx); 
    end
    
%     disp(interval_start); disp(interval_end);    
    pos_times = sum(tmp_idx(interval_start:interval_end) == 1);
    for_times = sum(tmp_idx(interval_start:interval_end) == 2);
    tqs_times = sum(tmp_idx(interval_start:interval_end) == 3);
    [max_var var_idx] = max([pos_times for_times tqs_times]);

    msg = sprintf('window %d important variable is %d', i, var_idx);
    disp(msg);

    var_int = [var_int; var_idx];
    
    % Patch segmentation for given window size
    px = [interval_start interval_start interval_end interval_end];
    py = [-0.05 0.05 0.05 -0.05] * scaling_factor; % * sgm_var(i); % For criterion % 0.04, 0.12, 0.20, 0.28
    % py = [0 1 1 0] * 20; % * for stiffness
    

    if (enable_plotting==true)
        ph(i) = patch(px, py, color(var_idx,:));
        uistack(ph,'bottom');
    else
        ph = [];
    end
    
end


end

