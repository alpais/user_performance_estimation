function [  ] = detMaxCrit_ScoopingTask( Crit )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(Crit,1) 
    CmaxX(i) = find(Crit.X(i,:) == max(Crit.X(i,:))); 
end

pos_idx = find(CmaxX == 1);
for_idx = find(CmaxX == 2);
tqs_idx = find(CmaxX == 3);

figure; hold on; 

for i = 1:length(pos_idx)-1 tmp(i) = pos_idx(i+1) - pos_idx(i); end
segx = find(tmp ~= 1);
segx = [1 segx]

for i = 1:length(segx)-1
    p_start = segx(i);
    p_end = segx(i+1);
    px = [p_start p_start p_end p_end];
    py = [0 1 1 0];
    patch(px, py,'b');
%     
%     if (pos_idx(i+1) - pos_idx(i) ~=1)
%         p_end = i;
%         px = [p_start p_start p_end p_end];
%         py = [0 1 1 0];
%         patch(px, py,'b');
%         p_start = i+1;
%     end
end

end

