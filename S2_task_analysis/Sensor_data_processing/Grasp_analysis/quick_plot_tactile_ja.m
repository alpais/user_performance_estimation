
excepted_subjects = [1 2 3 4 5 6 12 14 15 16 23 26 28 42 43];

for snum = 1:52
    
    if ismember(snum, excepted_subjects)
        continue
    else
        
        smsg = sprintf(' >>>>>> Processing Subject %d !!! <<<<<<', snum);
        disp(smsg);
        
        sname = sprintf('../../rawdata_sensors_parsed/hand/S%.2d_rawdata_hand.mat',snum); load(sname);
        
        hja = figure; % figure for plotting hand joint angles
        grid on; box on; stitle = sprintf('Subject %d', snum, jj); title(stitle);
        htf = figure; % figure for plotting tactile frontal patches
        hts = figure; % figure for plotting tactile side patches
        
        nb_ja = 23;
        
        for jj = 1:length(rawdata_hand) % nb of demonstrations
            if (isempty(rawdata_hand{jj}))
                continue
            end
            [tactilePressure ] = putGloveDataInRavinFormat(rawdata_hand{jj}.tactile_front(start_idx:end_idx, :), rawdata_hand{jj}.tactile_side(start_idx:end_idx, :));
            glove_JA = rawdata_hand{jj}.finger_ja();
            
            for nja = 1:nb_ja
                subplot(4, 6, nja); hold on; plot(hja, glove_Ja(:, nja));
            end
            
            
            axis equal; view(3); axis auto;
            %                 sfigname = sprintf('Hand_Plots/S%d_Segm%d_Dem%d.fig', snum, k, jj); savefig(sfigname);
            %                 sfigpng = sprintf('Hand_Images/S%d_Segm%d_Dem%d.png', snum, k, jj); saveas(gcf,sfigpng);
            
            clear glove_JA tactile_front tactile_side
            close all
        end
    end
end

disp('Done!!!');

