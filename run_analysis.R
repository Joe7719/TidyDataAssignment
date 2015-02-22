## setwd("C:\\Users\\Joe\\_LEARNING_todo\\___Data Science\\3 Getting and Cleaning Data\\Project")

library(dplyr)
library(Hmisc)
library(reshape2)

testRespID <- read.table("subject_test.txt", sep=" ", header=FALSE)
trainRespID <- read.table("subject_train.txt", sep=" ", header=FALSE)

combinedRespID <- rbind(testRespID,trainRespID)

testActivityID <- read.table("y_test.txt", sep=" ", header=FALSE)
trainActivityID <- read.table("y_train.txt", sep=" ", header=FALSE)

combinedActivityID <- rbind(testActivityID,trainActivityID)

testMeasures <- read.table("X_test.txt", header=FALSE)
trainMeasures <- read.table("X_train.txt", header=FALSE)

combinedMeasures <- rbind(testMeasures, trainMeasures)

combinedData <- cbind(combinedRespID, combinedActivityID, combinedMeasures)

colsToKeep <- c(1:8,43:48,83:88,123:128,163:168,203,204,216,217,229,230,242,243,255,256,268:273,347:352,426:431,505,506,518,519,531,532,544,545)

combinedDataMeanSD <- combinedData[,colsToKeep]

combinedDataMeanSD$Activity <- factor(combinedDataMeanSD$V1.1,levels=c(1,2,3,4,5,6),labels=c("WALKING","WALKING UPSTAIRS","WALKING DOWNSTAIRS","SITTING","STANDING","LAYING"))

combinedDataMeanSD <- combinedDataMeanSD[,-2]

combinedDataMeanSD <- combinedDataMeanSD[,c(1,68,2:67)]
colnames(combinedDataMeanSD) <- c("SubjectID","Activity","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-mean()","tBodyAccMag-std()","tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()","tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z","fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-mean()","fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()")
meltedData <- melt(combinedDataMeanSD, id = c("SubjectID", "Activity"))
dcastData <- dcast(meltedData, SubjectID + Activity ~ variable, mean)
finalData <- melt(dcastData, id = c("SubjectID","Activity"))
colnames(finalData) <- c("SubjectID","Activity","Variable","MeanValue")
write.table(finalData,"TidyData.txt",row.names=FALSE)