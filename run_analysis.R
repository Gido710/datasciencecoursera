#  file:  run_analysis.R
#  "Getting and Cleaning Data" Course Capstone
#
#  Objectives
#  The purpose of this project is to demonstrate your ability to collect, work 
#  with, and clean a data set. The goal is to prepare tidy data that can be used 
#  for later analysis. You will be graded by your peers on a series of yes/no 
#  questions related to the project. You will be required to submit: 1) a tidy
#  data set as described below, 2) a link to a Github repository with your script 
#  for performing the analysis, and 3) a code book that describes the variables, 
#  the data, and any transformations or work that you performed to clean up the 
#  data called CodeBook.md. You should also include a README.md in the repo with 
#  your scripts. This repo explains how all of the scripts work and how they are 
#  connected.
#
#  One of the most exciting areas in all of data science right now is wearable 
#  computing - see for example this article . Companies like Fitbit, Nike, and 
#  Jawbone Up are racing to develop the most advanced algorithms to attract new 
#  users. The data linked to from the course website represent data collected 
#  from the accelerometers from the Samsung Galaxy S smartphone. A full description
#  is available at the site where the data was obtained:
#  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#  Here are the data for the project:
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#
#  You should create one R script called run_analysis.R that does the following. 
#
#  1. Merges the training and the test sets to create one data set.
#
#  2. Extracts only the measurements on the mean and standard deviation for each 
#     measurement. 
#
#  3. Uses descriptive activity names to name the activities in the data set
# 
#  4. Appropriately labels the data set with descriptive variable names. 
#
#  5. From the data set in step 4, creates a second, independent tidy data set
#     with the average of each variable for each activity and each subject.
#
#  Good luck!
#  
#-------------------------------------------------------------------------------  
#                       HELPER FUNCTIONS
#-------------------------------------------------------------------------------
#
#  Data Background from README:
#  ============================
#
#  For each record it is provided:
#  ======================================
#  
#  - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
#  - Triaxial Angular velocity from the gyroscope. 
#  - A 561-feature vector with time and frequency domain variables. 
#  - Its activity label. 
#  - An identifier of the subject who carried out the experiment
#
#  Load and categorize data
#
# filedir = "./UCI HAR Dataset/test/X_test.txt"
# file.exists("./UCI HAR Dataset/test/X_test.txt")
# 
library(dplyr)

#-------------------------------------------------------------------------------
#                      GET_DATA
#-------------------------------------------------------------------------------
#  This Function loads the raw accelerometer data (X_train, etc) and the 
#  outcome data (y_train).  It combines test and train  vertically and adds 
#  the outcome data
#  It looks for the data relative the working directory at:
#  DIR: ./UCI HAR Dataset/*
#  with the test and train data in the subdirectories:
#  ./UCI HAR Dataset/train, ./UCI HAR Dataset/test
#  the function also:
#  1.  cleans the column names
#  2.  cuts back to averages and standard deviations
#

get_data <- function() {
  features <- read.table("./UCI HAR Dataset/features.txt", sep= ' ')
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt", sep= ' ')
  X_train <- read.fwf("./UCI HAR Dataset/train/X_train.txt",widths=rep(16,561))
  y_train <- read.fwf("./UCI HAR Dataset/train/y_train.txt",widths=c(1))
  y_train <- merge(y_train, activities)
  colnames(y_train) <- c('activity_code','activity')
  X_test <- read.fwf("./UCI HAR Dataset/test/X_test.txt",widths=rep(16,561))
  y_test <- read.fwf("./UCI HAR Dataset/test/y_test.txt",widths=c(1)) 
  y_test <- merge(y_test, activities)  
  colnames(y_test) <- c('activity_code','activity')
  colnames_x <- features[,2] %>%
    gsub(pattern='()',replacement='', fixed = TRUE) %>%
    gsub(pattern='-',replacement='_') %>%
    gsub(pattern=',',replacement='_') %>%
    gsub(pattern='(',replacement='_', fixed= TRUE) %>%
    gsub(pattern=')',replacement='', fixed=TRUE)
  colnames(X_train) <- colnames_x
  colnames(X_test) <- colnames_x
  list_of_cols <- grepl('mean', features[,2], ignore.case ="True") 
  list_of_cols <- list_of_cols | grepl('std', features[,2], ignore.case ="True")
  X_train_means <- X_train[,list_of_cols]
  X_train_means <- cbind(X_train_means, y_train)
  X_test_means <- X_test[,list_of_cols ]
  X_test_means <- cbind(X_test_means, y_test)
  X_train_means['test_or_train'] <- 'train'
  X_test_means['test_or_train'] <- 'test'
  X_union_means <-rbind(X_train_means, X_test_means)
}


get_summary <- function(df) {
  sum_df <- df %>% 
    group_by(activity_code,activity,test_or_train) %>% 
    summarise_at(vars(colnames(df)[1:86]), mean) %>% 
    ungroup() %>% 
    as.data.frame()
  colnames(sum_df)[4:89] <- gsub('^f', 'frequency', colnames(sum_df)[4:89])
  colnames(sum_df)[4:89] <- gsub('^t', 'time', colnames(sum_df)[4:89])
  colnames(sum_df)[4:89] <- sub('angle_t', 'angle_time', colnames(sum_df)[4:89])
  sum_df
}

write_data_set <- function(df, name = 'summary_data.csv'){
  summary_df <- write.csv(df,name,row.names = FALSE)
}

#-------------------------------------------------------------------------------
#                      RUN_ANALYSIS
#-------------------------------------------------------------------------------

if (exists('clean_df')) {} else {clean_df <- get_data()}
if (exists('summary_df')) {} else {summary_df <- get_summary(clean_df)}   
summary_df
