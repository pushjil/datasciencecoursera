
##Merges the training and the test sets to create one data set.

##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## my code starts here.
library(dplyr)
library(tidyr)
featuresdata<-read.table("./UCI HAR Dataset/features.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
## The first 6 rows only correspond to mean and standatrd deviation.
##X manipulation
X_traindata<-read.table("./UCI HAR Dataset/train/X_train.txt")
##Change the column names from var1,var2 to real values.-ie., mean,sd etc
colnames(X_traindata) <- featuresdata[1:561,2]
X_trainfinal<-subset(X_traindata,select=1:6)


X_testdata<-read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X_testdata) <- featuresdata[1:561,2]
X_testfinal<-subset(X_testdata,select=1:6)

##X_mergedata<-rbind(X_traindata,X_testdata)  

##y Manipulation -activities(walking,etc)
##reading from txt
y_testdata<-read.table("./UCI HAR Dataset/test/y_test.txt")
y_traindata<-read.table("./UCI HAR Dataset/train/y_train.txt")

##Replacing activity number with the description from activity table
y_testdata$V1<-activity[match(y_testdata$V1,activity$V1),2]
colnames(y_testdata)<-"activity"
y_traindata$V1<-activity[match(y_traindata$V1,activity$V1),2]
colnames(y_traindata)<-"activity"

#subject Manipulation(volunteers 1 io 30)
subjecttestdata<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subjecttraindata<-read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(subjecttestdata)<-"Subject"
colnames(subjecttraindata)<-"Subject"

## to merge x_data with subject and y ie.,testdata<-xtestfinal+ytest+subject
testdata<-cbind(subjecttestdata,y_testdata,X_testfinal)
traindata<-cbind(subjecttraindata,y_traindata,X_trainfinal)
totaldata<-rbind(traindata,testdata)
### dplyr  fns.
totaltbldata<-tbl_df(totaldata)
by_sub_act<-group_by(totaltbldata,Subject,activity)
summdata<-summarize(by_sub_act,mean_x=mean(3),mean_y=mean(4),mean_z=mean(5),std_x=mean(6),std_y=mean(7),std_z=mean(8))
##tidyr
##gathdata<-gather(summdata,mean,value,-activity,-Subject)
res<-gather(summdata,aver_of,value,mean_x:std_z)
finaltable<-spread(res,activity,value)
write.table(finaltable,"tidydataset.txt",row.name=FALSE)

##tapply(value, list(year, area), mean) 

