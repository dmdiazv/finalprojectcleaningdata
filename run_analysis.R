
### Coursera Data science specialisation#### 

#Getting and cleaning data assignment#

############### PART 1. PRELIMINARY STEPS TO ADDRESS QUESTIONS #################

##Step 1. Installing and Loading packages
install.packages("tidyverse")
install.packages("magrittr")
library("tidyverse")
library("magrittr")

###Step 2. Getting the data and unzipping

file <- "coursera_course3final.zip"
if (!file.exists(file)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, file, method = "curl")
}

if(!file.exists("UCI HAR DATASET")){
  unzip(file)
}
#### Step 3. Importing information

### Importing activity names - Table 1

activity_labels <- utils::read.table("UCI HAR Dataset/activity_labels.txt", 
                                     header = FALSE, col.names = c("code", "activity"))
activity_labels

### Importing feature names - Table 2

features <- utils::read.table(file="UCI HAR Dataset/features.txt",
                              sep = "",
                              stringsAsFactors = FALSE,
                              header = FALSE,
                              col.names = c("n", "functions"))

### Importing subject tests - Table 3

subject_test <- utils::read.table("UCI HAR Dataset/test/subject_test.txt",
                                  header = FALSE, col.names = "subject")

### Importing X and Y tests data - Tables 4 & 5 
## (Caution! - Use capital X when reading file)

x_test <- utils::read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE,
                            col.names = features$functions)
y_test <- utils::read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE,
                            col.names = "code")

###Importing subject tain - Table 6

subject_train <- utils::read.table("UCI HAR Dataset/train/subject_train.txt",
                                   header = FALSE, col.names = "subject")

### Importing X and Y train data - Tables 7 & 8 
## (Caution! - use capital X when reading file)

x_train <- utils::read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE,
                             col.names = features$functions)
y_train <- utils::read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE,
                             col.names = "code")

#############PART 2. Addressing Q1. MERGE DATA TO GET ONE DATASET #############

#### Step 4. Merge train and test data

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(subject, y, x)
View(Merged_Data)

#############PART 3. Addressing Q2. EXTRACT MEAN AND STD########################

#### Step 5. Obtaining mean and std from data

Tdy_data <- Merged_Data %>% select(
  subject,
  code,
  contains("mean"),
  contains("std"))

View(Tdy_data)

#############PART 4. Addressing Q3. USE DESCRIPTIVE ACTIVITY NAMES #############


#### Step 6. Use descriptive activity names to name data set activities

Tdy_data$code <- activity_labels[Tdy_data$code, 2]
View(Tdy_data$code)

#############PART 5. Addressing Q4. APPROPIATE NAMES FOR DATA ##################

### Step 7. Provide appropiate labels to Tidy data

names(Tdy_data)[2] = "activity"
names(Tdy_data) <- gsub("Acc", "Accelerometer", names(Tdy_data))
names(Tdy_data) <- gsub("Gyro", "Gyroscope", names(Tdy_data))
names(Tdy_data) <- gsub("^f", "Frequency", names(Tdy_data))
names(Tdy_data) <- gsub("^t", "Time", names(Tdy_data))
names(Tdy_data) <- gsub("Mag", "Magnitude", names(Tdy_data))
names(Tdy_data) <- gsub("BodyBody", "Body", names(Tdy_data))
names(Tdy_data) <- gsub("tBody", "TimeBody", names(Tdy_data))
names(Tdy_data) <- gsub("-mean()", "Mean", names(Tdy_data), ignore.case = TRUE)
names(Tdy_data) <- gsub("-std()", "STD", names(Tdy_data), ignore.case = TRUE)
names(Tdy_data) <- gsub("-freq()", "Frequency", names(Tdy_data), ignore.case = TRUE)
names(Tdy_data) <- gsub("gravity", "Gravity", names(Tdy_data))
names(Tdy_data) <- gsub("angle", "Angle", names(Tdy_data))
names(Tdy_data) <- gsub("\\.", "", names(Tdy_data))
View(Tdy_data)

########PART 6. Addressing  Q5. SECOND INDEPENDENT DATA SET WITH AV AND STD #####

#### Step 8. Creating a second dataset from Tdy_data with the average 
##of each variable/column

Finaldataset <- Tdy_data %>% 
  group_by(subject, activity) %>%
  summarise_all(list(mean, median))

View(Finaldataset)

#### Step 9. Print Final dataset

write.table(Finaldataset, "Finaldataset.txt", row.names = FALSE)
