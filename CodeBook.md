# Clean Data
The original data set contains 561 colums + subject + activities. Once the data has been cleaned up the colums are reduced to 79 + subject + activity.
The final data set, where the means are calculated by subject and by activity, contains 81 variables and 180 observations.
# Varaibles on the final data set
"subject"
"activity"
"tBodyAcc-mean()-X" 
"tBodyAcc-mean()-Y"
"tBodyAcc-mean()-Z" 
"tBodyAcc-std()-X"
"tBodyAcc-std()-Y"
"tBodyAcc-std()-Z" 
"tGravityAcc-mean()-X"
"tGravityAcc-mean()-Y"
"tGravityAcc-mean()-Z" 
"tGravityAcc-std()-X" 
"tGravityAcc-std()-Y" 
"tGravityAcc-std()-Z" 
"tBodyAccJerk-mean()-X"
"tBodyAccJerk-mean()-Y"
"tBodyAccJerk-mean()-Z"
"tBodyAccJerk-std()-X" 
"tBodyAccJerk-std()-Y" 
"tBodyAccJerk-std()-Z" 
"tBodyGyro-mean()-X" 
"tBodyGyro-mean()-Y" 
"tBodyGyro-mean()-Z"
"tBodyGyro-std()-X"
"tBodyGyro-std()-Y"
"tBodyGyro-std()-Z"
"tBodyGyroJerk-mean()-X"
"tBodyGyroJerk-mean()-Y" 
"tBodyGyroJerk-mean()-Z"
"tBodyGyroJerk-std()-X"
"tBodyGyroJerk-std()-Y"
"tBodyGyroJerk-std()-Z"
"tBodyAccMag-mean()"
"tBodyAccMag-std()"
"tGravityAccMag-mean()"
"tGravityAccMag-std()"
"tBodyAccJerkMag-mean()"
"tBodyAccJerkMag-std()"
"tBodyGyroMag-mean()"
"tBodyGyroMag-std()"
"tBodyGyroJerkMag-mean()"
"tBodyGyroJerkMag-std()"
"fBodyAcc-mean()-X"
"fBodyAcc-mean()-Y"
"fBodyAcc-mean()-Z"
"fBodyAcc-std()-X"
"fBodyAcc-std()-Y"
"fBodyAcc-std()-Z" 
"fBodyAcc-meanFreq()-X"
"fBodyAcc-meanFreq()-Y"
"fBodyAcc-meanFreq()-Z"
"fBodyAccJerk-mean()-X"
"fBodyAccJerk-mean()-Y" 
"fBodyAccJerk-mean()-Z"
"fBodyAccJerk-std()-X"
"fBodyAccJerk-std()-Y"
"fBodyAccJerk-std()-Z"
"fBodyAccJerk-meanFreq()-X" 
"fBodyAccJerk-meanFreq()-Y"
"fBodyAccJerk-meanFreq()-Z"
"fBodyGyro-mean()-X"
"fBodyGyro-mean()-Y"
"fBodyGyro-mean()-Z"
"fBodyGyro-std()-X"
"fBodyGyro-std()-Y"
"fBodyGyro-std()-Z"
"fBodyGyro-meanFreq()-X"
"fBodyGyro-meanFreq()-Y"
"fBodyGyro-meanFreq()-Z" 
"fBodyAccMag-mean()"
"fBodyAccMag-std()"
"fBodyAccMag-meanFreq()"
"fBodyBodyAccJerkMag-mean()"
"fBodyBodyAccJerkMag-std()"
"fBodyBodyAccJerkMag-meanFreq()" 
"fBodyBodyGyroMag-mean()" 
"fBodyBodyGyroMag-std()"
"fBodyBodyGyroMag-meanFreq()"
"fBodyBodyGyroJerkMag-mean()"
"fBodyBodyGyroJerkMag-std()" 
"fBodyBodyGyroJerkMag-meanFreq()"

# Code
### READ features and activities
features<-read.csv("features.txt",sep="",header=FALSE) #DIM 561x2
activities<-read.csv("activity_labels.txt",sep="",header=FALSE)
### sets
x_train<-read.csv("train/X_train.txt",sep="",header=FALSE) #DIM 7352 obs. 561 var.
x_test<-read.csv("test/X_test.txt",sep="",header=FALSE) #DIM 2947 obs. 561 var.
x<-rbind(x_train,x_test) # merge train and test data sets
names(x)<-features[,2] # add labels to the columns from features 
###  ACTIVITY labels
y_train<-read.csv("train/Y_train.txt",sep="",header=FALSE) #DIM 7352
y_test<-read.csv("test/Y_test.txt",sep="",header=FALSE) #DIM 2947
y<-rbind(y_train,y_test) #merge train and test activity labels
names(y)<-"Activity"
### subjects
sbj_train<-read.csv("train/subject_train.txt",sep="",header=FALSE) #DIM 7352
sbj_test<-read.csv("test/subject_test.txt",sep="",header=FALSE) #DIM 2947
sbj<-rbind(sbj_train,sbj_test) # merge train and test subjects
names(sbj)<-"Subject"
### Merge all data to form the complete data
mergedData<-cbind(sbj, y, x)
### Convert activity and subject into a factor
mergedData$Activity<-as.factor(mergedData$Activity)
mergedData$Subject<-as.factor(mergedData$Subject)
### Change numbers of activities to activity names
library(plyr)
mapvalues(mergedData$Activity,from=as.numeric(activities[,1]),to=as.character(activities[,2]))

### Select colums in which appears mean or std 
tidy_mergedData<-mergedData[,grep("mean|std",names(mergedData))] 
### Add column for subject and activity
tidy_mergedData<-cbind(Subject=mergedData[,1],Activity=mergedData[,2],tidy_mergedData)
### Calculate the average by subject and activity
library(dplyr)
groupedData<-group_by(tidy_mergedData,Subject,Activity)
summarise_each(groupedData,funs(mean))
