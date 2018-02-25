# Getting and Cleaning Data Course Project
# author: "Alex Lin"
# date: "February 24, 2018"
##Merges the training and the test sets to create one data set.

###Merges the training to create one training data set.

#1. Read all training datasets including Training dataset, Training labels, subject training, and all the 9 Inertial Signals training data files.
#2. Read and clean up the features descriptions in the features text file to replace the default column names in the Training dataset.
#3. Apply column binding function $cbind(...)$ to horizontally append all the training datasets into one big training dataset.
#4. Assign group "Train" to the one big training dataset, $train\_dataset$.

setwd("E:/Coursera/Specializations/Data_Science_JHU/C03_Get_Clean_Data/Project")
data_dir <- "./UCI HAR Dataset/train/Inertial Signals" 
train_files <- list.files(data_dir)
train_files
train_dir_files<-paste(data_dir, train_files, sep="/")

if (exists("train_dataset")) { rm(train_dataset) }

for (filepath in train_dir_files) {
  # if the merged dataset doesn't exist, create it
  fname <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(filepath))
  vname <- substr(fname, 1, nchar(fname)-5)  # remove the string train
  if (!exists("train_dataset")) {
    # read.table by default knows how to handle data delimited by space or multiple spaces
    train_dataset <- read.table(filepath, header=FALSE)
    # This prepares numbered variable names
    cname <- paste(rep(vname,length(train_dataset)),seq(1:length(train_dataset)), sep="")
    colnames(train_dataset) <- cname
  }
   
  # if the merged train dataset does exist, append to it
  else {
    # read.table by default knows how to handle data delimited by space or multiple spaces
    temp_dataset <- read.table(filepath, header=FALSE)
    cname <- paste(rep(vname,length(temp_dataset)),seq(1:length(temp_dataset)), sep="")
    colnames(temp_dataset) <- cname
    train_dataset<-cbind(train_dataset, temp_dataset)
    rm(temp_dataset)
  }
}

#str(train_dataset)
#class(train_dataset)
#length(train_dataset)
dim(train_dataset)
#summary(train_dataset)
#head(train_dataset)

# Read Subject data
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(train_subjects)<-"subject_id"
dim(train_subjects)

# Read Train data type file X_train.txt
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
dim(features)
#cnames <- features$V2
#cnames <- c("tBodyAcc-arCoeff()-X,3","tBodyAcc-mean()-Y","tBodyAcc-std()-X")
cnames <- gsub("[()]", "",gsub("[-|,]", "_",features$V2))
#cnames
length(cnames)

# Read Train data type file X_train.txt
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
dim(x_train)
colnames(x_train) <- cnames
#colnames(x_train)
# Read Train data type file y_train.txt
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
dim(y_train)
colnames(y_train) <- "activity_id"
unique(y_train$activity_id)
y_train$group_id <- "Train"
dim(y_train)

train_dataset <- cbind(train_subjects,y_train,x_train,train_dataset)
dim(train_dataset)
colnames(train_dataset)[1:5]

###Merges the test sets to create one test data set.

#1. Read all testing datasets including Testing dataset, Testing labels, subject testing, and all the 9 Inertial Signals testing data files.
#2. Invoke the cleaned features descriptions from features text file to replace the default column names in the Testing dataset.
#3. Apply column binding function $cbind(...)$ to horizontally append all the testing datasets into one big testing dataset.
#4. Assign group "Test" to the one big testing dataset, $test\_dataset$.

test_data_dir <- "./UCI HAR Dataset/test/Inertial Signals"
test_files <- list.files(test_data_dir)
test_files
test_dir_files<-paste(test_data_dir, test_files, sep="/")
test_dir_files

if (exists("test_dataset")) { rm(test_dataset) }

for (filepath in test_dir_files) {
  # if the merged dataset doesn't exist, create it
  fname <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(filepath))
  vname <- substr(fname, 1, nchar(fname)-4)  # remove the string test
  if (!exists("test_dataset")) {
    # read.table by default knows how to handle data delimited by space or multiple spaces
    test_dataset <- read.table(filepath, header=FALSE)
    # This prepares numbered variable names
    cname <- paste(rep(vname,length(test_dataset)),seq(1:length(test_dataset)), sep="")
    colnames(test_dataset) <- cname
  }
   
  # if the merged test dataset does exist, append to it
  else {
    # read.table by default knows how to handle data delimited by space or multiple spaces
    temp_dataset <- read.table(filepath, header=FALSE)
    cname <- paste(rep(vname,length(temp_dataset)),seq(1:length(temp_dataset)), sep="")
    colnames(temp_dataset) <- cname
    test_dataset<-cbind(test_dataset, temp_dataset)
    rm(temp_dataset)
  }
}

#str(test_dataset)
#class(test_dataset)
#length(test_dataset)
dim(test_dataset)
#summary(test_dataset)
#head(test_dataset)

test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
colnames(test_subjects)<-"subject_id"
dim(test_subjects)

# Read Test data type file X_test.txt
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
dim(x_test)
colnames(x_test) <- cnames
#colnames(x_test)
# Read Train data type file y_test.txt
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
dim(y_test)
unique(y_test)
colnames(y_test) <- "activity_id"
y_test$group_id <- "Test"
dim(y_test)

test_dataset <- cbind(test_subjects,y_test,x_test,test_dataset)
dim(test_dataset)
#colnames(test_dataset)[1:5]

### Merges the test sets to create one test data set.
# Apply row binding function $rbind(...)$ to stack up vertically both training dataset $train\_dataset$ and testing dataset $test\_dataset$ into one big dataset, $dataset$.

dataset <- rbind(train_dataset, test_dataset)
dim(dataset)
colnames(dataset)[1:10]

## Extracts only the measurements on the mean and standard deviation for each measurement.

#1. Set key columns to keep, $key\_cols$, including subject_id, activity_id and group_id.
#2. Find columns $mena\_cols$ related to the measurements on the mean for each measurement.
#3. Find columns $std\_cols$ related to the measurements on the standard deviation for each measurement.
#4. Subset the dataset with the columns included in the above three set of columns to keep.

# This includes mean for frequency measurement
key_cols <- c(1:3)
mean_cols <- grep("_mean_|_mean|Mean", names(dataset))
std_cols <- grep("std", names(dataset))
df_means_std <- dataset[,c(key_cols, mean_cols, std_cols)]
colnames(df_means_std)
dim(df_means_std)

## Uses descriptive activity names to name the activities in the data set

#1. Read data file activity_labels.txt
#2. Replace generic column name with activity_id and activity_label column names.
#3. Replace the underline character ($\_$) in the activity description with one sapce.
#4. Use merge function and the key $activity\_id$ to add the descriptive activity names to the dataset.

# Read data file activity_labels.txt
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
dim(activities)
colnames(activities) <- c("activity_id", "activity_label")
activities$activity_label <- gsub("-|_", " ",activities$activity_label)
activities
colnames(df_means_std)[1:3]
df_means_std <-merge(df_means_std, activities, by = "activity_id")
dim(df_means_std)
unique(df_means_std$activity_label)

## Appropriately labels the data set with descriptive variable names.

#1. Get column names
#2. Expand abbreviations and clean up names
#3. Apply new labels as column names

# Get column names
activityColumns <- colnames(df_means_std)

# Expand abbreviations and clean up names
activityColumns <- gsub("^t", "Time_Domain", activityColumns)
activityColumns <- gsub("^f", "FFT_Domain", activityColumns)
activityColumns <- gsub("Acc", "Accelerometer", activityColumns)
activityColumns <- gsub("Gyro", "Gyroscope", activityColumns)
activityColumns <- gsub("Mag", "Magnitude", activityColumns)
activityColumns <- gsub("Freq", "Frequency", activityColumns)
activityColumns <- gsub("mean", "Mean", activityColumns)
activityColumns <- gsub("std", "StandardDeviation", activityColumns)
activityColumns <- gsub("BodyBody", "Body", activityColumns)

# Apply new labels as column names
colnames(df_means_std) <- activityColumns
length(activityColumns)

## Create the tidy data set with the average of each variable for each activity and each subject

#* group by subject and activity and summarise using mean

library(dplyr)
subject_activity_means <- df_means_std %>% 
  group_by(subject_id, activity_label) %>%
  summarise_if(is.numeric,mean) %>% 
  arrange(subject_id, activity_id)
colnames(subject_activity_means)

## output to file "tidy_data.txt"

write.table(subject_activity_means, "tidy_data.txt", row.names = FALSE, quote = FALSE)
