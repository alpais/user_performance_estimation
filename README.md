# User performance assessment - Task analysis and statistics

This repository provides code and data for analysing the data collected in a user study designed to assess subjects performance in physical manipulation task. The data from this study can be found in the following repository [user_performance_data](https://github.com/alpais/user_performance_data).

We evaluate the way consistent behavior relates to applying forces in a task and to maneuvering a tool. We then relate this information to the performance of the subject as perceived by him/herself or by an external rater.

Dependencies  | Description
------------- | -------------
[user_performance_data](https://github.com/alpais/user_performance_data)  | Data collected in the experiment
[grasp]()  | Analyzing the grasp information - [Reference](http://lasa.epfl.ch/publications/uploadedFiles/graspSignature.pdf)
[Kappa](https://ch.mathworks.com/matlabcentral/fileexchange/15365-cohen-s-kappa)| Cohen's Kappa coefficient for assessing inter-rater agreement
[csvwrite_with_headers](https://ch.mathworks.com/matlabcentral/fileexchange/29933-csv-with-column-headers)|generating csv files for metrics

## Particularities of user behavior

Differences between users in performing the task and manipuating the tool are shown below. These differences affect the exerted forces, and can lead to decreased performance. 

### Differences in user strategies

<img src="/images/strateg_zig_zag.png" width="32%"/>  <img src="/images/strateg_repeat_motion.png" width="32%"/>  
<img src="/images/strateg_scraping.png" width="32%"/>  <img src="/images/strateg_round_scoop.png" width="32%"/>

Motion strategies adopted by unskilled users. In the first 3 cases subjects adjusted their trajectory as they were applying too little force. In the last case the subject applied too much force as he consistently positioned the scoop pressing down with the tip, rather than with the cutting edge.

### Differences across users in holding and manipulating the tool 

<img src="/images/Grasp1.jpg" width="32%"/>  <img src="/images/Grasp2.jpg" width="32%"/>  <img src="/images/Grasp3.jpg" width="32%"/>

Subjects employed a variety of grasps. The adopted hand shape has an effect on their ability to maneuver the tool. The first two images are examples of directional grasps in which one of the fingers is used to direct the motion: the index and the thumb, while the last image shows a power grasp.

## Task analysis and generating statistics

For analyzing the task we perform the following steps:
  * asessing the variance in the sensor data - in order to extract the variables of interest and stiffness modulation
  * grasp analysis - in order to determine if a given grasp is well adapted to the task requirements
  * processing of questionnaire data and video ratings
  
For the generated metrics see folder [S2_task_analysis](https://github.com/alpais/user_performance_estimation/tree/master/S2_task_analysis)
  
For generating the statistics see folder [S3_compute_stats](https://github.com/alpais/user_performance_estimation/tree/master/S3_compute_stats)

## Reference

This work is currently under review: Pais Ureche, A. L., and Billard, A. (2017) Automatic skill assessment in
learning from demonstration. (Under Submission, 2017) 

Funded in part by the European Union Seventh Framewowork Programme FP7/2007-2013 under grant agreement no 288533 ROBOHOW.COG, and by the European Commission Horizon 2020 Framework Programme, H2020-ICT-643950.
