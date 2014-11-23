#Getting and cleaning data project. 
features <- read.table("features.txt")
#dim of features: 561

#Find out the desirable features
mean <- grep("mean", features[,2])
#column mean corresponding to measurements "mean", total of 46
sd <- grep("std", features[,2])
#column sd corresponding to measurements "std", total of 33

#Data for each observation for each features
X_train <- read.table("./train/X_train.txt")
#dim(X_tarin), 7352 observasion, 561 features
y_train <- read.table("./train/y_train.txt")
#dim(y_train) = 7352
subject_train <- read.table("./train/subject_train.txt")
#dim(subject_train) = 7352

X_test <- read.table("./test/X_test.txt")
#dim(X_test), 2947 observasion, 561 features
y_test <- read.table("./test/y_test.txt")
#dim(y_test) = 2947
subject_test <- read.table("./test/subject_test.txt")
#dim(subject_train) = 2947

#Subset X_train and X_test for selected columns
X_train <- X_train[,c(mean,sd)] #dim = 7352 79
X_test <- X_test[,c(mean,sd)] #dim = 2947 79
#Data, dim = 10299 79 
data <- rbind(X_train,X_test)
#Subject = rbind ( subject_train, subject_test)
subject <- rbind(subject_train, subject_test) # dim = 10299
#Activity = rbind (y_train, y_test)
activity <- rbind(y_train, y_test) # dim = 10299
#Final data frame 
Data <- cbind(data, subject,activity) # dim = 10299 81 (79 features + subject + activity)

#Assign column names
meanColNames <- as.character(features[,2][mean])
sdColNames <- as.character(features[,2][sd])
names(Data) <- c(meanColNames, sdColNames, "Subject", "Activity")

#Labels the activity
activity_labels <- read.table("activity_labels.txt")
activity_labels <- as.character(activity_labels[,2])
Data$Activity <- factor(Data$Activity, labels=activity_labels)
Data$Subject <- factor(Data$Subject, labels=as.character(c(1:30)))
 
#Function that return a tidy dataframe, with means of each variables for each activity for each subject
tidydata <- function(data) {
      #sort data according to subject and activity
      sorted <- data[order(data[,80]),]
      result <- data.frame()               
      colmeanData <- data.frame()
      #for loop, subset according to subject
      for (i in 1:30) {
            sub <- sorted[which(sorted[,80]==i),]
            act <- split(sub, sub[,81])
            colmean <- lapply(act, function(x) colMeans(x[,1:79]))
            result <- do.call(rbind,colmean)
            colmeanData <- rbind(colmeanData, result)
      }
      print(dim(colmeanData))
      write.table(colmeanData, "TidyData.txt", sep="\t", row.name=FALSE, col.name=FALSE)
}

tidydata(Data)
