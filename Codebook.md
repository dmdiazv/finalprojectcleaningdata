The run_analysis.R script performs all the data cleanin process. The process
containts 6 mayor Parts as described in the project’s definition file.

**Part 1** - Preliminary steps to answer questions 

Download and read the data
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign data and variables
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 

activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed by subjects 

codes (labels)

subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

x_test <- test/X_test.txt : 2947 rows, 561 columns
contains data of recorded features

y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities 

subject_train <- train/subject_train.txt : 7352 rows, 1 column
contains train data of volunteer subjects 

x_train <- test/X_train.txt : 7352 rows, 561 columns
contains data on recorded train features

y_train <- test/y_train.txt : 7352 rows, 1 columns
contains data on recorded train features

**Part 2** - Merges the training and the test data to obtain a single data set

X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function

Subject (10299 rows, 1 column) is created by merging subjects train and test by employing the rbind() function

Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X. It uses
the cbind() function

**Part 3** - Extracts the mean and standard deviation for each measurement

Tdy_Data (10299 rows, 88 columns) It is created by subsetting Merged_Data, selecting only columns: subject, code. Then, it is established the mean and standard deviation (std) for each measurement

**Part 4 **- Use descriptive activity names for Tdy_Data replacing numbers with activity name. This naming is possible by taking from second column of the activities variable

**Part 5** - Provide appropriate labels to Tdy_data with descriptive variable names

All Acc replaced to Accelerometer
All Gyro replaced to Gyroscope
All ^f replaced to Frequency
All ^t replaced to time
All Mag replaced to Magnitude
All BodyBody replaced to Body
All tBody replaced to TimeBody
All -mean() replaced to Mean
All -std() replaced to STD
All -freq() replaced to Frequency
All gravity replaced to Gravity
All angle replaced to Angle
and removes all periods (.) names(Tdy_data) <- gsub("\\.", "", names(Tdy_data))


**Part 6** Creates a second independent tidy data set using Tdy_Data with the average of each variable for each activity and each subject and then prints the data

Finaldataset (180 rows, 174 columns) is created by sumarizing Tdy_Data. The dataset
takes the means of each variable for each activity and each subject, after grouped by subject and activity.
Prints or exports the dataset into a Finaldataset.txt file.