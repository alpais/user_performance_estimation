function ComputeStiffnessFromCrit()


load('../VBS/all_S_HD_constraints.mat');

excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];


for snum = 1:52
    
    if ismember(snum, excepted_subjects)
        continue
    else
        sfname = sprintf('../VBS/S%.2d_Crit_Var_Int.mat', snum); load(sfname);
        
        sfname = sprintf('Stiffness Modulation for subject %.2d', snum);        
        figure('Name', sfname, 'NumberTitle', 'off'); hold on;               
        sgm_name = {'Reaching', 'Scooping', 'Trashing'};
        
        for crt_sgm = 1:3
            
            sgm_idx = constraints{snum}.sgm{crt_sgm}.segm_idx;
            subplot(2, 3, crt_sgm); hold on; grid on;
            stitle = sprintf('Passive arm - %s', sgm_name{crt_sgm}); title(stitle);
            
            % For the X axis
            Stiff{crt_sgm}.Passive.X = smooth(Crit.EE.X(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.EE.X(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Passive.X = (Stiff{crt_sgm}.Passive.X - min(Stiff{crt_sgm}.Passive.X))/(max(Stiff{crt_sgm}.Passive.X) - min(Stiff{crt_sgm}.Passive.X));
            Stiff{crt_sgm}.Passive.X = smooth(Stiff{crt_sgm}.Passive.X, 500);
            plot(Stiff{crt_sgm}.Passive.X, 'r', 'LineWidth', 2);
            
            % For the Y axis
            Stiff{crt_sgm}.Passive.Y = smooth(Crit.EE.Y(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.EE.Y(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Passive.Y = (Stiff{crt_sgm}.Passive.Y - min(Stiff{crt_sgm}.Passive.Y))/(max(Stiff{crt_sgm}.Passive.Y) - min(Stiff{crt_sgm}.Passive.Y));
            Stiff{crt_sgm}.Passive.Y = smooth(Stiff{crt_sgm}.Passive.Y, 500);
            plot(Stiff{crt_sgm}.Passive.Y, 'g', 'LineWidth', 2);
            
            % For the Z axis
            Stiff{crt_sgm}.Passive.Z = smooth(Crit.EE.Z(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.EE.Z(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Passive.Z = (Stiff{crt_sgm}.Passive.Z - min(Stiff{crt_sgm}.Passive.Z))/(max(Stiff{crt_sgm}.Passive.Z) - min(Stiff{crt_sgm}.Passive.Z));
            Stiff{crt_sgm}.Passive.Z = smooth(Stiff{crt_sgm}.Passive.Z, 500);
            plot(Stiff{crt_sgm}.Passive.Z, 'b', 'LineWidth', 2);
            
            legend('X Axis','Y Axis','Z Axis')
            
            
            % Active Arm
            subplot(2, 3, crt_sgm+3); hold on; grid on;
            stitle = sprintf('Active arm - %s', sgm_name{crt_sgm}); title(stitle);
            
            % For the X axis
            Stiff{crt_sgm}.Active.X = smooth(Crit.TOOL.X(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.TOOL.X(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Active.X = (Stiff{crt_sgm}.Active.X - min(Stiff{crt_sgm}.Active.X))/(max(Stiff{crt_sgm}.Active.X) - min(Stiff{crt_sgm}.Active.X));
            Stiff{crt_sgm}.Active.X = smooth(Stiff{crt_sgm}.Active.X, 500);
            plot(Stiff{crt_sgm}.Active.X, 'r', 'LineWidth', 2); title('Active arm');
            
            % For the Y axis
            Stiff{crt_sgm}.Active.Y = smooth(Crit.TOOL.Y(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.TOOL.Y(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Active.Y = (Stiff{crt_sgm}.Active.Y - min(Stiff{crt_sgm}.Active.Y))/(max(Stiff{crt_sgm}.Active.Y) - min(Stiff{crt_sgm}.Active.Y));
            Stiff{crt_sgm}.Active.Y = smooth(Stiff{crt_sgm}.Active.Y, 500);
            plot(Stiff{crt_sgm}.Active.Y, 'g', 'LineWidth', 2);
            
            % For the Z axis
            Stiff{crt_sgm}.Active.Z = smooth(Crit.TOOL.Z(sgm_idx(1):sgm_idx(2),1),500) - smooth(Crit.TOOL.Z(sgm_idx(1):sgm_idx(2),2),500);
            Stiff{crt_sgm}.Active.Z = (Stiff{crt_sgm}.Active.Z - min(Stiff{crt_sgm}.Active.Z))/(max(Stiff{crt_sgm}.Active.Z) - min(Stiff{crt_sgm}.Active.Z));
            Stiff{crt_sgm}.Active.Z = smooth(Stiff{crt_sgm}.Active.Z, 500);
            plot(Stiff{crt_sgm}.Active.Z, 'b', 'LineWidth', 2);
            
            legend({'X','Y','Z'});
            
            soutname = sprintf('S%.2d_Stiffness_Modulation.mat', snum);
            save(soutname, 'Stiff', '-mat');
            
            sfigname = sprintf('S%.2d_Stiffness_Modulation.fig', snum);
            savefig(sfigname);
                        
        end
        clear Stiff
    end
end
end