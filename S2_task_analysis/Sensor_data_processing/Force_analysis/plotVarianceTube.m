function [ ] = plotVarianceTube(data)
%PLOTVARIANCETUBE Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(data, 2)
    varData(i)  = var(data(:,i));
    meanData(i) = mean(data(:,i));
end

% meanData(isnan(meanData))=0;
% varData(isnan(varData))=0;
% meanData(~isfinite(meanData))=0;
% varData(~isfinite(varData))=0;

Sigma(1,1,:) = varData;
nbData = size(data,2);
%lightcolor = [0.87 0.92 0.98];
lightcolor = [0.8 0.88 0.97];

for j=1:nbData  
    ymax(j) = meanData(j) + sqrtm(3.*Sigma(1,1,j));
    ymin(j) = meanData(j) - sqrtm(3.*Sigma(1,1,j));
end
patch([[1:nbData] [nbData:-1:1]], [ymax(1:end) ymin(end:-1:1)], lightcolor, 'LineStyle', 'none');



end

