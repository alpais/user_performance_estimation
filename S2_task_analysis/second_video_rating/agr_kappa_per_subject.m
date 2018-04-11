urating = load('users.txt');
% File structure:
% col 1 - subject no
% col 2 - rater no
% col 3 - overall performance (1 - 5)
% col 4 - improved over trials (yes/no)
% col 5 - manage setup well (yes/no)
% col 6 - pb: 1 - arm coord; 2 - tool grasp; 3 - direction of mov; 4 - none

%%
% sort by rater id >> 2 raters x 37 total subjects
urating = sortrows(urating, 2);

% Discretize the skill column
for i = 1:size(urating, 1)
    if urating(i,3) <= 2
        urating(i,3) = 0;
    else
        urating(i,3) = 1;
    end
end

% Separate the ratings of the two raters
r1 = urating( 1:37, :);
r2 = urating(38:74, :);

%%
col = 3; % Column for which to compute the agreement rate 3, 4 or 5

ch = crosstab(r1(:,col), r2(:,col));
[nb_rows, nb_cols] = size(ch);
r1r2 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;


%% Especially for column 6 isolate the problems

r1_coord = r1(:,6); r1_coord(r1_coord ~= 1) = 0; %check only for arm coordination problems
r1_grasp = r1(:,6); r1_grasp(r1_grasp ~= 2) = 0;
r1_dir   = r1(:,6); r1_dir(r1_dir ~= 3) = 0;
r1_none = r1(:,6);  r1_none(r1_none ~= 4) = 0;

r2_coord = r2(:,6); r2_coord(r2_coord ~= 1) = 0; %check only for arm coordination problems
r2_grasp = r2(:,6); r2_grasp(r2_grasp ~= 2) = 0;
r2_dir   = r2(:,6); r2_dir(r2_dir ~= 3) = 0;
r2_none = r2(:,6);  r2_none(r2_none ~= 4) = 0;

ch = crosstab(r1_none, r2_none);
[nb_rows, nb_cols] = size(ch);
r1r2 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;


%% Check agreement when relating these to the skilled vs unskilled automatical rating

sk_all = [6 8 9 15 19 24 29 30 37]; 
nsk_all = [1:5 7 10 11 12 13 14 16 17 18 20:23 25:28 31:36];

col = 3; 
ch = crosstab(r1(nsk_all,col), r2(nsk_all,col));
[nb_rows, nb_cols] = size(ch);
r1r2 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;

