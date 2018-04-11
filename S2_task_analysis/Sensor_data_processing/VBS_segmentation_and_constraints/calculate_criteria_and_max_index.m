function [VAR] = calculate_criteria_and_max_index(VAR,num_obj,th_normal)
% Computes the importance criteria from the previously computed variances of time window and trials
% Input: 
%   VAR = the normalize variance structure
%   num_objects - number of objects - in our case 2 objects
%   th_normal - threshold for the criteria. 0 means that only positive criteria is consider to be important.
%
% In this function, 
%   cart_criteria(t)             : the criterion for cartesian Position at each time 
%   SF_criteria(t)               : the criterion for cartesian Force at each time 
%   ST_criteria(t)               : the criterion for cartesian Torque at each time step
%
%   max_cart_criteria_index      : the time indexes that have the positive and max criteria of cartesian Position
%   max_SF_criteria_index        : the index of time which have the positive and max criteria of cartesian Force
%   max_ST_criteria_index        : the index of time which have the positive and max criteria of cartesian Torque
%
%   max_cart_criteria_segment_start_point(count) 
%       : extract the continuous part which indecates the max and postitive
%         criteria. "count" is number of part, and this parameter tells 
%         when the continous part starts. just for plotting
%
%   First, 
%   compute the criteria from the variance of time window and trials.
%   formula is "Criteria = Var(window) - Var(trial)"
%   
%   Second,
%   find the index of time which have the positive criteria
%
%   Third,
%   find the index of time which have the max criteria

%% First, 
% compute the criteria from the variance of time window and trials.
% formulation is "Criteria = Var(window) - Var(trial)"
% Second,
% find the index of time which have the positive criteria
num_fingers = 4;

for i = 1:num_fingers
    VAR.F(i).PPS.PPS_criteria = VAR.F(i).PPS.PPS_mean_each_var_time - VAR.F(i).PPS.PPS_var_trial_nor;
    VAR.F(i).PPS.PPS_criteria_index = find(VAR.F(i).PPS.PPS_criteria > th_normal);
    VAR.F(i).PPS.PPS_criteria_index = intersect(VAR.F(i).PPS.PPS_var_trial_index, VAR.F(i).PPS.PPS_criteria_index);
end

for d=1:4
    for o=1:num_obj
        VAR.object(o).dim(d).cart_criteria = VAR.object(o).dim(d).cart_mean_each_var_time_nor-VAR.object(o).dim(d).cart_var_trial_nor;
        VAR.object(o).dim(d).SF_criteria = VAR.object(o).dim(d).SF_mean_each_var_time_nor-VAR.object(o).dim(d).SF_var_trial_nor;
        VAR.object(o).dim(d).ST_criteria = VAR.object(o).dim(d).ST_mean_each_var_time_nor-VAR.object(o).dim(d).ST_var_trial_nor;
        VAR.object(o).dim(d).SV_criteria = VAR.object(o).dim(d).SV_mean_each_var_time_nor-VAR.object(o).dim(d).SV_var_trial_nor;

        VAR.object(o).dim(d).cart_criteria_index = find( VAR.object(o).dim(d).cart_criteria>th_normal);
        VAR.object(o).dim(d).SF_criteria_index = find( VAR.object(o).dim(d).SF_criteria>th_normal);
        VAR.object(o).dim(d).ST_criteria_index = find( VAR.object(o).dim(d).ST_criteria>th_normal);
        VAR.object(o).dim(d).SV_criteria_index = find( VAR.object(o).dim(d).SV_criteria>th_normal);

        VAR.object(o).dim(d).cart_criteria_index = intersect(VAR.object(o).dim(d).cart_var_trial_index, VAR.object(o).dim(d).cart_criteria_index);
        VAR.object(o).dim(d).SF_criteria_index = intersect(VAR.object(o).dim(d).SF_var_trial_index, VAR.object(o).dim(d).SF_criteria_index);
        VAR.object(o).dim(d).ST_criteria_index = intersect(VAR.object(o).dim(d).ST_var_trial_index, VAR.object(o).dim(d).ST_criteria_index);
        VAR.object(o).dim(d).SV_criteria_index = intersect(VAR.object(o).dim(d).SV_var_trial_index, VAR.object(o).dim(d).SV_criteria_index);
    end
end


%% Third,
% find the index of time which have the max criteria
for d=1:4
    tmp = [];
    for o=1:num_obj
        tmp = [tmp; VAR.object(o).dim(d).cart_criteria; VAR.object(o).dim(d).SF_criteria; VAR.object(o).dim(d).ST_criteria; VAR.object(o).dim(d).SV_criteria];
    end
    [ttt tmp_index] =max(tmp,[],1);
    for o=1:num_obj
        VAR.object(o).dim(d).max_cart_criteria_index = find(tmp_index==2*(o-1)+1);
        VAR.object(o).dim(d).max_SF_criteria_index = find(tmp_index==2*(o-1)+2);
        VAR.object(o).dim(d).max_ST_criteria_index = find(tmp_index==2*(o-1)+3);
        VAR.object(o).dim(d).max_SV_criteria_index = find(tmp_index==2*(o-1)+4);
    end
end
for d=1:4
    for o=1:num_obj
        VAR.object(o).dim(d).max_cart_criteria_index = intersect(VAR.object(o).dim(d).cart_criteria_index, VAR.object(o).dim(d).max_cart_criteria_index);
        VAR.object(o).dim(d).max_SF_criteria_index = intersect(VAR.object(o).dim(d).SF_criteria_index, VAR.object(o).dim(d).max_SF_criteria_index);
        VAR.object(o).dim(d).max_ST_criteria_index = intersect(VAR.object(o).dim(d).ST_criteria_index, VAR.object(o).dim(d).max_ST_criteria_index);
        VAR.object(o).dim(d).max_SV_criteria_index = intersect(VAR.object(o).dim(d).SV_criteria_index, VAR.object(o).dim(d).max_SV_criteria_index);
    end
end


%% just for plotting

%For cartesian
for d=1:4
    for o=1:num_obj
        if size(VAR.object(o).dim(d).max_cart_criteria_index,2)>0
            count = 1;
            VAR.object(o).dim(d).max_cart_criteria_segment_start_point(count)=1;
            
            for n=2:size(VAR.object(o).dim(d).max_cart_criteria_index,2)
                if VAR.object(o).dim(d).max_cart_criteria_index(n-1)+1 ~= VAR.object(o).dim(d).max_cart_criteria_index(n)
                    count = count +1;
                    VAR.object(o).dim(d).max_cart_criteria_segment_start_point(count)=n;
                end
            end
        else
            count = 0;
            VAR.object(o).dim(d).max_cart_criteria_segment_start_point=[];
        end
        
    end
end

%For forces
for d=1:4
    for o=1:num_obj
        if size(VAR.object(o).dim(d).max_SF_criteria_index,2)>0
            count = 1;
            VAR.object(o).dim(d).max_SF_criteria_segment_start_point(count)=1;
            
            for n=2:size(VAR.object(o).dim(d).max_SF_criteria_index,2)
                if VAR.object(o).dim(d).max_SF_criteria_index(n-1)+1 ~= VAR.object(o).dim(d).max_SF_criteria_index(n)
                    count = count +1;
                    VAR.object(o).dim(d).max_SF_criteria_segment_start_point(count)=n;
                end
            end
        else
            count = 0;
            VAR.object(o).dim(d).max_SF_criteria_segment_start_point=[];
        end
        
    end
end

%For torques
for d=1:4
    for o=1:num_obj
        if size(VAR.object(o).dim(d).max_ST_criteria_index,2)>0
            count = 1;
            VAR.object(o).dim(d).max_ST_criteria_segment_start_point(count)=1;
            
            for n=2:size(VAR.object(o).dim(d).max_ST_criteria_index,2)
                if VAR.object(o).dim(d).max_ST_criteria_index(n-1)+1 ~= VAR.object(o).dim(d).max_ST_criteria_index(n)
                    count = count +1;
                    VAR.object(o).dim(d).max_SF_criteria_segment_start_point(count)=n;
                end
            end
        else
            count = 0;
            VAR.object(o).dim(d).max_ST_criteria_segment_start_point=[];
        end
        
    end
end

% fOR VELOCITY
for d=1:4
    for o=1:num_obj
        if size(VAR.object(o).dim(d).max_SV_criteria_index,2)>0
            count = 1;
            VAR.object(o).dim(d).max_SV_criteria_segment_start_point(count)=1;
            
            for n=2:size(VAR.object(o).dim(d).max_SV_criteria_index,2)
                if VAR.object(o).dim(d).max_SV_criteria_index(n-1)+1 ~= VAR.object(o).dim(d).max_SV_criteria_index(n)
                    count = count +1;
                    VAR.object(o).dim(d).max_SV_criteria_segment_start_point(count)=n;
                end
            end
        else
            count = 0;
            VAR.object(o).dim(d).max_SV_criteria_segment_start_point=[];
        end
        
    end
end

end

