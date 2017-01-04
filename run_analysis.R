# READ features and activities
features<-read.csv("features.txt",sep="",header=FALSE) #DIM 561x2
activities<-read.csv("activity_labels.txt",sep="",header=FALSE)
# LOAD data
# sets
x_train<-read.csv("train/X_train.txt",sep="",header=FALSE) #DIM 7352 obs. 561 var.
x_test<-read.csv("test/X_test.txt",sep="",header=FALSE) #DIM 2947 obs. 561 var.
x<-rbind(x_train,x_test) # merge train and test data sets
names(x)<-features[,2] # add labels to the columns from features 
#  ACTIVITY labels
y_train<-read.csv("train/Y_train.txt",sep="",header=FALSE) #DIM 7352
y_test<-read.csv("test/Y_test.txt",sep="",header=FALSE) #DIM 2947
y<-rbind(y_train,y_test) #merge train and test activity labels
names(y)<-"Activity"
# subjects
sbj_train<-read.csv("train/subject_train.txt",sep="",header=FALSE) #DIM 7352
sbj_test<-read.csv("test/subject_test.txt",sep="",header=FALSE) #DIM 2947
sbj<-rbind(sbj_train,sbj_test) # merge train and test subjects
names(sbj)<-"Subject"
# Merge all data to form the complete data
mergedData<-cbind(sbj, y, x)
# Convert activity and subject into a factor
mergedData$Activity<-as.factor(mergedData$Activity)
mergedData$Subject<-as.factor(mergedData$Subject)
# Change numbers of activities to activity names
library(plyr)
mapvalues(mergedData$Activity,from=as.numeric(activities[,1]),to=as.character(activities[,2]))

#Select colums in which appears mean or std 
tidy_mergedData<-mergedData[,grep("mean|std",names(mergedData))] 
#Add column for subject and activity
tidy_mergedData<-cbind(Subject=mergedData[,1],Activity=mergedData[,2],tidy_mergedData)
# Calculate the average by subject and activity
library(dplyr)
groupedData<-group_by(tidy_mergedData,Subject,Activity)
summarise_each(groupedData,funs(mean))
