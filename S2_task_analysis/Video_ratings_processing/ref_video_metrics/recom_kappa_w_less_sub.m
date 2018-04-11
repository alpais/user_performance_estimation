% remove subjects for which the agreement is low or values have not been
% provided for pace

snew = [7;8;9;10;11;13;18;20;22;24;25;27;28;30;32;33;34;36;38;39;40;44;45;46;47;48;49;50;51;52];

idx_abs = [1,2,3,4,5,6,8,10,12,13,14,15,16,17,19,20,21,23,25,26,27,29,30,31,32,33,34,35,36,37];

agr_sk_ref(:,:) = agr_sk(idx_abs, :);
mean(mean(agr_sk_ref,2))

agr_pace_ref(:,:) = agr_pace(idx_abs, :);
mean(mean(agr_pace_ref,2))

agr_ft_ref(:,:) = agr_ft(idx_abs, :);
mean(mean(agr_ft_ref,2))
