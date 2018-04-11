function [segm_idx] = getHandSegmIdx()

%% For comparison purposes we use hand segmented data indexes as well (to compare with our automatic segmentation)


excepted_subjects = [1:6 12 14 15 16 23 26 28 42 43];

% constraints{52}.sgm{3} = [];

% Var int - Passive arm X Y Z, Active arm X Y Z
% RF: 1 - Bowl; 2 - Tool; 3 - Robot
% Skill - 1 - skilled; 0 - unskilled

%%
constraints{7}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{7}.sgm{1}.RF.Passive = [1];
constraints{7}.sgm{1}.RF.Active = [1];
constraints{7}.sgm{1}.segm_idx = [1 400];
constraints{7}.sgm{1}.subsegments = 2;

constraints{7}.sgm{2}.segm_idx = [400 2000];
constraints{7}.sgm{2}.var_int = [2 3 2 2 3 2];
constraints{7}.sgm{2}.RF.Passive = [1];
constraints{7}.sgm{2}.RF.Active = [3];
constraints{7}.sgm{2}.subsegments = 3;

constraints{7}.sgm{3}.segm_idx = [2000 2969];
constraints{7}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{7}.sgm{3}.RF.Passive = [2];
constraints{7}.sgm{3}.RF.Active = [1];
constraints{7}.sgm{3}.subsegments = 3;
constraints{7}.skill = 0;

% S7 - changing constraints

%%

constraints{8}.sgm{1}.segm_idx = [1 200];
constraints{8}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{8}.sgm{1}.RF.Passive = [2];
constraints{8}.sgm{1}.RF.Active = [3];
constraints{8}.sgm{1}.subsegments = 2;

constraints{8}.sgm{2}.segm_idx = [200 600];
constraints{8}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{8}.sgm{2}.RF.Passive = [1];
constraints{8}.sgm{2}.RF.Active = [1];
constraints{8}.sgm{2}.subsegments = 1;

constraints{8}.sgm{3}.segm_idx = [600 1200];
constraints{8}.sgm{3}.var_int = [2 1 2 1 1 1];
constraints{8}.sgm{3}.RF.Passive = [1];
constraints{8}.sgm{3}.RF.Active = [1];
constraints{8}.sgm{3}.subsegments = 2;

constraints{8}.skill = 1;

%%

constraints{9}.sgm{1}.segm_idx = [1 200];
constraints{9}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{9}.sgm{1}.RF.Passive = [2];
constraints{9}.sgm{1}.RF.Active = [1];
constraints{9}.sgm{1}.subsegments = 1;

constraints{9}.sgm{2}.segm_idx = [200 1000];
constraints{9}.sgm{2}.var_int = [2 3 2 1 1 2];
constraints{9}.sgm{2}.RF.Passive = [2];
constraints{9}.sgm{2}.RF.Active = [3];
constraints{9}.sgm{2}.subsegments = 2;

constraints{9}.sgm{3}.segm_idx = [1000 1980];
constraints{9}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{9}.sgm{3}.RF.Passive = [1];
constraints{9}.sgm{3}.RF.Active = [1];
constraints{9}.sgm{3}.subsegments = 1;

constraints{9}.skill = 0;

%%

constraints{10}.sgm{1}.segm_idx = [1 200];
constraints{10}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{10}.sgm{1}.RF.Passive = [1];
constraints{10}.sgm{1}.RF.Active = [1];
constraints{10}.sgm{1}.subsegments = 1;

constraints{10}.sgm{2}.segm_idx = [200 500];
constraints{10}.sgm{2}.var_int = [2 3 3 2 2 3];
constraints{10}.sgm{2}.RF.Passive = [2];
constraints{10}.sgm{2}.RF.Active = [3];
constraints{10}.sgm{2}.subsegments = 1;

constraints{10}.sgm{3}.segm_idx = [500 1180];
constraints{10}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{10}.sgm{3}.RF.Passive = [2];
constraints{10}.sgm{3}.RF.Active = [1];
constraints{10}.sgm{3}.subsegments = 2;

constraints{10}.skill = 1;

% Subject 10 has a clear distinction between the going away from the robot
% motion and the trashing motion. This is observable for the tool, from the change of RF
% in the last part of the motion from the tool to the bowl. This changes
% the task prototype as having two distinct actions instead of 1. This is
% not necessarily a matter of skill, but a matter of preference.

%%

constraints{11}.sgm{1}.segm_idx = [1 100];
constraints{11}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{11}.sgm{1}.RF.Passive = [2];
constraints{11}.sgm{1}.RF.Active = [1];
constraints{11}.sgm{1}.subsegments = 1;

constraints{11}.sgm{2}.segm_idx = [100 700];
constraints{11}.sgm{2}.var_int = [3 3 3 3 2 2];
constraints{11}.sgm{2}.RF.Passive = [1];
constraints{11}.sgm{2}.RF.Active = [1];
constraints{11}.sgm{2}.subsegments = 3;

constraints{11}.sgm{3}.segm_idx = [700 990];
constraints{11}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{11}.sgm{3}.RF.Passive = [1];
constraints{11}.sgm{3}.RF.Active = [3];
constraints{11}.sgm{3}.subsegments = 2;

constraints{11}.skill = 0;

%%

constraints{13}.sgm{1}.segm_idx = [1 100];
constraints{13}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{13}.sgm{1}.RF.Passive = [1];
constraints{13}.sgm{1}.RF.Active = [3];
constraints{13}.sgm{1}.subsegments = 1;

constraints{13}.sgm{2}.segm_idx = [100 500];
constraints{13}.sgm{2}.var_int = [3 2 2 2 3 2];
constraints{13}.sgm{2}.RF.Passive = [1];
constraints{13}.sgm{2}.RF.Active = [1];
constraints{13}.sgm{2}.subsegments = 1;

constraints{13}.sgm{3}.segm_idx = [500 1040];
constraints{13}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{13}.sgm{3}.RF.Passive = [2];
constraints{13}.sgm{3}.RF.Active = [3];
constraints{13}.sgm{3}.subsegments = 1;

constraints{13}.skill = 1;

%%

constraints{17}.sgm{1}.segm_idx = [1 100];
constraints{17}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{17}.sgm{1}.subsegments = 1;
constraints{17}.sgm{1}.RF.Passive = [1];
constraints{17}.sgm{1}.RF.Active = [2];

constraints{17}.sgm{2}.segm_idx = [100 600];
constraints{17}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{17}.sgm{2}.subsegments = 1;
constraints{17}.sgm{2}.RF.Passive = [2];
constraints{17}.sgm{2}.RF.Active = [3];

constraints{17}.sgm{3}.segm_idx = [600 1140];
constraints{17}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{17}.sgm{3}.subsegments = 1;
constraints{17}.sgm{3}.RF.Passive = [1];
constraints{17}.sgm{3}.RF.Active = [3];

constraints{17}.skill = 1;

%%

constraints{18}.sgm{1}.segm_idx = [1 200];
constraints{18}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{18}.sgm{1}.subsegments = 1;
constraints{18}.sgm{1}.RF.Passive = [1];
constraints{18}.sgm{1}.RF.Active = [1];

constraints{18}.sgm{2}.segm_idx = [200 800];
constraints{18}.sgm{2}.var_int = [2 2 3 2 3 2];
constraints{18}.sgm{2}.subsegments = 1;
constraints{18}.sgm{2}.RF.Passive = [2];
constraints{18}.sgm{2}.RF.Active = [1];

constraints{18}.sgm{3}.segm_idx = [800 1400];
constraints{18}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{18}.sgm{3}.subsegments = 1;
constraints{18}.sgm{3}.RF.Passive = [2];
constraints{18}.sgm{3}.RF.Active = [1];

constraints{18}.skill = 1;

%%

constraints{19}.sgm{1}.segm_idx = [1 100];
constraints{19}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{19}.sgm{1}.subsegments = 1;
constraints{19}.sgm{1}.RF.Passive = [1];
constraints{19}.sgm{1}.RF.Active = [1];

constraints{19}.sgm{2}.segm_idx = [100 500];
constraints{19}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{19}.sgm{2}.subsegments = 1;
constraints{19}.sgm{2}.RF.Passive = [1];
constraints{19}.sgm{2}.RF.Active = [1];

constraints{19}.sgm{3}.segm_idx = [500 880];
constraints{19}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{19}.sgm{3}.subsegments = 1;
constraints{19}.sgm{3}.RF.Passive = [2];
constraints{19}.sgm{3}.RF.Active = [3];

constraints{19}.skill = 1;

%%

constraints{20}.sgm{1}.segm_idx = [1 300];
constraints{20}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{20}.sgm{1}.subsegments = 1;
constraints{20}.sgm{1}.RF.Passive = [2];
constraints{20}.sgm{1}.RF.Active = [3];

constraints{20}.sgm{2}.segm_idx = [300 900];
constraints{20}.sgm{2}.var_int = [2 3 1 3 2 2];
constraints{20}.sgm{2}.subsegments = 4;
constraints{20}.sgm{2}.RF.Passive = [1];
constraints{20}.sgm{2}.RF.Active = [1];

constraints{20}.sgm{3}.segm_idx = [900 1480];
constraints{20}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{20}.sgm{3}.subsegments = 1;
constraints{20}.sgm{3}.RF.Passive = [2];
constraints{20}.sgm{3}.RF.Active = [1];

constraints{20}.skill = 0;

%%

constraints{21}.sgm{1}.segm_idx = [1 100];
constraints{21}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{21}.sgm{1}.subsegments = 1;
constraints{21}.sgm{1}.RF.Passive = [1];
constraints{21}.sgm{1}.RF.Active = [1];

constraints{21}.sgm{2}.segm_idx = [100 400];
constraints{21}.sgm{2}.var_int = [2 3 2 2 3 2];
constraints{21}.sgm{2}.subsegments = 1;
constraints{21}.sgm{2}.RF.Passive = [1];
constraints{21}.sgm{2}.RF.Active = [1];

constraints{21}.sgm{3}.segm_idx = [400 850];
constraints{21}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{21}.sgm{3}.subsegments = 1;
constraints{21}.sgm{3}.RF.Passive = [2];
constraints{21}.sgm{3}.RF.Active = [3];

constraints{21}.skill = 1;

%%

constraints{22}.sgm{1}.segm_idx = [1 100];
constraints{22}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{22}.sgm{1}.subsegments = 1;
constraints{22}.sgm{1}.RF.Passive = [1];
constraints{22}.sgm{1}.RF.Active = [3];

constraints{22}.sgm{2}.segm_idx = [100 600];
constraints{22}.sgm{2}.var_int = [ 2 3 2 2 3 2];
constraints{22}.sgm{2}.subsegments = 2;
constraints{22}.sgm{2}.RF.Passive = [1];
constraints{22}.sgm{2}.RF.Active = [1];

constraints{22}.sgm{3}.segm_idx = [600 1080];
constraints{22}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{22}.sgm{3}.subsegments = 1;
constraints{22}.sgm{3}.RF.Passive = [2];
constraints{22}.sgm{3}.RF.Active = [3];

constraints{22}.skill = 0;

%%

constraints{24}.sgm{1}.segm_idx = [1 200];
constraints{24}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{24}.sgm{1}.subsegments = 1;
constraints{24}.sgm{1}.RF.Passive = [1];
constraints{24}.sgm{1}.RF.Active = [1];

constraints{24}.sgm{2}.segm_idx = [200 600];
constraints{24}.sgm{2}.var_int = [3 3 3 3 2 3];
constraints{24}.sgm{2}.subsegments = 1;
constraints{24}.sgm{2}.RF.Passive = [2];
constraints{24}.sgm{2}.RF.Active = [3];

constraints{24}.sgm{3}.segm_idx = [600 1200];
constraints{24}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{24}.sgm{3}.subsegments = 1;
constraints{24}.sgm{3}.RF.Passive = [1];
constraints{24}.sgm{3}.RF.Active = [1];

constraints{24}.skill = 1;

%%

constraints{25}.sgm{1}.segm_idx = [1 200];
constraints{25}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{25}.sgm{1}.subsegments = 1;
constraints{25}.sgm{1}.RF.Passive = [1];
constraints{25}.sgm{1}.RF.Active = [3];

constraints{25}.sgm{2}.segm_idx = [200 400];
constraints{25}.sgm{2}.var_int = [3 2 3 3 2 2];
constraints{25}.sgm{2}.subsegments = 1;
constraints{25}.sgm{2}.RF.Passive = [1];
constraints{25}.sgm{2}.RF.Active = [1];

constraints{25}.sgm{3}.segm_idx = [400 800];
constraints{25}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{25}.sgm{3}.subsegments = 1;
constraints{25}.sgm{3}.RF.Passive = [2];
constraints{25}.sgm{3}.RF.Active = [3];

constraints{25}.skill = 1;

%%

constraints{27}.sgm{1}.segm_idx = [1 100];
constraints{27}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{27}.sgm{1}.subsegments = 1;
constraints{27}.sgm{1}.RF.Passive = [1];
constraints{27}.sgm{1}.RF.Active = [3];

constraints{27}.sgm{2}.segm_idx = [100 400];
constraints{27}.sgm{2}.var_int = [3 3 2 2 3 2];
constraints{27}.sgm{2}.subsegments = 1;
constraints{27}.sgm{2}.RF.Passive = [1];
constraints{27}.sgm{2}.RF.Active = [1];

constraints{27}.sgm{3}.segm_idx = [400 880];
constraints{27}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{27}.sgm{3}.subsegments = 1;
constraints{27}.sgm{3}.RF.Passive = [2];
constraints{27}.sgm{3}.RF.Active = [3];

constraints{27}.skill = 1;

%%

constraints{29}.sgm{1}.segm_idx = [1 100];
constraints{29}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{29}.sgm{1}.subsegments = 1;
constraints{29}.sgm{1}.RF.Passive = [2];
constraints{29}.sgm{1}.RF.Active = [1];

constraints{29}.sgm{2}.segm_idx = [100 700];
constraints{29}.sgm{2}.var_int = [3 3 3 2 3 3];
constraints{29}.sgm{2}.subsegments = 1;
constraints{29}.sgm{2}.RF.Passive = [1];
constraints{29}.sgm{2}.RF.Active = [1];

constraints{29}.sgm{3}.segm_idx = [700 1400];
constraints{29}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{29}.sgm{3}.subsegments = 1;
constraints{29}.sgm{3}.RF.Passive = [2];
constraints{29}.sgm{3}.RF.Active = [3];

constraints{29}.skill = 1;

%%

constraints{30}.sgm{1}.segm_idx = [1 100];
constraints{30}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{30}.sgm{1}.subsegments = 1;
constraints{30}.sgm{1}.RF.Passive = [1];
constraints{30}.sgm{1}.RF.Active = [1];

constraints{30}.sgm{2}.segm_idx = [100 700];
constraints{30}.sgm{2}.var_int = [2 3 2 3 2 3];
constraints{30}.sgm{2}.subsegments = 2;
constraints{30}.sgm{2}.RF.Passive = [1];
constraints{30}.sgm{2}.RF.Active = [1];

constraints{30}.sgm{3}.segm_idx = [700 1400];
constraints{30}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{30}.sgm{3}.subsegments = 1;
constraints{30}.sgm{3}.RF.Passive = [2];
constraints{30}.sgm{3}.RF.Active = [3];

constraints{30}.skill = 0;

%%

constraints{31}.sgm{1}.segm_idx = [1 100];
constraints{31}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{31}.sgm{1}.subsegments = 1;
constraints{31}.sgm{1}.RF.Passive = [2];
constraints{31}.sgm{1}.RF.Active = [3];

constraints{31}.sgm{2}.segm_idx = [100 700];
constraints{31}.sgm{2}.var_int = [2 2 1 3 2 2];
constraints{31}.sgm{2}.subsegments = 1;
constraints{31}.sgm{2}.RF.Passive = [1];
constraints{31}.sgm{2}.RF.Active = [1];

constraints{31}.sgm{3}.segm_idx = [700 1100];
constraints{31}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{31}.sgm{3}.subsegments = 1;
constraints{31}.sgm{3}.RF.Passive = [2];
constraints{31}.sgm{3}.RF.Active = [3];

constraints{31}.skill = 1;

%%

constraints{32}.sgm{1}.segm_idx = [1 100];
constraints{32}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{32}.sgm{1}.subsegments = 1;
constraints{32}.sgm{1}.RF.Passive = [1];
constraints{32}.sgm{1}.RF.Active = [1];

constraints{32}.sgm{2}.segm_idx = [100 500];
constraints{32}.sgm{2}.var_int = [2 2 2 2 3 3];
constraints{32}.sgm{2}.subsegments = 3;
constraints{32}.sgm{2}.RF.Passive = [2];
constraints{32}.sgm{2}.RF.Active = [3];

constraints{32}.sgm{3}.segm_idx = [500 1000];
constraints{32}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{32}.sgm{3}.subsegments = 1;
constraints{32}.sgm{3}.RF.Passive = [2];
constraints{32}.sgm{3}.RF.Active = [3];

constraints{32}.skill = 0;

%%

constraints{33}.sgm{1}.segm_idx = [1 100];
constraints{33}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{33}.sgm{1}.subsegments = 1;
constraints{33}.sgm{1}.RF.Passive = [1];
constraints{33}.sgm{1}.RF.Active = [1];

constraints{33}.sgm{2}.segm_idx = [100 400];
constraints{33}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{33}.sgm{2}.subsegments = 1;
constraints{33}.sgm{2}.RF.Passive = [1];
constraints{33}.sgm{2}.RF.Active = [1];

constraints{33}.sgm{3}.segm_idx = [400 850];
constraints{33}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{33}.sgm{3}.subsegments = 1;
constraints{33}.sgm{3}.RF.Passive = [2];
constraints{33}.sgm{3}.RF.Active = [3];

constraints{33}.skill = 1;

%%

constraints{34}.sgm{1}.segm_idx = [1 200];
constraints{34}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{34}.sgm{1}.subsegments = 1;
constraints{34}.sgm{1}.RF.Passive = [1];
constraints{34}.sgm{1}.RF.Active = [1];

constraints{34}.sgm{2}.segm_idx = [200 600];
constraints{34}.sgm{2}.var_int = [3 3 3 3 2 3];
constraints{34}.sgm{2}.subsegments = 3;
constraints{34}.sgm{2}.RF.Passive = [1];
constraints{34}.sgm{2}.RF.Active = [1];

constraints{34}.sgm{3}.segm_idx = [600 1150];
constraints{34}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{34}.sgm{3}.subsegments = 1;
constraints{34}.sgm{3}.RF.Passive = [2];
constraints{34}.sgm{3}.RF.Active = [3];

constraints{34}.skill = 0;

%%

constraints{35}.sgm{1}.segm_idx = [1 100];
constraints{35}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{35}.sgm{1}.subsegments = 1;
constraints{35}.sgm{1}.RF.Passive = [2];
constraints{35}.sgm{1}.RF.Active = [3];

constraints{35}.sgm{2}.segm_idx = [100 400];
constraints{35}.sgm{2}.var_int = [2 3 2 3 2 2];
constraints{35}.sgm{2}.subsegments = 1;
constraints{35}.sgm{2}.RF.Passive = [1];
constraints{35}.sgm{2}.RF.Active = [1];

constraints{35}.sgm{3}.segm_idx = [400 880];
constraints{35}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{35}.sgm{3}.subsegments = 1;
constraints{35}.sgm{3}.RF.Passive = [2];
constraints{35}.sgm{3}.RF.Active = [3];

constraints{35}.skill = 1;

%%

constraints{36}.sgm{1}.segm_idx = [1 100];
constraints{36}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{36}.sgm{1}.subsegments = 1;
constraints{36}.sgm{1}.RF.Passive = [1];
constraints{36}.sgm{1}.RF.Active = [1];

constraints{36}.sgm{2}.segm_idx = [100 300];
constraints{36}.sgm{2}.var_int = [2 3 2 3 3 3];
constraints{36}.sgm{2}.subsegments = 1;
constraints{36}.sgm{2}.RF.Passive = [1];
constraints{36}.sgm{2}.RF.Active = [1];

constraints{36}.sgm{3}.segm_idx = [300 600];
constraints{36}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{36}.sgm{3}.subsegments = 1;
constraints{36}.sgm{3}.RF.Passive = [2];
constraints{36}.sgm{3}.RF.Active = [3];

constraints{36}.skill = 1;

%%

constraints{37}.sgm{1}.segm_idx = [1 100];
constraints{37}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{37}.sgm{1}.subsegments = 1;
constraints{37}.sgm{1}.RF.Passive = [1];
constraints{37}.sgm{1}.RF.Active = [1];

constraints{37}.sgm{2}.segm_idx = [100 300];
constraints{37}.sgm{2}.var_int = [ 2 3 2 2 3 2];
constraints{37}.sgm{2}.subsegments = 1;
constraints{37}.sgm{2}.RF.Passive = [1];
constraints{37}.sgm{2}.RF.Active = [1];

constraints{37}.sgm{3}.segm_idx = [300 700];
constraints{37}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{37}.sgm{3}.subsegments = 1;
constraints{37}.sgm{3}.RF.Passive = [2];
constraints{37}.sgm{3}.RF.Active = [3];

constraints{37}.skill = 1;

%%

constraints{38}.sgm{1}.segm_idx = [1 100];
constraints{38}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{38}.sgm{1}.subsegments = 1;
constraints{38}.sgm{1}.RF.Passive = [1];
constraints{38}.sgm{1}.RF.Active = [3];

constraints{38}.sgm{2}.segm_idx = [100 500];
constraints{38}.sgm{2}.var_int = [3 2 2 2 3 3];
constraints{38}.sgm{2}.subsegments = 1;
constraints{38}.sgm{2}.RF.Passive = [1];
constraints{38}.sgm{2}.RF.Active = [3];

constraints{38}.sgm{3}.segm_idx = [500 1000];
constraints{38}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{38}.sgm{3}.subsegments = 1;
constraints{38}.sgm{3}.RF.Passive = [2];
constraints{38}.sgm{3}.RF.Active = [1];

constraints{38}.skill = 1;

%%

constraints{39}.sgm{1}.segm_idx = [1 1000];
constraints{39}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{39}.sgm{1}.subsegments = 1;
constraints{39}.sgm{1}.RF.Passive = [1];
constraints{39}.sgm{1}.RF.Active = [3];

constraints{39}.sgm{2}.segm_idx = [1000 6000];
constraints{39}.sgm{2}.var_int = [2 2 3 2 3 3];
constraints{39}.sgm{2}.subsegments = 3;
constraints{39}.sgm{2}.RF.Passive = [1];
constraints{39}.sgm{2}.RF.Active = [1];

constraints{39}.sgm{3}.segm_idx = [6000 7400];
constraints{39}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{39}.sgm{3}.subsegments = 1;
constraints{39}.sgm{3}.RF.Passive = [2];
constraints{39}.sgm{3}.RF.Active = [3];

constraints{39}.skill = 0;

%%

constraints{40}.sgm{1}.segm_idx = [1 200];
constraints{40}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{40}.sgm{1}.subsegments = 1;
constraints{40}.sgm{1}.RF.Passive = [1];
constraints{40}.sgm{1}.RF.Active = [1];

constraints{40}.sgm{2}.segm_idx = [200 600];
constraints{40}.sgm{2}.var_int = [2 3 3 2 3 2];
constraints{40}.sgm{2}.subsegments = 1;
constraints{40}.sgm{2}.RF.Passive = [1];
constraints{40}.sgm{2}.RF.Active = [1];

constraints{40}.sgm{3}.segm_idx = [600 100];
constraints{40}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{40}.sgm{3}.subsegments = 1;
constraints{40}.sgm{3}.RF.Passive = [2];
constraints{40}.sgm{3}.RF.Active = [3];

constraints{40}.skill = 1;

%%

constraints{41}.sgm{1}.segm_idx = [1 100];
constraints{41}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{41}.sgm{1}.subsegments = 1;
constraints{41}.sgm{1}.RF.Passive = [1];
constraints{41}.sgm{1}.RF.Active = [1];

constraints{41}.sgm{2}.segm_idx = [100 600];
constraints{41}.sgm{2}.var_int = [3 2 3 2 2 3];
constraints{41}.sgm{2}.subsegments = 2;
constraints{41}.sgm{2}.RF.Passive = [2];
constraints{41}.sgm{2}.RF.Active = [1];

constraints{41}.sgm{3}.segm_idx = [600 900];
constraints{41}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{41}.sgm{3}.subsegments = 1;
constraints{41}.sgm{3}.RF.Passive = [2];
constraints{41}.sgm{3}.RF.Active = [3];

constraints{41}.skill = 0;

%%

constraints{44}.sgm{1}.segm_idx = [1 100];
constraints{44}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{44}.sgm{1}.subsegments = 1;
constraints{44}.sgm{1}.RF.Passive = [2];
constraints{44}.sgm{1}.RF.Active = [3];

constraints{44}.sgm{2}.segm_idx = [100 400];
constraints{44}.sgm{2}.var_int = [3 2 3 2 2 3];
constraints{44}.sgm{2}.subsegments = 1;
constraints{44}.sgm{2}.RF.Passive = [1];
constraints{44}.sgm{2}.RF.Active = [1];

constraints{44}.sgm{3}.segm_idx = [400 750];
constraints{44}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{44}.sgm{3}.subsegments = 1;
constraints{44}.sgm{3}.RF.Passive = [2];
constraints{44}.sgm{3}.RF.Active = [3];

constraints{44}.skill = 1;

%%

constraints{45}.sgm{1}.segm_idx = [1 100];
constraints{45}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{45}.sgm{1}.subsegments = 1;
constraints{45}.sgm{1}.RF.Passive = [1];
constraints{45}.sgm{1}.RF.Active = [1];

constraints{45}.sgm{2}.segm_idx = [100 400];
constraints{45}.sgm{2}.var_int = [2 3 3 3 2 3];
constraints{45}.sgm{2}.subsegments = 1;
constraints{45}.sgm{2}.RF.Passive = [1];
constraints{45}.sgm{2}.RF.Active = [1];

constraints{45}.sgm{3}.segm_idx = [400 900];
constraints{45}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{45}.sgm{3}.subsegments = 1;
constraints{45}.sgm{3}.RF.Passive = [2];
constraints{45}.sgm{3}.RF.Active = [3];

constraints{45}.skill = 1;

%%

constraints{46}.sgm{1}.segm_idx = [1 100];
constraints{46}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{46}.sgm{1}.subsegments = 1;
constraints{46}.sgm{1}.RF.Passive = [1];
constraints{46}.sgm{1}.RF.Active = [1];

constraints{46}.sgm{2}.segm_idx = [100 600];
constraints{46}.sgm{2}.var_int = [2 1 1 3 2 3];
constraints{46}.sgm{2}.subsegments = 1;
constraints{46}.sgm{2}.RF.Passive = [1];
constraints{46}.sgm{2}.RF.Active = [1];

constraints{46}.sgm{3}.segm_idx = [600 1000];
constraints{46}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{46}.sgm{3}.subsegments = 1;
constraints{46}.sgm{3}.RF.Passive = [1];
constraints{46}.sgm{3}.RF.Active = [1];

constraints{46}.skill = 1;

%%

constraints{47}.sgm{1}.segm_idx = [1 100];
constraints{47}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{47}.sgm{1}.subsegments = 1;
constraints{47}.sgm{1}.RF.Passive = [2];
constraints{47}.sgm{1}.RF.Active = [3];

constraints{47}.sgm{2}.segm_idx = [100 700];
constraints{47}.sgm{2}.var_int = [2 2 3 2 3 3];
constraints{47}.sgm{2}.subsegments = 1;
constraints{47}.sgm{2}.RF.Passive = [1];
constraints{47}.sgm{2}.RF.Active = [1];

constraints{47}.sgm{3}.segm_idx = [700 1200];
constraints{47}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{47}.sgm{3}.subsegments = 1;
constraints{47}.sgm{3}.RF.Passive = [2];
constraints{47}.sgm{3}.RF.Active = [1];

constraints{47}.skill = 1;

%%

constraints{48}.sgm{1}.segm_idx = [1 300];
constraints{48}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{48}.sgm{1}.subsegments = 1;
constraints{48}.sgm{1}.RF.Passive = [1];
constraints{48}.sgm{1}.RF.Active = [1];

constraints{48}.sgm{2}.segm_idx = [300 900];
constraints{48}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{48}.sgm{2}.subsegments = 1;
constraints{48}.sgm{2}.RF.Passive = [1];
constraints{48}.sgm{2}.RF.Active = [1];

constraints{48}.sgm{3}.segm_idx = [900 1400];
constraints{48}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{48}.sgm{3}.subsegments = 1;
constraints{48}.sgm{3}.RF.Passive = [2];
constraints{48}.sgm{3}.RF.Active = [1];

constraints{48}.skill = 1;

%%

constraints{49}.sgm{1}.segm_idx = [1 200];
constraints{49}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{49}.sgm{1}.subsegments = 1;
constraints{49}.sgm{1}.RF.Passive = [2];
constraints{49}.sgm{1}.RF.Active = [3];

constraints{49}.sgm{2}.segm_idx = [200 600];
constraints{49}.sgm{2}.var_int = [3 3 3 3 2 3];
constraints{49}.sgm{2}.subsegments = 1;
constraints{49}.sgm{2}.RF.Passive = [1];
constraints{49}.sgm{2}.RF.Active = [1];

constraints{49}.sgm{3}.segm_idx = [600 100];
constraints{49}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{49}.sgm{3}.subsegments = 1;
constraints{49}.sgm{3}.RF.Passive = [1];
constraints{49}.sgm{3}.RF.Active = [3];

constraints{49}.skill = 1;

%%

constraints{50}.sgm{1}.segm_idx = [1 200];
constraints{50}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{50}.sgm{1}.subsegments = 1;
constraints{50}.sgm{1}.RF.Passive = [2];
constraints{50}.sgm{1}.RF.Active = [3];

constraints{50}.sgm{2}.segm_idx = [200 800];
constraints{50}.sgm{2}.var_int = [3 3 3 2 3 3];
constraints{50}.sgm{2}.subsegments = 1;
constraints{50}.sgm{2}.RF.Passive = [1];
constraints{50}.sgm{2}.RF.Active = [1];

constraints{50}.sgm{3}.segm_idx = [800 1400];
constraints{50}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{50}.sgm{3}.subsegments = 1;
constraints{50}.sgm{3}.RF.Passive = [2];
constraints{50}.sgm{3}.RF.Active = [1];

constraints{50}.skill = 1;

%%

constraints{51}.sgm{1}.segm_idx = [1 500];
constraints{51}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{51}.sgm{1}.subsegments = 1;
constraints{51}.sgm{1}.RF.Passive = [2];
constraints{51}.sgm{1}.RF.Active = [3];

constraints{51}.sgm{2}.segm_idx = [500 1500];
constraints{51}.sgm{2}.var_int = [3 3 3 2 3 2];
constraints{51}.sgm{2}.subsegments = 1;
constraints{51}.sgm{2}.RF.Passive = [1];
constraints{51}.sgm{2}.RF.Active = [1];

constraints{51}.sgm{3}.segm_idx = [1500 2300];
constraints{51}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{51}.sgm{3}.subsegments = 1;
constraints{51}.sgm{3}.RF.Passive = [2];
constraints{51}.sgm{3}.RF.Active = [3];

constraints{51}.skill = 1;

%%

constraints{52}.sgm{1}.segm_idx = [1 100];
constraints{52}.sgm{1}.var_int = [1 1 1 1 1 1];
constraints{52}.sgm{1}.subsegments = 1;
constraints{52}.sgm{1}.RF.Passive = [1];
constraints{52}.sgm{1}.RF.Active = [1];

constraints{52}.sgm{2}.segm_idx = [100 300];
constraints{52}.sgm{2}.var_int = [2 3 3 3 2 2];
constraints{52}.sgm{2}.subsegments = 1;
constraints{52}.sgm{2}.RF.Passive = [1];
constraints{52}.sgm{2}.RF.Active = [1];

constraints{52}.sgm{3}.segm_idx = [300 800];
constraints{52}.sgm{3}.var_int = [1 1 1 1 1 1];
constraints{52}.sgm{3}.subsegments = 1;
constraints{52}.sgm{3}.RF.Passive = [2];
constraints{52}.sgm{3}.RF.Active = [3];

constraints{52}.skill = 1;

save('all_S_HD_constraints.mat','constraints','-mat');
end

