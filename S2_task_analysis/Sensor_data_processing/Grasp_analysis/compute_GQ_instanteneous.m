function [gquality] = compute_GQ_instanteneous(glove, tactilePressure, rpos, wpos)


%close all; 
figure; clear h;
subject_name = 'ravin'; thumb_model = 'rpij'; visualization = 'importancebar'; setupHand;

%h.refresh(0,1); grid on; axis equal; %view(-48,20);

%load('gloveRaw');
jointAngles = zeros(size(glove));
for i=1:size(glove,1)
     jointAngles(i,:) = getCalibratedHandAngles(glove(i,:), h.calibration.calib_file, h.calibration.min_file, h.calibration.max_file);
     jointAngles(i,[3 4]) = jointAngles(i, [3 4]) + deg2rad([-10 20]);
end


% averaging across a segment.
jA = sum(jointAngles) / size(jointAngles, 1);
h.Q = jointAngles(i,:);

% update the tactile
%load('tactilePressure');
t = sum(tactilePressure,4) / size(tactilePressure,4);
tpatch = average2patch(h, t);
h.updateSensorValues(tpatch, 'average', 'importance');

h.updatePosition(inv(rpos)*wpos);
h.refresh(0,1); %pause;

% to get access to the contact points
% s = sL(1);
% s.pnts.p
% s.pnts.ndir
% s.pnts.centroid
% s.pnts.bounds


% to estimate a grasp wrench space quality
h.iterateSensors(@importanceRelevanceFilter, 0.09);
h.refresh(0,1); %pause;

sL = [h.sensors{:}];
sL = sL(logical([sL.relevant]));

% wXto is the RF computed in the center of the grasp 
% wXto is in the world RF
% to add the wrist pose: h.updatePosition
wXto = zeros(4,4); 
for i=1:length(sL)
    wXto = wXto + sL(i).pts.xform * sL(i).importance;    
end
wXto = wXto / sum(vertcat(sL.importance));
plotAxes(wXto, 5, 1);
%pause;

% Specify a direction for computing the grasp quality
% see tc(1) for the normalized quality across the direction above
gquality = zeros(1,6);

% Across the X direction
dir.F = [1 0 0]';
dir.T = [1 0 0]';
tc = handCompatibility(sL, dir, wXto);
% gquality = [gquality cell2mat(tc{1,1})];

gquality(1) = cell2mat(tc{1});
gquality(4) = cell2mat(tc{2});
% Across the Y direction
dir.F = [0 1 0]';
dir.T = [0 1 0]';
tc = handCompatibility(sL, dir, wXto);
% gquality = [gquality cell2mat(tc{1,1})];
gquality(2) = cell2mat(tc{1});
gquality(5) = cell2mat(tc{2});

% Across the Z direction
dir.F = [0 0 1]';
dir.T = [0 0 1]';
tc = handCompatibility(sL, dir, wXto);
% gquality = [gquality cell2mat(tc{1,1})];
gquality(3) = cell2mat(tc{1});
gquality(6) = cell2mat(tc{2});

disp(gquality);


end

