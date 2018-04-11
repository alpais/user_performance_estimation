


%% Video rating per demonstration

% ---------  Current format

% Subject_ID, Demo_Nb, Rater_ID
% Performance               : 1 to 5
% Task Pace                 : 1 - too slow; 2 - normal; 3 - too fast
% Arm coordination          : 0 - OK; 1 - NOK (1 means it was checked as problem)
% Tool Grasp                : 0 - OK; 1 - NOK
% Direction of movement     : 0 - OK; 1 - NOK
% Force                     : 1 - too little; 2 - too much
% ------------------------------------------------------------------------

% Raters
% -------- Random subject, random demo ordering --------
% Alexandra 	- all subjects      - random order
% Cristina      - all subjects      - random order
% Nadia         - batch 1           - random order
% Mina          - batch 2           - random order
% Kevin         - batch 3           - random order
% -------- Per subject, Per demo ordering -------------
% Dinesh		- all subjects      - user ordering
% Samuel		- all subjects      - user ordering
% Jose          - batch 1           - user ordering
% Ilaria		- batch 2           - user ordering
% Brice         - batch 3           - user ordering

% -----------------------------------------------------
% Rater IDs - from the python script
%   raters = {'test'    : 0,
%             'test2'   : 0,
%             'lucia'   : 0,
%             'nadia'   : 1,
%             'mina'    : 2,
%             'kevin'   : 3,
%             'alex'    : 4,
%             'cristina': 5,
%             'dinesh'  : 6,
%             'samuel'  : 7,
%             'jose'    : 8,
%             'ilaria'  : 9,
%             'brice'   : 10}
% -----------------------------------------------------


trials = load('../../video_data/trials.txt');


% Remove rater 0 - just testing
zero_idx = find(trials(:,3)==0);

for i = length(zero_idx):-1:1
    trials(zero_idx(i),:) = [];
end

% insert rating case - random / trial
for i = 1:size(trials, 1)
    if trials(i,3)<=5
        rating_case(i,1) = 1; % random order
    else
        rating_case(i,1) = 2; % trials order
    end
end

% Concatenate
video_metrics_per_dem = [trials(:,1:3) rating_case trials(:,4:end)]; 

% save as csv
headers = {'Subject_ID', 'Demo_Nb', 'Rater_ID', 'Rating_Case', 'Skill', 'Task_Pace', 'Pb_Coord', 'Pb_Grasp', 'Pb_Movement', 'Applied_Force'};

csvwrite_with_headers('video_metrics_per_dem2.csv', video_metrics_per_dem, headers);
save('video_rating.mat', 'video_metrics_per_dem','-mat');

%% Sort by rating case

random_rating_stats = []; order_rating_stats = [];

for i = 1:size(video_metrics_per_dem,1)
    if video_metrics_per_dem(i,4) == 1
        random_rating_stats = [random_rating_stats; video_metrics_per_dem(i,:)];
    else
        order_rating_stats = [order_rating_stats; video_metrics_per_dem(i,:)];
    end
end

%% PROBLEMS vs FORCE and Pace

[good_coordination, bad_coordination]   = get_sorted_stats(video_metrics_per_dem, 7, [0 1]);
[good_grasp, bad_grasp]                 = get_sorted_stats(video_metrics_per_dem, 8, [0 1]);
[good_move, bad_move]                   = get_sorted_stats(video_metrics_per_dem, 9, [0 1]);
 
% mean of applied force
col = 10;
avg_sk_coord = [mean(good_coordination(:,col))    mean(bad_coordination(:,col))];   std_sk_coord = [std(good_coordination(:,col)) std(bad_coordination(:,col))];
avg_sk_grasp = [mean(good_grasp(:,col))           mean(bad_grasp(:,col))];          std_sk_grasp = [std(good_grasp(:,col))        std(bad_grasp(:,col))];
avg_sk_move  = [mean(good_move(:,col))            mean(bad_move(:,col))];           std_sk_move  = [std(good_move(:,col))         std(bad_move(:,col))];

avg_sk_pb = [avg_sk_coord; avg_sk_grasp; avg_sk_move]';
std_sk_pb = [std_sk_coord; std_sk_grasp; std_sk_move]';

sticklabels = {'No-Problem','Problem'};
slegend = {'Coordination', 'Grasping', 'Movement'};

plot_grouped_plot(avg_sk_pb, std_sk_pb, sticklabels, slegend);
format_grouped_plot('Applied Force','Skill (video rating)', [1 3]);

savefig('VR_Force_vs_Problems.fig');
saveas(gcf, 'VR_Force_vs_Problems.png');
saveas(gcf, 'VR_Force_vs_Problems.eps')

avgs{1} = avg_sk_coord; avgs{2} = avg_sk_grasp; avgs{3} = avg_sk_move;
stds{1} = std_sk_coord; stds{2} = std_sk_grasp; stds{3} = std_sk_move;

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim([1 3]); ylabel('Force'); xlabel('Skill (video rating)');


%% PROBLEMS vs PACE

[good_coordination, bad_coordination]   = get_sorted_stats(video_metrics_per_dem, 7, [0 1]);
[good_grasp, bad_grasp]                 = get_sorted_stats(video_metrics_per_dem, 8, [0 1]);
[good_move, bad_move]                   = get_sorted_stats(video_metrics_per_dem, 9, [0 1]);
 
% mean of applied pace
col = 6;
avg_sk_coord = [mean(good_coordination(:,col))    mean(bad_coordination(:,col))];   std_sk_coord = [std(good_coordination(:,col)) std(bad_coordination(:,col))];
avg_sk_grasp = [mean(good_grasp(:,col))           mean(bad_grasp(:,col))];          std_sk_grasp = [std(good_grasp(:,col))        std(bad_grasp(:,col))];
avg_sk_move  = [mean(good_move(:,col))            mean(bad_move(:,col))];           std_sk_move  = [std(good_move(:,col))         std(bad_move(:,col))];

avg_sk_pb = [avg_sk_coord; avg_sk_grasp; avg_sk_move]';
std_sk_pb = [std_sk_coord; std_sk_grasp; std_sk_move]';

sticklabels = {'No-Problem','Problem'};
slegend = {'Coordination', 'Grasping', 'Movement'};

plot_grouped_plot(avg_sk_pb, std_sk_pb, sticklabels, slegend);
format_grouped_plot('Task Pace Rating','Identified Problems', [1 3]);

savefig('VR_Pace_vs_Problems.fig');
save('VR_Pace_vs_Problems.png');
saveas(gcf, 'VR_Pace_vs_Problems.eps')

avgs{1} = avg_sk_coord; avgs{2} = avg_sk_grasp; avgs{3} = avg_sk_move;
stds{1} = std_sk_coord; stds{2} = std_sk_grasp; stds{3} = std_sk_move;

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim([1 3]); ylabel('Task Pace Rating'); xlabel('Identified Problems');

%% PROBLEMS vs SKILL

[good_coordination, bad_coordination]   = get_sorted_stats(video_metrics_per_dem, 7, [0 1]);
[good_grasp, bad_grasp]                 = get_sorted_stats(video_metrics_per_dem, 8, [0 1]);
[good_move, bad_move]                   = get_sorted_stats(video_metrics_per_dem, 9, [0 1]);
 
% mean of rated skill 
col = 5;
avg_sk_coord = [mean(good_coordination(:,col))    mean(bad_coordination(:,col))];   std_sk_coord = [std(good_coordination(:,col)) std(bad_coordination(:,col))];
avg_sk_grasp = [mean(good_grasp(:,col))           mean(bad_grasp(:,col))];          std_sk_grasp = [std(good_grasp(:,col))        std(bad_grasp(:,col))];
avg_sk_move  = [mean(good_move(:,col))            mean(bad_move(:,col))];           std_sk_move  = [std(good_move(:,col))         std(bad_move(:,col))];

avg_sk_pb = [avg_sk_coord; avg_sk_grasp; avg_sk_move]';
std_sk_pb = [std_sk_coord; std_sk_grasp; std_sk_move]';

sticklabels = {'No-Problem','Problem'};
slegend = {'Coordination', 'Grasping', 'Movement'};

plot_grouped_plot(avg_sk_pb, std_sk_pb, sticklabels, slegend);
format_grouped_plot('Skill Rating','Identified Problems', [1 3]);

savefig('VR_Skill_vs_Problems.fig');
saveas(gcf, 'VR_Skill_vs_Problems.png');
saveas(gcf, 'VR_skill_vs_Problems.eps')

avgs{1} = avg_sk_coord; avgs{2} = avg_sk_grasp; avgs{3} = avg_sk_move;
stds{1} = std_sk_coord; stds{2} = std_sk_grasp; stds{3} = std_sk_move;

plot_with_error_bar(avgs, stds, slegend, sticklabels);
ylim([1 3]); ylabel('Skill Rating'); xlabel('Identified Problems');


%% SKILL LEVELS vs Problems

[skl_coord, avg_skl_coord, std_skl_coord]   = sort_by_skill(video_metrics_per_dem, 7);
[skl_grasp, avg_skl_grasp, std_skl_grasp]   = sort_by_skill(video_metrics_per_dem, 8);
[skl_move, avg_skl_move, std_skl_move]      = sort_by_skill(video_metrics_per_dem, 9);

avgs{1} = avg_skl_coord; avgs{2} = avg_skl_grasp; avgs{3} = avg_skl_move;
stds{1} = std_skl_coord; stds{2} = std_skl_grasp; stds{3} = std_skl_move;

slegend = {'Coordination','Grasp', 'Movement'};
sticklabels = {'very low', 'low', 'medium', 'high', 'very high'};

% -----------------------
plot_with_error_bar(avgs, stds, slegend, sTickLabels);
ylim([0 1]); ylabel('Problems'); xlabel('Skill (video rating)');

savefig('VR_Skill_vs_Problems_lines.fig');
save('VR_Skill_vs_Problems_lines.png');
% -----------------------
avg_sk = [avg_skl_coord; avg_skl_grasp; avg_skl_move]';
std_sk = [std_skl_coord; std_skl_grasp; std_skl_move]';

plot_grouped_plot(avg_sk, std_sk, sticklabels, slegend);
format_grouped_plot('Problems','Skill (video rating)', [0 1]);

savefig('VR_Skill_vs_Problems_bars.fig');
save('VR_Skill_vs_Problems_bars.png');

%% SKIL LEVEL vs FORCE and PACE

[skl_force, avg_skl_force, std_skl_force]   = sort_by_skill(video_metrics_per_dem, 10);
[skl_pace, avg_skl_pace, std_skl_pace]   = sort_by_skill(video_metrics_per_dem, 6);

avgs{1} = avg_skl_force; avgs{2} = avg_skl_pace; 
stds{1} = std_skl_force; stds{2} = std_skl_pace; 

slegend = {'Force','Pace'};
sticklabels = {'very low', 'low', 'medium', 'high', 'very high'};
plot_with_error_bar(avgs, stds, slegend, sTickLabels);

avg_sk = [avg_skl_force; avg_skl_pace]';
std_sk = [std_skl_force; std_skl_pace]';

plot_grouped_plot(avg_sk, std_sk, sticklabels, slegend);
format_grouped_plot('Other','Skill (video rating)', [1 3]);


%% Sort by problems seen in demo

[good_coordination, bad_coordination]   = get_sorted_stats(video_metrics_per_dem, 7, [0 1]);
[good_grasp, bad_grasp]                 = get_sorted_stats(video_metrics_per_dem, 8, [0 1]);
[good_move, bad_move]                   = get_sorted_stats(video_metrics_per_dem, 9, [0 1]);
 
avg_sk_coord = [mean(good_coordination(:,5))    mean(bad_coordination(:,5))];   std_sk_coord = [std(good_coordination(:,5)) std(bad_coordination(:,5))];
avg_sk_grasp = [mean(good_grasp(:,5))           mean(bad_grasp(:,5))];          std_sk_grasp = [std(good_grasp(:,5))        std(bad_grasp(:,5))];
avg_sk_move  = [mean(good_move(:,5))            mean(bad_move(:,5))];           std_sk_move  = [std(good_move(:,5))         std(bad_move(:,5))];

avg_sk_pb = [avg_sk_coord; avg_sk_grasp; avg_sk_move];
std_sk_pb = [std_sk_coord; std_sk_grasp; std_sk_move];

sticklabels = {'Coordination', 'Grasping', 'Movement'};
slegend = {'Skilled','Unskilled'};

plot_grouped_plot(avg_sk_pb, std_sk_pb, sticklabels, slegend);
format_grouped_plot('Skill (video rating)');

savefig('VR_Skill_vs_Problems.fig');
save('VR_Skill_vs_Problems.png');

%% Sort by pace and force

[pace_slow, pace_normal, pace_fast]   = get_sorted_stats_3cases(video_metrics_per_dem, 6, [1 2 3]);
[force_low, force_normal, force_high]   = get_sorted_stats_3cases(video_metrics_per_dem, 10, [1 2 3]);

%[sk_slow, avg_sk_slow, std_sk_slow] = sort_by_skill(pace_slow, 6);

avg_sk_pace = [mean(pace_slow(:,5)) mean(pace_normal(:,5)) mean(pace_fast(:,5))];
std_sk_pace = [std(pace_slow(:,5)) std(pace_normal(:,5)) std(pace_fast(:,5))];

avg_sk_force = [mean(force_low(:,5)) mean(force_normal(:,5)) mean(force_high(:,5))];
std_sk_force = [std(force_low(:,5)) std(force_normal(:,5)) std(force_high(:,5))];

avg_sk_other = [avg_sk_pace; avg_sk_force];
std_sk_other = [std_sk_pace; std_sk_force];

sticklabels = {'Slow/Low', 'Normal', 'Fast/High'};
slegend = {'Pace','Force'};

plot_grouped_plot(avg_sk_pb', std_sk_pb', slegend, sticklabels);
format_grouped_plot('other features (video rating)');

%% SAU CU ERRORBAR
figure; hold on;

plot(avg_sk_pace, 'r*--', 'LineWidth', 3); 
plot(avg_sk_force, 'g*--', 'LineWidth', 3); 

hl = legend('Pace','Force');

set(hl, 'Interpreter', 'Latex');
set(hl, 'Orientation', 'Horizontal');
set(hl, 'EdgeColor', [1 1 1]);
set(hl, 'Location', 'southoutside');

errorbar(1:3, avg_sk_pace, std_sk_pace,  '-s','MarkerSize', 20, 'MarkerEdgeColor','red','MarkerFaceColor','red');
errorbar(1:3, avg_sk_force, std_sk_force,  '-s','MarkerSize', 20, 'MarkerEdgeColor','green','MarkerFaceColor','green');

grid on; box on;

set(gca, 'XTick', [1 2 3]);
set(gca, 'XTickLabels', {'Low', 'Normal', 'High'});
set(gcf, 'Color', [1 1 1]);

set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);

set(findall(gcf,'type','text'), 'FontSize', 32);
set(findall(gcf,'type','axes'), 'FontSize', 32);

set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);

