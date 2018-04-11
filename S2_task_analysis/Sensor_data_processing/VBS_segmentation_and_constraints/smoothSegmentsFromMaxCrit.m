function [] = smoothSegmentsFromMaxCrit(Crit, min_sgm_length)

[tt, tmp_idx] = max(Crit, [], 2);
% determine maximum along the whole vector
% tt contains the maximum value
% tmp_idx contains the number of the column where the maximum was found at
% that time step

cdx = 1; % the number of segmnets
% save the initial values i.e. the starting of the first segment
sgm_var(cdx) = tmp_idx(1); 
sgm_pos(cdx) = 1; 

for i = 2:length(tmp_idx) 
    if (tmp_idx(i) - tmp_idx(i-1) ~=0) 
      cdx = cdx + 1; 
      sgm_var(cdx) = tmp_idx(i);
      sgm_pos(cdx) = i;
    end; 
end

% Compute the new segmentation points with smoothing
%min_sgm_length = 1000; % Segments cannot be smaller than the sampling rate
temp = find(diff(sgm_pos)<min_sgm_length);
elem_to_be_deleted = [];
for i = 1:length(temp)
    elem_to_be_deleted = [elem_to_be_deleted temp(i) temp(i)+1];
end
elem_to_be_deleted = unique(elem_to_be_deleted); % deleting duplicates

sgm_pos_new = sgm_pos; sgm_var_new = sgm_var;
for i = length(elem_to_be_deleted):-1:1
    sgm_pos_new(elem_to_be_deleted(i)) = [];
    sgm_var_new(elem_to_be_deleted(i)-1) = [];
end

cidx(1,:) = [0.72 0.86 0.53];  % light green - position
cidx(2,:) = [0.85 0.33 0.10];  % light orange - force
cidx(3,:) = [0.85 0.33 0.10];  % light orange - tqs

sgm_pos_new = [sgm_pos_new 17250];

for i = 1:length(sgm_pos_new)-1
    idx = sgm_pos_new(i):sgm_pos_new(i+1);
    plot(idx, tt(sgm_pos_new(i):sgm_pos_new(i+1)), 'Color', cidx(sgm_var_new(i),:), 'Marker', '.');
end

end