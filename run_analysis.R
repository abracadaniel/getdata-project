require(plyr)

# 0. Download the dataset if its not there
downloadData = function() {
  if (!file.exists("data")) {
    dir.create("data")
  }
  
  if (!file.exists("data/UCI HAR Dataset")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "data/UCI_HAR_data.zip", method = "curl")
    unzip(zipfile, exdir="data")
  }
}

# 1. Merges the training and the test sets to create one data set.
mergeDatasets = function() {
  # Read test datasets
  X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
  
  # Read training datasets
  X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

  # Read features
  features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
  
  # Merge the datasets
  test_data <- cbind(cbind(X_test, subject_test), y_test)
  training_data <- cbind(cbind(X_train, subject_train), y_train)

  data <- rbind(training_data, test_data)
  names(data) <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
  
  data
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extractMeanStd = function(data) {
  data[,grepl("mean|std|Subject|ActivityId", names(data))]
}

# 3. Uses descriptive activity names to name the activities in the data set
nameActivities = function(data) {
  # Read the activity labels
  activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")
  
  # apply the activity label to the dataframe
  data$Activity <- sapply(data$ActivityId, function(x) { activities[(activities$V1 == x), ]$V2 })
  
  data
}

# 4. Appropriately labels the data set with descriptive variable names. 
appropriateLabels = function(data) {
  names(data) <- gsub("mean","Mean",names(data))
  names(data) <- gsub("std","StandardDeviation",names(data))
  names(data) <- gsub("Acc","Acceleration",names(data))
  names(data) <- gsub("Mag","Magnitude",names(data))
  names(data) <- gsub("Freq","Frequency",names(data))
  names(data) <- gsub("\\(\\)","",names(data))
  
  data
}

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
createTidy = function(data){
  ddply(data, c("Subject","Activity"), numcolwise(mean))
}

# Run the analysis
## First make sure the data is there
downloadData()

## 1
data <- mergeDatasets()

## 2
data <- extractMeanStd(data)

## 3
data <- nameActivities(data)

## 4
data <- appropriateLabels(data)

## 5
data <- createTidy(data)

## write the tidy dataset
write.table(data, "tidyData.txt", sep=",", row.names = FALSE)