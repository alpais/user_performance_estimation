function [  ] = plot_grouped_plot(avg_values, std_values, sticklabels, slegend )
%PLOT_GROUPED_PLOT Summary of this function goes here
%   Detailed explanation goes here

% sticklabels = {'Index','Middle','Ring','Pinky','Thumb'};
% slegend = {'Joint 1','Joint 2','Joint 3','Joint 4'};

% Formating
figure; hold on; 
set(gcf, 'Color', [1 1 1]); 
%set(gcf, 'Position', [1681 -109 1920 1083]);
set(gcf, 'Position', [206 195 1259 696]);
colormap summer;
h = bar(avg_values);
set(h,'BarWidth',1,'LineWidth',1.5);    % The bars will now touch each other
set(gca,'YGrid','on');
set(gca,'GridLineStyle','-');
set(gca, 'XTick', 1:size(avg_values,1));
set(gca,'XTicklabel', sticklabels);
set(get(gca,'YLabel'),'String','')
lh = legend(slegend);
set(lh,'EdgeColor',[1 1 1]);
%set(lh,'Location','southoutside','Orientation','horizontal');

% -----------------------------------------------
hold on;
numgroups = size(avg_values, 1);
numbars = size(avg_values, 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
for j = 1:numbars
    % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
    x = (1:numgroups) - groupwidth/2 + (2*j-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
    errorbar(x, avg_values(:,j), std_values(:,j), 'k', 'linestyle', 'none', 'LineWidth', 2, 'CapSize', 12);
end
set(findall(gcf,'type','axes'), 'FontSize', 24);
set(findall(gcf,'type','text'), 'FontSize', 24);


end

