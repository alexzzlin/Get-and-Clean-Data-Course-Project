Merges the training and the test sets to create one data set.
-------------------------------------------------------------

### Merges the training to create one training data set.

1.  Read all training datasets including Training dataset, Training labels, subject training, and all the 9 Inertial Signals training data files.
2.  Read and clean up the features descriptions in the features text file to replace the default column names in the Training dataset.
3.  Apply column binding function *c**b**i**n**d*(...) to horizontally append all the training datasets into one big training dataset.
4.  Assign group "Train" to the one big training dataset, *t**r**a**i**n*\_*d**a**t**a**s**e**t*.

``` r
setwd("E:/Coursera/Specializations/Data_Science_JHU/C03_Get_Clean_Data/Project")
data_dir <- "./UCI HAR Dataset/train/Inertial Signals" 
train_files <- list.files(data_dir)
train_files
```

    ## [1] "body_acc_x_train.txt"  "body_acc_y_train.txt"  "body_acc_z_train.txt" 
    ## [4] "body_gyro_x_train.txt" "body_gyro_y_train.txt" "body_gyro_z_train.txt"
    ## [7] "total_acc_x_train.txt" "total_acc_y_train.txt" "total_acc_z_train.txt"

``` r
train_dir_files<-paste(data_dir, train_files, sep="/")

#cname <- lapply(as.character(train_files), function(file) { tools::file_path_sans_ext(file) })

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
```

    ## [1] 7352 1152

``` r
#summary(train_dataset)
#head(train_dataset)

# Read Subject data
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(train_subjects)<-"subject_id"
dim(train_subjects)
```

    ## [1] 7352    1

``` r
# Read Train data type file X_train.txt
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
dim(features)
```

    ## [1] 561   2

``` r
#cnames <- features$V2
#cnames <- c("tBodyAcc-arCoeff()-X,3","tBodyAcc-mean()-Y","tBodyAcc-std()-X")
cnames <- gsub("[()]", "",gsub("[-|,]", "_",features$V2))
#cnames
length(cnames)
```

    ## [1] 561

``` r
# Read Train data type file X_train.txt
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
dim(x_train)
```

    ## [1] 7352  561

``` r
colnames(x_train) <- cnames
#colnames(x_train)
# Read Train data type file y_train.txt
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
dim(y_train)
```

    ## [1] 7352    1

``` r
colnames(y_train) <- "activity_id"
unique(y_train$activity_id)
```

    ## [1] 5 4 6 1 3 2

``` r
y_train$group_id <- "Train"
dim(y_train)
```

    ## [1] 7352    2

``` r
train_dataset <- cbind(train_subjects,y_train,x_train,train_dataset)
dim(train_dataset)
```

    ## [1] 7352 1716

``` r
colnames(train_dataset)[1:5]
```

    ## [1] "subject_id"      "activity_id"     "group_id"        "tBodyAcc_mean_X"
    ## [5] "tBodyAcc_mean_Y"

### Merges the test sets to create one test data set.

1.  Read all testing datasets including Testing dataset, Testing labels, subject testing, and all the 9 Inertial Signals testing data files.
2.  Invoke the cleaned features descriptions from features text file to replace the default column names in the Testing dataset.
3.  Apply column binding function *c**b**i**n**d*(...) to horizontally append all the testing datasets into one big testing dataset.
4.  Assign group "Test" to the one big testing dataset, *t**e**s**t*\_*d**a**t**a**s**e**t*.

``` r
test_data_dir <- "./UCI HAR Dataset/test/Inertial Signals"
test_files <- list.files(test_data_dir)
test_files
```

    ## [1] "body_acc_x_test.txt"  "body_acc_y_test.txt"  "body_acc_z_test.txt" 
    ## [4] "body_gyro_x_test.txt" "body_gyro_y_test.txt" "body_gyro_z_test.txt"
    ## [7] "total_acc_x_test.txt" "total_acc_y_test.txt" "total_acc_z_test.txt"

``` r
test_dir_files<-paste(test_data_dir, test_files, sep="/")
test_dir_files
```

    ## [1] "./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt" 
    ## [2] "./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt" 
    ## [3] "./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt" 
    ## [4] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"
    ## [5] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"
    ## [6] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"
    ## [7] "./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"
    ## [8] "./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"
    ## [9] "./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"

``` r
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
```

    ## [1] 2947 1152

``` r
#summary(test_dataset)
#head(test_dataset)

test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
colnames(test_subjects)<-"subject_id"
dim(test_subjects)
```

    ## [1] 2947    1

``` r
# Read Test data type file X_test.txt
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
dim(x_test)
```

    ## [1] 2947  561

``` r
colnames(x_test) <- cnames
#colnames(x_test)
# Read Train data type file y_test.txt
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
dim(y_test)
```

    ## [1] 2947    1

``` r
unique(y_test)
```

    ##     V1
    ## 1    5
    ## 32   4
    ## 56   6
    ## 80   1
    ## 110  3
    ## 134  2

``` r
colnames(y_test) <- "activity_id"
y_test$group_id <- "Test"
dim(y_test)
```

    ## [1] 2947    2

``` r
test_dataset <- cbind(test_subjects,y_test,x_test,test_dataset)
dim(test_dataset)
```

    ## [1] 2947 1716

``` r
#colnames(test_dataset)[1:5]
```

### Merges the test sets to create one test data set.

-   Apply row binding function *r**b**i**n**d*(...) to stack up vertically both training dataset *t**r**a**i**n*\_*d**a**t**a**s**e**t* and testing dataset *t**e**s**t*\_*d**a**t**a**s**e**t* into one big dataset, *d**a**t**a**s**e**t*.

``` r
dataset <- rbind(train_dataset, test_dataset)
dim(dataset)
```

    ## [1] 10299  1716

``` r
colnames(dataset)[1:10]
```

    ##  [1] "subject_id"      "activity_id"     "group_id"       
    ##  [4] "tBodyAcc_mean_X" "tBodyAcc_mean_Y" "tBodyAcc_mean_Z"
    ##  [7] "tBodyAcc_std_X"  "tBodyAcc_std_Y"  "tBodyAcc_std_Z" 
    ## [10] "tBodyAcc_mad_X"

Extracts only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------------------

1.  Set key columns to keep, *k**e**y*\_*c**o**l**s*, including subject\_id, activity\_id and group\_id.
2.  Find columns *m**e**n**a*\_*c**o**l**s* related to the measurements on the mean for each measurement.
3.  Find columns *s**t**d*\_*c**o**l**s* related to the measurements on the standard deviation for each measurement.
4.  Subset the dataset with the columns included in the above three set of columns to keep.

``` r
#df_means_std <- dataset[,c(1:3,grep("_mean_|_mean$", names(dataset)), grep("std", names(dataset)))]
# This includes mean for frequency measurement
key_cols <- c(1:3)
mean_cols <- grep("_mean_|_mean|Mean", names(dataset))
std_cols <- grep("std", names(dataset))
df_means_std <- dataset[,c(key_cols, mean_cols, std_cols)]
colnames(df_means_std)
```

    ##  [1] "subject_id"                        
    ##  [2] "activity_id"                       
    ##  [3] "group_id"                          
    ##  [4] "tBodyAcc_mean_X"                   
    ##  [5] "tBodyAcc_mean_Y"                   
    ##  [6] "tBodyAcc_mean_Z"                   
    ##  [7] "tGravityAcc_mean_X"                
    ##  [8] "tGravityAcc_mean_Y"                
    ##  [9] "tGravityAcc_mean_Z"                
    ## [10] "tBodyAccJerk_mean_X"               
    ## [11] "tBodyAccJerk_mean_Y"               
    ## [12] "tBodyAccJerk_mean_Z"               
    ## [13] "tBodyGyro_mean_X"                  
    ## [14] "tBodyGyro_mean_Y"                  
    ## [15] "tBodyGyro_mean_Z"                  
    ## [16] "tBodyGyroJerk_mean_X"              
    ## [17] "tBodyGyroJerk_mean_Y"              
    ## [18] "tBodyGyroJerk_mean_Z"              
    ## [19] "tBodyAccMag_mean"                  
    ## [20] "tGravityAccMag_mean"               
    ## [21] "tBodyAccJerkMag_mean"              
    ## [22] "tBodyGyroMag_mean"                 
    ## [23] "tBodyGyroJerkMag_mean"             
    ## [24] "fBodyAcc_mean_X"                   
    ## [25] "fBodyAcc_mean_Y"                   
    ## [26] "fBodyAcc_mean_Z"                   
    ## [27] "fBodyAcc_meanFreq_X"               
    ## [28] "fBodyAcc_meanFreq_Y"               
    ## [29] "fBodyAcc_meanFreq_Z"               
    ## [30] "fBodyAccJerk_mean_X"               
    ## [31] "fBodyAccJerk_mean_Y"               
    ## [32] "fBodyAccJerk_mean_Z"               
    ## [33] "fBodyAccJerk_meanFreq_X"           
    ## [34] "fBodyAccJerk_meanFreq_Y"           
    ## [35] "fBodyAccJerk_meanFreq_Z"           
    ## [36] "fBodyGyro_mean_X"                  
    ## [37] "fBodyGyro_mean_Y"                  
    ## [38] "fBodyGyro_mean_Z"                  
    ## [39] "fBodyGyro_meanFreq_X"              
    ## [40] "fBodyGyro_meanFreq_Y"              
    ## [41] "fBodyGyro_meanFreq_Z"              
    ## [42] "fBodyAccMag_mean"                  
    ## [43] "fBodyAccMag_meanFreq"              
    ## [44] "fBodyBodyAccJerkMag_mean"          
    ## [45] "fBodyBodyAccJerkMag_meanFreq"      
    ## [46] "fBodyBodyGyroMag_mean"             
    ## [47] "fBodyBodyGyroMag_meanFreq"         
    ## [48] "fBodyBodyGyroJerkMag_mean"         
    ## [49] "fBodyBodyGyroJerkMag_meanFreq"     
    ## [50] "angletBodyAccMean_gravity"         
    ## [51] "angletBodyAccJerkMean_gravityMean" 
    ## [52] "angletBodyGyroMean_gravityMean"    
    ## [53] "angletBodyGyroJerkMean_gravityMean"
    ## [54] "angleX_gravityMean"                
    ## [55] "angleY_gravityMean"                
    ## [56] "angleZ_gravityMean"                
    ## [57] "tBodyAcc_std_X"                    
    ## [58] "tBodyAcc_std_Y"                    
    ## [59] "tBodyAcc_std_Z"                    
    ## [60] "tGravityAcc_std_X"                 
    ## [61] "tGravityAcc_std_Y"                 
    ## [62] "tGravityAcc_std_Z"                 
    ## [63] "tBodyAccJerk_std_X"                
    ## [64] "tBodyAccJerk_std_Y"                
    ## [65] "tBodyAccJerk_std_Z"                
    ## [66] "tBodyGyro_std_X"                   
    ## [67] "tBodyGyro_std_Y"                   
    ## [68] "tBodyGyro_std_Z"                   
    ## [69] "tBodyGyroJerk_std_X"               
    ## [70] "tBodyGyroJerk_std_Y"               
    ## [71] "tBodyGyroJerk_std_Z"               
    ## [72] "tBodyAccMag_std"                   
    ## [73] "tGravityAccMag_std"                
    ## [74] "tBodyAccJerkMag_std"               
    ## [75] "tBodyGyroMag_std"                  
    ## [76] "tBodyGyroJerkMag_std"              
    ## [77] "fBodyAcc_std_X"                    
    ## [78] "fBodyAcc_std_Y"                    
    ## [79] "fBodyAcc_std_Z"                    
    ## [80] "fBodyAccJerk_std_X"                
    ## [81] "fBodyAccJerk_std_Y"                
    ## [82] "fBodyAccJerk_std_Z"                
    ## [83] "fBodyGyro_std_X"                   
    ## [84] "fBodyGyro_std_Y"                   
    ## [85] "fBodyGyro_std_Z"                   
    ## [86] "fBodyAccMag_std"                   
    ## [87] "fBodyBodyAccJerkMag_std"           
    ## [88] "fBodyBodyGyroMag_std"              
    ## [89] "fBodyBodyGyroJerkMag_std"

``` r
dim(df_means_std)
```

    ## [1] 10299    89

Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------

1.  Read data file activity\_labels.txt
2.  Replace generic column name with activity\_id and activity\_label column names.
3.  Replace the underline character (\_) in the activity description with one sapce.
4.  Use merge function and the key *a**c**t**i**v**i**t**y*\_*i**d* to add the descriptive activity names to the dataset.

``` r
# Read data file activity_labels.txt
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
dim(activities)
```

    ## [1] 6 2

``` r
colnames(activities) <- c("activity_id", "activity_label")
activities$activity_label <- gsub("-|_", " ",activities$activity_label)
activities
```

    ##   activity_id     activity_label
    ## 1           1            WALKING
    ## 2           2   WALKING UPSTAIRS
    ## 3           3 WALKING DOWNSTAIRS
    ## 4           4            SITTING
    ## 5           5           STANDING
    ## 6           6             LAYING

``` r
colnames(df_means_std)[1:3]
```

    ## [1] "subject_id"  "activity_id" "group_id"

``` r
df_means_std <-merge(df_means_std, activities, by = "activity_id")
dim(df_means_std)
```

    ## [1] 10299    90

``` r
unique(df_means_std$activity_label)
```

    ## [1] "WALKING"            "WALKING UPSTAIRS"   "WALKING DOWNSTAIRS"
    ## [4] "SITTING"            "STANDING"           "LAYING"

Appropriately labels the data set with descriptive variable names.
------------------------------------------------------------------

1.  Get column names
2.  Expand abbreviations and clean up names
3.  Apply new labels as column names

``` r
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
```

    ## [1] 90

Create the tidy data set with the average of each variable for each activity and each subject
---------------------------------------------------------------------------------------------

-   group by subject and activity and summarise using mean

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
subject_activity_means <- df_means_std %>% 
  group_by(subject_id, activity_label) %>%
  summarise_if(is.numeric,mean) %>% 
  arrange(subject_id, activity_id)
colnames(subject_activity_means)
```

    ##  [1] "subject_id"                                                 
    ##  [2] "activity_label"                                             
    ##  [3] "activity_id"                                                
    ##  [4] "Time_DomainBodyAccelerometer_Mean_X"                        
    ##  [5] "Time_DomainBodyAccelerometer_Mean_Y"                        
    ##  [6] "Time_DomainBodyAccelerometer_Mean_Z"                        
    ##  [7] "Time_DomainGravityAccelerometer_Mean_X"                     
    ##  [8] "Time_DomainGravityAccelerometer_Mean_Y"                     
    ##  [9] "Time_DomainGravityAccelerometer_Mean_Z"                     
    ## [10] "Time_DomainBodyAccelerometerJerk_Mean_X"                    
    ## [11] "Time_DomainBodyAccelerometerJerk_Mean_Y"                    
    ## [12] "Time_DomainBodyAccelerometerJerk_Mean_Z"                    
    ## [13] "Time_DomainBodyGyroscope_Mean_X"                            
    ## [14] "Time_DomainBodyGyroscope_Mean_Y"                            
    ## [15] "Time_DomainBodyGyroscope_Mean_Z"                            
    ## [16] "Time_DomainBodyGyroscopeJerk_Mean_X"                        
    ## [17] "Time_DomainBodyGyroscopeJerk_Mean_Y"                        
    ## [18] "Time_DomainBodyGyroscopeJerk_Mean_Z"                        
    ## [19] "Time_DomainBodyAccelerometerMagnitude_Mean"                 
    ## [20] "Time_DomainGravityAccelerometerMagnitude_Mean"              
    ## [21] "Time_DomainBodyAccelerometerJerkMagnitude_Mean"             
    ## [22] "Time_DomainBodyGyroscopeMagnitude_Mean"                     
    ## [23] "Time_DomainBodyGyroscopeJerkMagnitude_Mean"                 
    ## [24] "FFT_DomainBodyAccelerometer_Mean_X"                         
    ## [25] "FFT_DomainBodyAccelerometer_Mean_Y"                         
    ## [26] "FFT_DomainBodyAccelerometer_Mean_Z"                         
    ## [27] "FFT_DomainBodyAccelerometer_MeanFrequency_X"                
    ## [28] "FFT_DomainBodyAccelerometer_MeanFrequency_Y"                
    ## [29] "FFT_DomainBodyAccelerometer_MeanFrequency_Z"                
    ## [30] "FFT_DomainBodyAccelerometerJerk_Mean_X"                     
    ## [31] "FFT_DomainBodyAccelerometerJerk_Mean_Y"                     
    ## [32] "FFT_DomainBodyAccelerometerJerk_Mean_Z"                     
    ## [33] "FFT_DomainBodyAccelerometerJerk_MeanFrequency_X"            
    ## [34] "FFT_DomainBodyAccelerometerJerk_MeanFrequency_Y"            
    ## [35] "FFT_DomainBodyAccelerometerJerk_MeanFrequency_Z"            
    ## [36] "FFT_DomainBodyGyroscope_Mean_X"                             
    ## [37] "FFT_DomainBodyGyroscope_Mean_Y"                             
    ## [38] "FFT_DomainBodyGyroscope_Mean_Z"                             
    ## [39] "FFT_DomainBodyGyroscope_MeanFrequency_X"                    
    ## [40] "FFT_DomainBodyGyroscope_MeanFrequency_Y"                    
    ## [41] "FFT_DomainBodyGyroscope_MeanFrequency_Z"                    
    ## [42] "FFT_DomainBodyAccelerometerMagnitude_Mean"                  
    ## [43] "FFT_DomainBodyAccelerometerMagnitude_MeanFrequency"         
    ## [44] "FFT_DomainBodyAccelerometerJerkMagnitude_Mean"              
    ## [45] "FFT_DomainBodyAccelerometerJerkMagnitude_MeanFrequency"     
    ## [46] "FFT_DomainBodyGyroscopeMagnitude_Mean"                      
    ## [47] "FFT_DomainBodyGyroscopeMagnitude_MeanFrequency"             
    ## [48] "FFT_DomainBodyGyroscopeJerkMagnitude_Mean"                  
    ## [49] "FFT_DomainBodyGyroscopeJerkMagnitude_MeanFrequency"         
    ## [50] "angletBodyAccelerometerMean_gravity"                        
    ## [51] "angletBodyAccelerometerJerkMean_gravityMean"                
    ## [52] "angletBodyGyroscopeMean_gravityMean"                        
    ## [53] "angletBodyGyroscopeJerkMean_gravityMean"                    
    ## [54] "angleX_gravityMean"                                         
    ## [55] "angleY_gravityMean"                                         
    ## [56] "angleZ_gravityMean"                                         
    ## [57] "Time_DomainBodyAccelerometer_StandardDeviation_X"           
    ## [58] "Time_DomainBodyAccelerometer_StandardDeviation_Y"           
    ## [59] "Time_DomainBodyAccelerometer_StandardDeviation_Z"           
    ## [60] "Time_DomainGravityAccelerometer_StandardDeviation_X"        
    ## [61] "Time_DomainGravityAccelerometer_StandardDeviation_Y"        
    ## [62] "Time_DomainGravityAccelerometer_StandardDeviation_Z"        
    ## [63] "Time_DomainBodyAccelerometerJerk_StandardDeviation_X"       
    ## [64] "Time_DomainBodyAccelerometerJerk_StandardDeviation_Y"       
    ## [65] "Time_DomainBodyAccelerometerJerk_StandardDeviation_Z"       
    ## [66] "Time_DomainBodyGyroscope_StandardDeviation_X"               
    ## [67] "Time_DomainBodyGyroscope_StandardDeviation_Y"               
    ## [68] "Time_DomainBodyGyroscope_StandardDeviation_Z"               
    ## [69] "Time_DomainBodyGyroscopeJerk_StandardDeviation_X"           
    ## [70] "Time_DomainBodyGyroscopeJerk_StandardDeviation_Y"           
    ## [71] "Time_DomainBodyGyroscopeJerk_StandardDeviation_Z"           
    ## [72] "Time_DomainBodyAccelerometerMagnitude_StandardDeviation"    
    ## [73] "Time_DomainGravityAccelerometerMagnitude_StandardDeviation" 
    ## [74] "Time_DomainBodyAccelerometerJerkMagnitude_StandardDeviation"
    ## [75] "Time_DomainBodyGyroscopeMagnitude_StandardDeviation"        
    ## [76] "Time_DomainBodyGyroscopeJerkMagnitude_StandardDeviation"    
    ## [77] "FFT_DomainBodyAccelerometer_StandardDeviation_X"            
    ## [78] "FFT_DomainBodyAccelerometer_StandardDeviation_Y"            
    ## [79] "FFT_DomainBodyAccelerometer_StandardDeviation_Z"            
    ## [80] "FFT_DomainBodyAccelerometerJerk_StandardDeviation_X"        
    ## [81] "FFT_DomainBodyAccelerometerJerk_StandardDeviation_Y"        
    ## [82] "FFT_DomainBodyAccelerometerJerk_StandardDeviation_Z"        
    ## [83] "FFT_DomainBodyGyroscope_StandardDeviation_X"                
    ## [84] "FFT_DomainBodyGyroscope_StandardDeviation_Y"                
    ## [85] "FFT_DomainBodyGyroscope_StandardDeviation_Z"                
    ## [86] "FFT_DomainBodyAccelerometerMagnitude_StandardDeviation"     
    ## [87] "FFT_DomainBodyAccelerometerJerkMagnitude_StandardDeviation" 
    ## [88] "FFT_DomainBodyGyroscopeMagnitude_StandardDeviation"         
    ## [89] "FFT_DomainBodyGyroscopeJerkMagnitude_StandardDeviation"

output to file "tidy\_data.txt"
-------------------------------

``` r
write.table(subject_activity_means, "tidy_data.txt", row.names = FALSE, quote = FALSE)
```
