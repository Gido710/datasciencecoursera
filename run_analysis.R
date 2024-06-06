library(dplyr)
library(readr)
library(tidyr)

source("create_table.R")

olddir <- file.path(getwd())
datadir <-"UCI HAR Dataset"
setwd(datadir)

test_data = "test/X_test.txt"
test_activity = "test/y_test.txt"
test_participants = "test/subject_test.txt"
activity_label = "activity_labels.txt"

train_data = "train/X_train.txt"
train_activity = "train/y_train.txt"
train_participants = "train/subject_train.txt"

data1 <- create_table(test_data, test_activity, test_participants)
data2 <- create_table(train_data, train_activity, train_participants)
full_data_tbl <- rbind(data1,data2)

activity_label_tbl <- read.table(file = activity_label, header = FALSE, sep = "")

full_data_tbl <- full_data_tbl[,grepl("Participants|Activity|[Ss][Tt][Dd][(][)]|[Mm][Ee][Aa][Nn][(][)]", colnames(data1))]
full_data_tbl$Activity <- sapply(full_data_tbl$Activity, function(x)(activity_label_tbl[x,2]))
                                 
rm(data1); rm(data2); rm(activity_label_tbl); setwd(olddir)

tibble_data_tbl <- tibble(full_data_tbl)
tibble_data_tbl <- group_by(tibble_data_tbl, Participants, Activity)
tidy_tbl <- summarize(tibble_data_tbl, across(everything(), ~mean(.x), .names = "Mean: {.col}"))

rm(tibble_data_tbl)

View(full_data_tbl)
View(tidy_tbl)
