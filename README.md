Project Overview
----------------

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms in wearable computing to attract new users. The goal is to prepare tidy data that can be used for later analysis from the various source data text files related to the experiments carried out over a group of 30 volunteers within an age bracket of 19-48 years using the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available via the link provided at the the course website.

Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.

Merges the training and the test sets to create one data set.
-------------------------------------------------------------

### Merges the training to create one training data set.

1.  Read all training datasets including Training dataset, Training labels, subject training, and all the 9 Inertial Signals training data files.
2.  Read and clean up the features descriptions in the features text file to replace the default column names in the Training dataset.
3.  Apply column binding function *c**b**i**n**d*(...) to horizontally append all the training datasets into one big training dataset.
4.  Assign group "Train" to the one big training dataset, *t**r**a**i**n*\_*d**a**t**a**s**e**t*.

### Merges the test sets to create one test data set.

1.  Read all testing datasets including Testing dataset, Testing labels, subject testing, and all the 9 Inertial Signals testing data files.
2.  Invoke the cleaned features descriptions from features text file to replace the default column names in the Testing dataset.
3.  Apply column binding function *c**b**i**n**d*(...) to horizontally append all the testing datasets into one big testing dataset.
4.  Assign group "Test" to the one big testing dataset, *t**e**s**t*\_*d**a**t**a**s**e**t*.

### Merges the test sets to create one test data set.

-   Apply row binding function *r**b**i**n**d*(...) to stack up vertically both training dataset *t**r**a**i**n*\_*d**a**t**a**s**e**t* and testing dataset *t**e**s**t*\_*d**a**t**a**s**e**t* into one big dataset, *d**a**t**a**s**e**t*.

Extracts only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------------------

1.  Set key columns to keep, *k**e**y*\_*c**o**l**s*, including subject\_id, activity\_id and group\_id.
2.  Find columns *m**e**n**a*\_*c**o**l**s* related to the measurements on the mean for each measurement.
3.  Find columns *s**t**d*\_*c**o**l**s* related to the measurements on the standard deviation for each measurement.
4.  Subset the dataset with the columns included in the above three set of columns to keep.

Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------

1.  Read data file activity\_labels.txt
2.  Replace generic column name with activity\_id and activity\_label column names.
3.  Replace the underline character (\_) in the activity description with one sapce.
4.  Use merge function and the key *a**c**t**i**v**i**t**y*\_*i**d* to add the descriptive activity names to the dataset.

Appropriately labels the data set with descriptive variable names.
------------------------------------------------------------------

1.  Get column names
2.  Expand abbreviations and clean up names
3.  Apply new labels as column names

Create the tidy data set with the average of each variable for each activity and each subject
---------------------------------------------------------------------------------------------

-   group by subject and activity and summarise using mean

output to file "tidy\_data.txt"
-------------------------------

Code Book
---------

For each record it is provided:

-   Mean of Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
-   Triaxial Angular velocity from the gyroscope.
-   mean of feature vectors with time and frequency domain variables.
-   standard deviation of feature vectors with time and fast fourier transformation domain variables.
-   Its activity label.
-   An identifier of the subject who carried out the experiment.

Code Book for data file tidy.data.txt and the 'tidy\_data.txt' Shows information of the average of each variable for each activity and each subject.

1.  subject\_id : unique identifier of an subject
2.  activity\_id : unique identifier of an activity
3.  activity\_label : Type of activities each person performed in the experiment (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)
4.  Time\_DomainBodyAccelerometer\_Mean\_X : Average of tBodyAcc-mean()-X
5.  Time\_DomainBodyAccelerometer\_Mean\_Y : Average of tBodyAcc-mean()-Y
6.  Time\_DomainBodyAccelerometer\_Mean\_Z : Average of tBodyAcc-mean()-Z
7.  Time\_DomainGravityAccelerometer\_Mean\_X : Average of tGravityAcc-mean()-X
8.  Time\_DomainGravityAccelerometer\_Mean\_Y : Average of tGravityAcc-mean()-Y
9.  Time\_DomainGravityAccelerometer\_Mean\_Z : Average of tGravityAcc-mean()-Z
10. Time\_DomainBodyAccelerometerJerk\_Mean\_X : Average of tBodyAccJerk-mean()-X
11. Time\_DomainBodyAccelerometerJerk\_Mean\_Y : Average of tBodyAccJerk-mean()-Y
12. Time\_DomainBodyAccelerometerJerk\_Mean\_Z : Average of tBodyAccJerk-mean()-Z
13. Time\_DomainBodyGyroscope\_Mean\_X : Average of tBodyGyro-mean()-X
14. Time\_DomainBodyGyroscope\_Mean\_Y : Average of tBodyGyro-mean()-Y
15. Time\_DomainBodyGyroscope\_Mean\_Z : Average of tBodyGyro-mean()-Z
16. Time\_DomainBodyGyroscopeJerk\_Mean\_X : Average of tBodyGyroJerk-mean()-X
17. Time\_DomainBodyGyroscopeJerk\_Mean\_Y : Average of tBodyGyroJerk-mean()-Y
18. Time\_DomainBodyGyroscopeJerk\_Mean\_Z : Average of tBodyGyroJerk-mean()-Z
19. Time\_DomainBodyAccelerometerMagnitude\_Mean : Average of tBodyAccMag-mean()
20. Time\_DomainGravityAccelerometerMagnitude\_Mean : Average of tGravityAccMag-mean()
21. Time\_DomainBodyAccelerometerJerkMagnitude\_Mean : Average of tBodyAccJerkMag-mean()
22. Time\_DomainBodyGyroscopeMagnitude\_Mean : Average of tBodyGyroMag-mean()
23. Time\_DomainBodyGyroscopeJerkMagnitude\_Mean : Average of tBodyGyroJerkMag-mean()
24. FFT\_DomainBodyAccelerometer\_Mean\_X : Average of fBodyAcc-mean()-X
25. FFT\_DomainBodyAccelerometer\_Mean\_Y : Average of fBodyAcc-mean()-Y
26. FFT\_DomainBodyAccelerometer\_Mean\_Z : Average of fBodyAcc-mean()-Z
27. FFT\_DomainBodyAccelerometer\_MeanFrequency\_X : Average of fBodyAcc-meanFreq()-X
28. FFT\_DomainBodyAccelerometer\_MeanFrequency\_Y : Average of fBodyAcc-meanFreq()-Y
29. FFT\_DomainBodyAccelerometer\_MeanFrequency\_Z : Average of fBodyAcc-meanFreq()-Z
30. FFT\_DomainBodyAccelerometerJerk\_Mean\_X : Average of fBodyAccJerk-mean()-X
31. FFT\_DomainBodyAccelerometerJerk\_Mean\_Y : Average of fBodyAccJerk-mean()-Y
32. FFT\_DomainBodyAccelerometerJerk\_Mean\_Z : Average of fBodyAccJerk-mean()-Z
33. FFT\_DomainBodyAccelerometerJerk\_MeanFrequency\_X : Average of fBodyAccJerk-meanFreq()-X
34. FFT\_DomainBodyAccelerometerJerk\_MeanFrequency\_Y : Average of fBodyAccJerk-meanFreq()-Y
35. FFT\_DomainBodyAccelerometerJerk\_MeanFrequency\_Z : Average of fBodyAccJerk-meanFreq()-Z
36. FFT\_DomainBodyGyroscope\_Mean\_X : Average of fBodyGyro-mean()-X
37. FFT\_DomainBodyGyroscope\_Mean\_Y : Average of fBodyGyro-mean()-Y
38. FFT\_DomainBodyGyroscope\_Mean\_Z : Average of fBodyGyro-mean()-Z
39. FFT\_DomainBodyGyroscope\_MeanFrequency\_X : Average of fBodyGyro-meanFreq()-X
40. FFT\_DomainBodyGyroscope\_MeanFrequency\_Y : Average of fBodyGyro-meanFreq()-Y
41. FFT\_DomainBodyGyroscope\_MeanFrequency\_Z : Average of fBodyGyro-meanFreq()-Z
42. FFT\_DomainBodyAccelerometerMagnitude\_Mean : Average of fBodyAccMag-mean()
43. FFT\_DomainBodyAccelerometerMagnitude\_MeanFrequency : Average of fBodyAccMag-meanFreq()
44. FFT\_DomainBodyAccelerometerJerkMagnitude\_Mean : Average of fBodyBodyAccJerkMag-mean()
45. FFT\_DomainBodyAccelerometerJerkMagnitude\_MeanFrequency : Average of fBodyBodyAccJerkMag-meanFreq()
46. FFT\_DomainBodyGyroscopeMagnitude\_Mean : Average of fBodyGyroMag-mean()
47. FFT\_DomainBodyGyroscopeMagnitude\_MeanFrequency : Average of fBodyGyroMag-meanFreq()
48. FFT\_DomainBodyGyroscopeJerkMagnitude\_Mean : Average of fBodyGyroJerkMag-mean()
49. FFT\_DomainBodyGyroscopeJerkMagnitude\_MeanFrequency : Average of fBodyGyroJerkMag-meanFreq()
50. angletBodyAccMean\_gravity : Average of angle(tBodyAccMean,gravity)
51. angletBodyAccJerkMean\_gravityMean: Average of angletBodyAccJerkMean\_gravityMean
52. angletBodyGyroscopeMean\_gravityMean: Average of angletBodyGyroMean\_gravityMean
53. angletBodyGyroscopeJerkMean\_gravityMean : Average of angletBodyGyroJerkMean\_gravityMean
54. angleX\_gravityMean : Average of angleX\_gravityMean
55. angleY\_gravityMean : Average of angleY\_gravityMean
56. angleZ\_gravityMean" : Average of angleZ\_gravityMean"
57. Time\_DomainBodyAccelerometer\_StandardDeviation\_X : Average of tBodyAcc-std()-X
58. Time\_DomainBodyAccelerometer\_StandardDeviation\_Y : Average of tBodyAcc-std()-Y
59. Time\_DomainBodyAccelerometer\_StandardDeviation\_Z : Average of tBodyAcc-std()-Z
60. Time\_DomainGravityAccelerometer\_StandardDeviation\_X : Average of tGravityAcc-std()-X
61. Time\_DomainGravityAccelerometer\_StandardDeviation\_Y : Average of tGravityAcc-std()-Y
62. Time\_DomainGravityAccelerometer\_StandardDeviation\_Z : Average of tGravityAcc-std()-Z
63. Time\_DomainBodyAccelerometerJerk\_StandardDeviation\_X : Average of tBodyAccJerk-std()-X
64. Time\_DomainBodyAccelerometerJerk\_StandardDeviation\_Y : Average of tBodyAccJerk-std()-Y
65. Time\_DomainBodyAccelerometerJerk\_StandardDeviation\_Z : Average of tBodyAccJerk-std()-Z
66. Time\_DomainBodyGyroscope\_StandardDeviation\_X : Average of tBodyGyro-std()-X
67. Time\_DomainBodyGyroscope\_StandardDeviation\_Y : Average of tBodyGyro-std()-Y
68. Time\_DomainBodyGyroscope\_StandardDeviation\_Z : Average of tBodyGyro-std()-Z
69. Time\_DomainBodyGyroscopeJerk\_StandardDeviation\_X : Average of tBodyGyroJerk-std()-X
70. Time\_DomainBodyGyroscopeJerk\_StandardDeviation\_Y : Average of tBodyGyroJerk-std()-Y
71. Time\_DomainBodyGyroscopeJerk\_StandardDeviation\_Z : Average of tBodyGyroJerk-std()-Z
72. Time\_DomainBodyAccelerometerMagnitude\_StandardDeviation : Average of tBodyAccMag-std()
73. Time\_DomainGravityAccelerometerMagnitude\_StandardDeviation : Average of tGravityAccMag-std()
74. Time\_DomainBodyAccelerometerJerkMagnitude\_StandardDeviation : Average of tBodyAccJerkMag-std()
75. Time\_DomainBodyGyroscopeMagnitude\_StandardDeviation : Average of tBodyGyroMag-std()
76. Time\_DomainBodyGyroscopeJerkMagnitude\_StandardDeviation : Average of tBodyGyroJerkMag-std()
77. FFT\_DomainBodyAccelerometer\_StandardDeviation\_X : Average of fBodyAcc-std()-X
78. FFT\_DomainBodyAccelerometer\_StandardDeviation\_Y : Average of fBodyAcc-std()-Y
79. FFT\_DomainBodyAccelerometer\_StandardDeviation\_Z : Average of fBodyAcc-std()-Z
80. FFT\_DomainBodyAccelerometerJerk\_StandardDeviation\_X : Average of fBodyAccJerk-std()-X
81. FFT\_DomainBodyAccelerometerJerk\_StandardDeviation\_Y : Average of fBodyAccJerk-std()-Y
82. FFT\_DomainBodyAccelerometerJerk\_StandardDeviation\_Z : Average of fBodyAccJerk-std()-Z
83. FFT\_DomainBodyGyroscope\_StandardDeviation\_X : Average of fBodyGyro-std()-X
84. FFT\_DomainBodyGyroscope\_StandardDeviation\_Y : Average of fBodyGyro-std()-Y
85. FFT\_DomainBodyGyroscope\_StandardDeviation\_Z : Average of fBodyGyro-std()-Z
86. FFT\_DomainBodyAccelerometerMagnitude\_StandardDeviation : Average of fBodyAccMag-std()
87. FFT\_DomainBodyAccelerometerJerkMagnitude\_StandardDeviation : Average of fBodyBodyAccJerkMag-std()
88. FFT\_DomainBodyGyroscopeMagnitude\_StandardDeviation : Average of fBodyGyroMag-std()
89. FFT\_DomainBodyGyroscopeJerkMagnitude\_StandardDeviation : Average of fBodyGyroJerkMag-std()
