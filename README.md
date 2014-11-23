Getting-and-Cleaning-Data
=========================
This is the R script for course project.
Working with data downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

unzip a folder: UCI HAR Dataset

R script: run_analysis.R should be put into the same folder 

What it do:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final TidyData.txt contains the average of each variable for each activity and each subject
The dimension of this dataset is (180,79)

30 Subject * 6 activity = 180 observations
46 mean measurements and 33 standard deviation measurements -> 79 columns

