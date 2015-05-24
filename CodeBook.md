# CodeBook

## Objective

This CodeBook describes the variables, the data, and any transformations or work performed to clean up the raw dataset "UCI HAR Dataset"

## Raw Dataset "UCI HAR Dataset"

The [original raw dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) can be downloaded in zip format. Please read the license before using it.

The dataset represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available in [uci.edu](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Tidy Dataset "UCI HAR Dataset"

The final tidy data set includes the average of each of the selected variables for each activity and each subject. The main steps from raw data to tidy dataset performed by the script are:

 1. Merge data originally distributed in 3 different files containing measured variables ("X_[test|train].txt"), id of each subject ("subject_[test|train].txt") and activity id ("y_[test|train].txt") to build a single table. This step is done for both test and train subjects
 2. Merge the observations for train subjects and test subjects into one table
 3. Select variables that include only the measurements on the mean and standard deviation for each measurement.
 4. Replace ids for activity names with the descriptive name of each of the six different activities in the data set
 5. Rename he variables names with human readable names
 6. Creating and writing to a file the described tidy dataset.
 

The dataset is written to disk with filename "tidy_dataset.txt" and includes 88 variables for 180 observations with a first row with columnames.

