#This script is solution to assignment for the Course: Getting and Clearning Data.
# It is doing the following:

#additional libraries to base package - to install
library(plyr)
library(dplyr)
library(data.table)
library(tidyr)

#1. Merges the training and test sets to create one set:
## - read all datasets into data.frames
y_test<-read.table("./test/y_test.txt")
x_test<-read.table("./test/X_test.txt")
subject_test<-read.table("./test/subject_test.txt")
y_train<-read.table("./train/y_train.txt")
x_train<-read.table("./train/X_train.txt")
subject_train<-read.table("./train/subject_train.txt")
namesdata <- read.table("./features.txt")["V2"]
##(after checking dimensions and in.na():all dimensions are ok- matching across, also no NA data in datasets, 
##so no need to clean it)
##-combine all test and train sets into to datasets: test and train:
train<-cbind(y_train, subject_train, x_train)
test<-cbind(y_test, subject_test, x_test)
##to make it more clear, lets rename y and subject column names to "y" and "subject"
##combine two datasets into one
data <- rbind(train, test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
##find indexes of columns where column names match "mean" or "std" and extract data for this columns only 
## add 2 to each idx, as columns in data are shifted by 2 from namesdata due to rbind with "y" and "subject
## add "y" and "subject" columns names as well
idx <- grep("[Mm]ean|[Ss]td", namesdata[,])
data1<- cbind(data[,1], data[,2], data[,(idx+2)])

#3. Uses descriptive activity names to name the activities in the data set
## read activity labels:
labels<- read.table("./activity_labels.txt")
##as labels is a data frame with first column matching possible values inside data[1]("y"column)-(1:5), 
##it is possible to extract "V2" values from labels that are in data$y and reassign them to data$y
data1[,1]<- labels[data1[,1], "V2"]

#4. Appropriately labels the data set with descriptive variable names.
## use extracted idx from point 2 to name columns in data1 set + add "y" and "subject":
colnames(data1)<-c("label", "subject", as.character(namesdata[idx,]))
##rename colnames to tidy form, so names are consistent:
colnames(data1)<-gsub("^t", "Time", colnames(data1))
colnames(data1)<-gsub("[:(:]t", "(Time", colnames(data1))                      
colnames(data1)<-gsub("^f", "Frequency", colnames(data1))
colnames(data1)<-gsub("angle", "Angle", colnames(data1))
colnames(data1)<-gsub("[Mm]ean([:(:][:):])?", "Mean", colnames(data1))
colnames(data1)<-gsub("gravity", "Gravity", colnames(data1))
colnames(data1)<-gsub("[Ss]td([:(:][:):])?", "Std", colnames(data1))
colnames(data1)<-gsub("-", "", colnames(data1))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
data2<-aggregate(data1[3:(dim(data1)[2])], list(data1$label, data1$subject), mean)
#after grouping "y" and "subject" colnames were renamed to group.1, group.2, rename them back:
colnames(data2)[1:2]<-c("label", "subject")
colnames(data2)<-gsub(".1", "", colnames(data1))

#save dataset and column names to txt files:
write.table(data2,file = "./tidydata/dataset.txt",row.name= FALSE)
write.table(names(data2),file = "./tidydata/names.txt",row.name= TRUE, quote = FALSE)
