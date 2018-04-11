function [ ] = format_grouped_plot(ysname, xsname, intlim)
%FORMAT_GROUPED_PLOT Summary of this function goes here
%   Detailed explanation goes here

ylim(intlim);
set(findall(gcf,'type','text'), 'FontSize', 32);
set(findall(gcf,'type','axes'), 'FontSize', 32);

xlabel(xsname); %, 'Interpreter', 'Latex', 'FontSize', 42);
ylabel(ysname) %, 'Interpreter', 'Latex', 'FontSize', 42);

set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45]);
set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

grid on; box on;

end

