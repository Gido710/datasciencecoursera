library(dplyr)
library(readr)
library(tidyr)

source("create_table.R")

# Initialize working directory to retrieve appropriate data

olddir <- file.path(getwd())
datadir <-"UCI HAR Dataset"
setwd(datadir)

#Create path names for training and test data

test_data = "test/X_test.txt"
test_activity = "test/y_test.txt"
test_participants = "test/subject_test.txt"
activity_label = "activity_labels.txt"

train_data = "train/X_train.txt"
train_activity = "train/y_train.txt"
train_participants = "train/subject_train.txt"

#Create data table for test, then train
#Compile test and train data tables into one table

data1 <- create_table(test_data, test_activity, test_participants)
data2 <- create_table(train_data, train_activity, train_participants)
full_data_tbl <- rbind(data1,data2)

#Retrieve legend for activity values

activity_label_tbl <- read.table(file = activity_label, header = FALSE, sep = "")

#Extract columns that only include mean()/std() or are the Participants/Activity columns
#Replace activity values with descriptive activity labels

full_data_tbl <- full_data_tbl[,grepl("Participants|Activity|[Ss][Tt][Dd][(][)]|[Mm][Ee][Aa][Nn][(][)]", colnames(data1))]
full_data_tbl$Activity <- sapply(full_data_tbl$Activity, function(x)(activity_label_tbl[x,2]))

#Cleanup of old data

rm(data1); rm(data2); rm(activity_label_tbl); setwd(olddir)

# Create corresponding tibble table
# Create a tidy table with corresponding means and descriptive variable names

tibble_data_tbl <- tibble(full_data_tbl)
tibble_data_tbl <- group_by(tibble_data_tbl, Participants, Activity)
tidy_tbl <- summarize(tibble_data_tbl, across(everything(), ~mean(.x), .names = "Mean: {.col}"))

#Cleanup tibble table

rm(tibble_data_tbl)

View(full_data_tbl)
View(tidy_tbl)
