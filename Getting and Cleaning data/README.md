run_analysis.R 
========================================================
* Extracts  X data from the test and train directories of "./UCI HAR Dataset/"
* Extracts features and activity data from "./UCI HAR Dataset/" and store them.
* Change the column names of X data from var1,var2 to real values.-ie., mean,sd etc from the features.
* The first 6 rows only correspond to mean and standatrd deviation - extract it
* Extract Y data from the test and train directories of "./UCI HAR Dataset/" and replace activity number with the activity description from activity table
* Likewise, extract the subject data from the test and train directories of "./UCI HAR Dataset/"
* Combine(cbind) subject,y(activity) and x datas of respective test and train directories.
* Merge train and test data.
* Group it by (Subject,activity)
* Find out the average(mean) of all the 6 columns(mean-x,mean-y,mean-z,std-x,std-y,std-z)
* Tidying- 1. make the average values as rows- gather it over mean
           2. convert the activities into columns.
*  dplyr and tidyr packages are used

