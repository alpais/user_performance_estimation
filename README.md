# User performance assessment - Task analysis and statistics

This repository provides code and data for analysing the data collected in a user study designed to assess subjects performance in physical manipulation task. The data from this study can be found in the following repository [user_performance_data](https://github.com/alpais/user_performance_data).

We evaluate the way consistent behavior relates to applying forces in a task and to maneuvering a tool.We then relate this information to 
the performance of the subject as perceived by him/herself or by an external rater.

Dependencies  | Description
------------- | -------------
[user_performance_data](https://github.com/alpais/user_performance_data)  | Data collected in the experiment
[grasp]()  | Analyzing the grasp information - [Reference](http://lasa.epfl.ch/publications/uploadedFiles/graspSignature.pdf)
[Kappa](https://ch.mathworks.com/matlabcentral/fileexchange/15365-cohen-s-kappa)| Cohen's Kappa coefficient for assessing inter-rater agreement
[csvwrite_with_headers](https://ch.mathworks.com/matlabcentral/fileexchange/29933-csv-with-column-headers)|generating csv files for metrics


## Task analysis and generating statistics

For analyzing the task we perform the following steps:
  * asessing the variance in the sensor data - in order to extract the variables of interest and stiffness modulation
  * grasp analysis - in order to determine if a given grasp is well adapted to the task requirements
  * processing of questionnaire data and video ratings
  
For the generated metrics see folder [S2_task_analysis](https://github.com/alpais/user_performance_estimation/tree/master/S2_task_analysis):
  
For generating the statistics see folder [S3_compute_stats](https://github.com/alpais/user_performance_estimation/tree/master/S3_compute_stats)

