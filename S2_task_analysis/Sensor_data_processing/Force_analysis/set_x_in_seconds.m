function [ ] = set_x_in_seconds(dataSamples)
%SET_X_IN_SECONDS Summary of this function goes here
%   Detailed explanation goes here
    %Display x axis in seconds
    samplingRate = 1000;
    a = findall(gcf,'type','axes');
    for i = 1:length(a)
        set(a(i),'Xtick',0:2*samplingRate:dataSamples);
        set(a(i),'XtickLabel',(0:2*samplingRate:dataSamples)/samplingRate);
        set(a(i),'LooseInset',get(gca,'TightInset'))
    end


end

