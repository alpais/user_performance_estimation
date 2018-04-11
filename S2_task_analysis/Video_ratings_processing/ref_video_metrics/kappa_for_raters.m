
load('kappa_sub.mat');
load('sid');

% Check agreement per subject for raters who have done all subjects
% case demo ordering - raters 6 and 7 - 
% case randorm ordering - raters 4 and 5

%

%% For raters who have seen the videos in order
agr_sk = zeros(length(sid),3);
agr_pace = zeros(length(sid),3);
agr_pb_coord = zeros(length(sid),3);
agr_pb_grasp = zeros(length(sid),3);
agr_pb_move = zeros(length(sid),3);
agr_ft = zeros(length(sid),3);

for i = 1:length(sid)
    disp(sid(i))
    % We take all non zero elements of rows 6 and 7 such that:
    % col 1 - agrm rater 6 and 7
    % col 2 - agrm rater 6 and the one who did a batch (8,9 or 10)
    % col 3 - agrm rater 7 and batch raters
   
    agr_sk(i,:) = [kappa_sub.sk.sid{sid(i)}(6, find(kappa_sub.sk.sid{sid(i)}(6,:)~=0)) kappa_sub.sk.sid{sid(i)}(7, find(kappa_sub.sk.sid{sid(i)}(7,:)~=0))];
    if any(kappa_sub.pace.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        agr_pace(i,:) = [kappa_sub.pace.sid{sid(i)}(6, find(kappa_sub.pace.sid{sid(i)}(6,:)~=0)) kappa_sub.pace.sid{sid(i)}(7, find(kappa_sub.pace.sid{sid(i)}(7,:)~=0))];
    end
    
    if any(kappa_sub.pb_coord.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        agr_pb_coord(i,:) = [kappa_sub.pb_coord.sid{sid(i)}(6, find(kappa_sub.pb_coord.sid{sid(i)}(6,:)~=0)) kappa_sub.pb_coord.sid{sid(i)}(7, find(kappa_sub.pb_coord.sid{sid(i)}(7,:)~=0))];
    end
    
    if any(kappa_sub.pb_grasp.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        agr_pb_grasp(i,:) = [kappa_sub.pb_coord.sid{sid(i)}(6, find(kappa_sub.pb_grasp.sid{sid(i)}(6,:)~=0)) kappa_sub.pb_grasp.sid{sid(i)}(7, find(kappa_sub.pb_grasp.sid{sid(i)}(7,:)~=0))];
    end
    
    if any(kappa_sub.pb_move.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        agr_pb_move(i,:) = [kappa_sub.pb_move.sid{sid(i)}(6, find(kappa_sub.pb_move.sid{sid(i)}(6,:)~=0)) kappa_sub.pb_move.sid{sid(i)}(7, find(kappa_sub.pb_move.sid{sid(i)}(7,:)~=0))];
    end
    
    if any(kappa_sub.vr_ft.sid{sid(i)}(6,:)) % If there are any non-zero elements than copy them 
        agr_ft(i,:) = [kappa_sub.vr_ft.sid{sid(i)}(6, find(kappa_sub.vr_ft.sid{sid(i)}(6,:)~=0)) kappa_sub.vr_ft.sid{sid(i)}(7, find(kappa_sub.vr_ft.sid{sid(i)}(7,:)~=0))];
    end
        
end




%%
%     agr_or_sk(i)  = kappa_sub.sk.sid{sid(i)}(6,7);
%     agr_ran_sk(i) = kappa_sub.sk.sid{sid(i)}(4,5);
% 
%     agr_or_pace(i)  = kappa_sub.pace.sid{sid(i)}(6,7);
%     agr_ran_pace(i) = kappa_sub.pace.sid{sid(i)}(4,5);
% 
%       
%     agr_or_pb_coord(i)  = kappa_sub.pb_coord.sid{sid(i)}(6,7);
%     agr_ran_pb_coord(i) = kappa_sub.pb_coord.sid{sid(i)}(4,5);
% 
%     agr_or_pb_grasp(i)  = kappa_sub.pb_grasp.sid{sid(i)}(6,7);
%     agr_ran_pb_grasp(i) = kappa_sub.pb_grasp.sid{sid(i)}(4,5);
% 
%     agr_or_pb_move(i)  = kappa_sub.pb_move.sid{sid(i)}(6,7);
%     agr_ran_pb_move(i) = kappa_sub.pb_move.sid{sid(i)}(4,5);
% 
%     agr_or_ft(i)  = kappa_sub.vr_ft.sid{sid(i)}(6,7);
%     agr_ran_ft(i) = kappa_sub.vr_ft.sid{sid(i)}(4,5);
% end
% 
%     disp('========= Pace =========');
%     figure; hold on; stem(sid, agr_or_pace);  stem(sid, agr_ran_pace, sid);
%     title('Pace'); legend('order', 'random');
%     length(find(agr_or_pace > 0.7))
%     length(find(agr_ran_pace > 0.7))
%     disp('========= Pb Coord =========');
%     figure; hold on; stem(agr_or_pb_coord);  stem(agr_ran_pb_coord);
%     title('Pb Coord'); legend('order', 'random');
%     length(find(agr_or_pb_coord > 0.7))
%     length(find(agr_ran_pb_coord > 0.7))
%     disp('========= Pb Grasp =========');
%     figure; hold on; stem(agr_or_pb_grasp);  stem(agr_ran_pb_grasp);
%     title('Pb Grasp'); legend('order', 'random');
%     length(find(agr_or_pb_grasp > 0.7))
%     length(find(agr_ran_pb_grasp > 0.7))
%     disp('========= Pb Move =========');
%     figure; hold on; stem(agr_or_pb_move);  stem(agr_ran_pb_move);
%     title('Pb Move'); legend('order', 'random');
%     length(find(agr_or_pb_move > 0.7))
%     length(find(agr_ran_pb_move > 0.7))
%     disp('========= VR FT =========');
%     figure; hold on; stem(agr_or_ft);  stem(agr_ran_ft);
%     title('VR_FT'); legend('order', 'random');
%     length(find(agr_or_ft > 0.7))
%     length(find(agr_ran_ft > 0.7))
