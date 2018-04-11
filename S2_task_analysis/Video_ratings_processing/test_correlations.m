


load('video_rating.mat');

for i = 1:size(video_metrics_per_dem, 2)
    for j = 1:size(video_metrics_per_dem, 2)
        cor_vr(i,j) = corr(video_metrics_per_dem(:,i), video_metrics_per_dem(:,j));
        if (cor_vr(i,j)>0.2 && i~=j)
            disp(i); disp(j);
        end
    end
end