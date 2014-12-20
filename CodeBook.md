# run_analysis.R

The script is divided into functions, each solving one of the assignments in the project:

downloadData() Checks if the data can be found in the data directory, if not it downloads and unzips
mergeDatasets() Merges the training and the test sets to create one data set.
extractMeanStd(data) Extracts only the measurements on the mean and standard deviation for each measurement. 
nameActivities(data) Uses descriptive activity names to name the activities in the data set
appropriateLabels(data) Appropriately labels the data set with descriptive variable names. 
createTidy(data) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The tidyData is exported to tidyData.csv

The script automatically performs the whole analysis once its loaded.

# The tidyData set
Is aggregated mean values of all mean and standard deviation values from the original data set grouped by activity and subject

For each row in the dataset is provieded

## Attributes
Activity label: different activites performed by the subject
- LAYING
- SITTING
- STANDING
- WALKING
- WALKING_DOWNSTAIR
- WALKING_UPSTAIRS

An identifier of the subject
Features containing StandardDeviation and Mean of different measurements on the X,Y and Z axis
