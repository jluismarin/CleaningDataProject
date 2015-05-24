## The script bellow does the following steps in order to get a tidy dataset 
## with the average of each selected variable (the measurements on the mean and standard deviation) 
## for each activity and each subject:
##    (1) Merges the training and the test sets to create one data set.
##    (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
##    (3) Uses descriptive activity names to name the activities in the data set
##    (4) Appropriately labels the data set with descriptive variable names. 
##    (5) From the data set in step 4, creates a second, independent tidy data set with the average of each 
##        variable for each activity and each subject.


## Usage: 
##  (1) Run the script "run_analysis.R"
  
  
## Step 1: Merges the training and the test sets to create one data set.

path="./UCI HAR Dataset/"

## Load train data files
x_train <- read.table(paste0(path, "train/",  "X_train.txt"))
y_train <- read.table(paste0(path, "train/",  "y_train.txt"))
subject_train <- read.table(paste0(path, "train/", "subject_train.txt"))

## Load test data files
x_test <- read.table(paste0(path, "test/", "X_test.txt"))
y_test <- read.table(paste0(path, "test/", "y_test.txt"))
subject_test <- read.table(paste0(path, "test/", "subject_test.txt"))

## Load columnn names
features <- read.table(paste0(path, "features.txt"))

## Build train dataset
train_set <- cbind (subject_train, y_train, x_train)

## Build test dataset
test_set <- cbind (subject_test, y_test, x_test)

## Build merged dataset
temp_dataset <- rbind(test_set, train_set)

## Apply colum names
names(temp_dataset) = c("subject","activity", as.character(features[,2]))

## Clean objects
rm(x_train, y_train, subject_train, x_test, y_test, subject_test, train_set, test_set, features)


## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
##  with the also activity and subject
temp_dataset <- temp_dataset[names(temp_dataset)[grepl("subject|activity|mean|std", names(temp_dataset), ignore.case = TRUE)]]


## Step 3: Uses descriptive activity names to name the activities in the data set

## Load and rename columns for activity labels
activity_labels <- read.table(paste0(path, "activity_labels.txt"))
names(activity_labels)=c("id","activity")
temp_dataset$subject = as.factor(temp_dataset$subject)

## Merge main dataset and activity labels
temp_dataset <- merge(activity_labels, temp_dataset, by.x= "id", by.y = "activity", all=TRUE)
temp_dataset <- select(temp_dataset, 2:89)
rm (activity_labels)


## Step 4: Appropriately labels the data set with descriptive variable names. 

names(temp_dataset) <- gsub("^t","Time", names(temp_dataset))
names(temp_dataset) <- gsub("^f","Frequency", names(temp_dataset))
names(temp_dataset) <- gsub("-mean\\(\\)","Mean", names(temp_dataset))
names(temp_dataset) <- gsub("-std\\(\\)","Std", names(temp_dataset))
names(temp_dataset) <- gsub("Acc","Acceleration", names(temp_dataset))
names(temp_dataset) <- gsub("tBody","TimeBody", names(temp_dataset))
names(temp_dataset) <- gsub("BodyBody","Body", names(temp_dataset))
names(temp_dataset) <- gsub("Gyro","Gyroscope", names(temp_dataset))
names(temp_dataset) <- gsub("Mag","Magnitude", names(temp_dataset))
names(temp_dataset) <- gsub("gravity","Gravity", names(temp_dataset))


## Step 5: From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.

melted_dataset <- melt(temp_dataset, id=c("subject","activity"))
tidy_dataset <- dcast(melted_dataset, subject + activity ~ variable, mean)

rm(temp_dataset, melted_dataset)

write.table(tidy_dataset, file="tidy_dataset.txt", row.names = FALSE)
