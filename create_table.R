create_table <- function(data, activity_label, participants, feature_label = "features.txt"){
  
  #Retrieve Participant and Activity data, Feature Vector labels, and Feature Vectors
  #in that order
  
  participant_tbl <- read.table(file = participants, header = FALSE, sep = "\n")
  activity_label_tbl <- read.table(file = activity_label, header = FALSE, sep = "\n")
  feature_label_tbl <- read.table(file = feature_label, header = FALSE, sep = "")
  data_tbl <- read.table(file = data, header = FALSE, sep ="")
  
  #Compile all relevant data into a table
  #Insert appropriate columns labels
  
  collated_data <- cbind(participant_tbl, activity_label_tbl, data_tbl)
  colnames(collated_data) <- c("Participants", "Activity", feature_label_tbl[,2])
  
  #Cleanup
  
  rm(participant_tbl); rm(activity_label_tbl); rm(feature_label_tbl)
  
  # Return compiled table
  (collated_data)
}
