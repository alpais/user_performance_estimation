function [] = plot_with_error_bar(avgs, stds, slegend, slabels)

figure; hold on;
%colors = parula(length(avgs));

dp = 0.1;
for i = 1:length(avgs)
    h(i) = plot(avgs{i}, 'd--', 'LineWidth', 5);
        %'MarkerEdgeColor',colors(i,:),'MarkerFaceColor',colors(i,:), 'Color', colors(i,:)...
    cl = get(h(i), 'Color');
    errorbar(1:length(avgs{i}), avgs{i}, stds{i},  '-d','MarkerSize', 15, ...
        'CapSize', 12, 'LineWidth', 3, 'LineStyle', 'None', ...
        'MarkerEdgeColor',cl,'MarkerFaceColor',cl, ...
        'Color', cl);            
end

%uistack(h(length(avgs):-1:1), 'top');

legend(h(1:length(avgs)), slegend); % to avoid legend entries for the errorbar
hl = legend;
set(hl, 'Interpreter', 'Latex');
set(hl, 'EdgeColor', [1 1 1]);
% set(hl, 'Orientation', 'Horizontal');
% set(hl, 'Location', 'southoutside');

grid on; box on;
xlim([0.5 length(avgs{1})+0.5]);

set(gca, 'XTick', [1:length(avgs{1})]);
set(gca, 'XTickLabels', slabels);
set(gcf, 'Color', [1 1 1]);

set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);

set(findall(gcf,'type','text'), 'FontSize', 32);
set(findall(gcf,'type','axes'), 'FontSize', 32);

set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);

set(gcf, 'Position', [206 195 1259 696]);
set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

end