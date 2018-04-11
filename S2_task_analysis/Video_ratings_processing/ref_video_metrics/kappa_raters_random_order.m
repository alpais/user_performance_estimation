
%% case randorm ordering - raters 4 and 5

randord_agr_sk = zeros(length(sid),3);
randord_agr_pace = zeros(length(sid),3);
randord_agr_pb_coord = zeros(length(sid),3);
randord_agr_pb_grasp = zeros(length(sid),3);
randord_agr_pb_move = zeros(length(sid),3);
randord_agr_ft = zeros(length(sid),3);

for i = 1:length(sid)
    disp(sid(i))
    % We take all non zero elements of rows 4 and 5 such that:
    % col 1 - agrm rater 4 and 5
    % col 2 - agrm rater 4 and the one who did a batch (1,2 or 3)
    % col 3 - agrm rater 5 and batch raters
   
    if any(kappa_sub.sk.sid{sid(i)}(4,:))
        randord_agr_sk(i,:) = [kappa_sub.sk.sid{sid(i)}(4, find(kappa_sub.sk.sid{sid(i)}(4,:)~=0)) kappa_sub.sk.sid{sid(i)}(5, find(kappa_sub.sk.sid{sid(i)}(5,:)~=0))];
    end
    if any(kappa_sub.pace.sid{sid(i)}(4,:)) % If there are any non-zero elements than copy them 
        randord_agr_pace(i,:) = [kappa_sub.pace.sid{sid(i)}(4, find(kappa_sub.pace.sid{sid(i)}(4,:)~=0)) kappa_sub.pace.sid{sid(i)}(5, find(kappa_sub.pace.sid{sid(i)}(5,:)~=0))];
    end
    
    if any(kappa_sub.pb_coord.sid{sid(i)}(4,:)) % If there are any non-zero elements than copy them 
        randord_agr_pb_coord(i,:) = [kappa_sub.pb_coord.sid{sid(i)}(4, find(kappa_sub.pb_coord.sid{sid(i)}(4,:)~=0)) kappa_sub.pb_coord.sid{sid(i)}(5, find(kappa_sub.pb_coord.sid{sid(i)}(5,:)~=0))];
    end
    
    if any(kappa_sub.pb_grasp.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        randord_agr_pb_grasp(i,:) = [kappa_sub.pb_coord.sid{sid(i)}(4, find(kappa_sub.pb_grasp.sid{sid(i)}(4,:)~=0)) kappa_sub.pb_grasp.sid{sid(i)}(5, find(kappa_sub.pb_grasp.sid{sid(i)}(5,:)~=0))];
    end
    
    if any(kappa_sub.pb_move.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
       randord_agr_pb_move(i,:) = [kappa_sub.pb_move.sid{sid(i)}(4, find(kappa_sub.pb_move.sid{sid(i)}(4,:)~=0)) kappa_sub.pb_move.sid{sid(i)}(5, find(kappa_sub.pb_move.sid{sid(i)}(5,:)~=0))];
    end
    
    if any(kappa_sub.vr_ft.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
       randord_agr_ft(i,:) = [kappa_sub.vr_ft.sid{sid(i)}(4, find(kappa_sub.vr_ft.sid{sid(i)}(4,:)~=0)) kappa_sub.vr_ft.sid{sid(i)}(5, find(kappa_sub.vr_ft.sid{sid(i)}(5,:)~=0))];
    end
        
end