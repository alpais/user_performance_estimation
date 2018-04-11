trating = load('trials.txt');
% File structure:
% col 1 - subject no
% col 2 - trial no
% col 3 - rater no
% col 4 - scooped amount (1 - too little / 2 - normal / 3 - too much)
% col 5 - task performed with ease (yes / no)
% col 6 - task pace (1 - too slow / 2 - normal / 3 - too fast) 
% col 7 - force applied (1 - too little / 2 - normal / 3 - too much)

%%
% sort by rater id >> 2 raters x 37 total subjects
trating = sortrows(trating, 3);

% Discretize the skill column
% for i = 1:size(urating, 1)
%     if urating(i,3) <= 2
%         urating(i,3) = 0;
%     else
%         urating(i,3) = 1;
%     end
% end

% Separate the ratings of the two raters
r1 = trating( 1:537, :);
r2 = trating(538:1074, :);

%%
col = 7; % Column for which to compute the agreement rate

ch = crosstab(r1(:,col), r2(:,col));
[nb_rows, nb_cols] = size(ch);
r1r2 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;



