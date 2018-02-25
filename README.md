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
