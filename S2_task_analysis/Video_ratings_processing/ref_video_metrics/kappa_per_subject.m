


%% Compute kappa agreement rate for each user globally - this concerns the 
% questions that the raters who have seen the movies in order had to answer 
% at the end

urating = load('../../../video_data/users.txt');
% File structure:
% col 1 - subject no
% col 2 - rater no
% col 3 - overall performance (1 - 5)
% col 4 - improved over trials (yes/no)
% col 5 - was in control (yes/no)


% sort by rater 3 raters x 37 total subjects

urating = sortrows(urating, 2);

r1 = urating( 1:37, :);
r2 = urating(38:74, :);
r3 = urating(75:end, :);

% kappa for skill
col = 3;
% sa =  1; se = 37; % all
%  sa =  1; se = 11; % batch 1
% sa = 12; se = 24; % batch 2
% sa = 25; se = 37; % batch 3

% ============
sk_b1 = [6 8 9]; % index of skilled users as automatically rated from batch 1
nsk_b1 = [1:5 7 10 11];

sk_b2 = [15 19 24];
nsk_b2 = [12 13 14 16 17 18 20:23];

sk_b3 = [29 30 37];
nsk_b3 = [25:28 31:36];

sk_all = [sk_b1 sk_b2 sk_b3];
nsk_all = [nsk_b1 nsk_b2 nsk_b3];

% Kappa r1 x r2
% ch = crosstab(r1(sa:se,col), r2(sa:se,col));
ch = crosstab(r1(sk_b2,col), r2(sk_b2,col));
[nb_rows, nb_cols] = size(ch);
r1r2 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;

% Kappa r1 x r3 - where r3 is either 8, 9 or 10 as they did the batches and
% not the full sequence
% ch = crosstab(r1(sa:se,col), r3(sa:se,col));
ch = crosstab(r1(sk_b2,col), r3(sk_b2,col));
[nb_rows, nb_cols] = size(ch);
r1r3 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols))); 
clear ch;

% Kappa r2 x r3 - where r3 is either 8, 9 or 10 as they did the batches and
% not the full sequence
% ch = crosstab(r2(sa:se,col), r3(sa:se,col));
ch = crosstab(r2(sk_b2,col), r3(sk_b2,col));
[nb_rows, nb_cols] = size(ch);
r2r3 = kappa(ch(1:min(nb_rows, nb_cols), 1:min(nb_rows, nb_cols)));
clear ch;

disp(sprintf('Col: %d, from subj %d to subj %d, agrm: %.3f \t %.3f \t %.3f \n', col, sa, se, r1r2, r1r3, r2r3));

%% Compare skill by each rater

sk_by_rater = [r1(:,3) r2(:,3) r3(:,3)];
figure; hold on; stem(sk_by_rater(:,1), '*'); stem(sk_by_rater(:,2), '*'); stem(sk_by_rater(:,3), '*');
xticks = 1:37;
xticklabels = 1:37;




