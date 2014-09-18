run_analysis.R 
========================================================
1.Extracts  X data from the test and train directories of "./UCI HAR Dataset/"
2.Extracts features and activity data from "./UCI HAR Dataset/" and store them.
3.Change the column names of X data from var1,var2 to real values.-ie., mean,sd etc from the features.
4.The first 6 rows only correspond to mean and standard deviation - extract it
5.Extract Y data from the test and train directories of "./UCI HAR Dataset/" and replace activity number with the activity description from activity table
6.Likewise, extract the subject data from the test and train directories of "./UCI HAR Dataset/"
7.Combine(cbind) subject,y(activity) and x datas of respective test and train directories.
8.Merge train and test data.
9.Group it by (Subject,activity)
10.Find out the average(mean) of all the 6 columns(mean-x,mean-y,mean-z,std-x,std-y,std-z)
11.Tidying- i.make the average values as rows- gather it over mean
            ii.convert the activities into columns.
12. dplyr and tidyr packages are used

