#####################################################################################################
# 1.Merges the training and the test sets to create one data set.
# 
# Reading files for task 1
#####################################################################################################

test_data = read.table("UCI HAR Dataset/test/X_test.txt")
test_activity = read.table("UCI HAR Dataset/test/y_test.txt")
test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")
train_data = read.table("UCI HAR Dataset/train/X_train.txt")
train_activity = read.table("UCI HAR Dataset/train/y_train.txt")
train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")
activity_names = read.table("UCI HAR Dataset/activity_labels.txt")
feature_names = read.table("UCI HAR Dataset/features.txt")

#####################################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
# 
# Labeling the data set with descriptive variable names, removing (), ',', -,
# Giving descriptive names to acc, gyro, f, t, 
# Removing duplicate BodyBody
#####################################################################################################

features_names = feature_names[[2]]
anyDuplicated(features_names)
features_names = as.character(features_names)
features_names = make.unique(features_names)
anyDuplicated(features_names)

features_names = gsub("^f", "frequency", features_names)
features_names = gsub("^t", "time", features_names)
features_names = gsub("-([a-z])", "\\U\\1", features_names, perl=TRUE)
features_names = gsub(",([A-Z])", "\\1", features_names, perl=TRUE)
features_names = gsub("()", "", features_names, perl=TRUE)
features_names = gsub("\\(\\)", "", features_names, perl=TRUE)
features_names = gsub("\\)", "", features_names, perl=TRUE)
featuers_names = gsub("-", "", features_names, perl=TRUE)
features_names = gsub(",([0-9])", "\\.\\1", features_names, perl=TRUE)
features_names = gsub("\\(", "", features_names, perl=TRUE)
features_names = gsub("-", "", features_names, perl=TRUE)
features_names = gsub(",([a-z])", "\\U\\1", features_names, perl=TRUE)
features_names = gsub("BodyBody", "Body", features_names, perl=TRUE)
features_names = gsub("Acc", "Acceleration", features_names, perl=TRUE)
features_names = gsub("Std", "StandardDeviation", features_names, perl=TRUE)
features_names = gsub("Gyro", "Gyroscope", features_names, perl=TRUE)
features_names = gsub("Mag", "Magnitude", features_names, perl=TRUE)

#####################################################################################################
# 1.Merges the training and the test sets to create one data set.
#
# Merging training and test data sets X_train.txt + X_test.txt 
# Setting column names of merged data with names from faetures.txt
#####################################################################################################

total_data = rbind(train_data, test_data)
colnames(total_data) <- features_names

#####################################################################################################
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#
# using grep to get only those columns that contain mean or std from features.txt
# look I have changed std to StandardDeviation before grep in above steps
#####################################################################################################

total_data = total_data[,grep("Mean|StandardDeviation", names(total_data))]
colnames(total_data)

#####################################################################################################
# 1.Merges the training and the test sets to create one data set.
#
# Merging training and test data sets y_train.txt + y_test.txt 
#####################################################################################################

total_activity = rbind(train_activity, test_activity)
colnames(total_activity) <- "Activity"

#####################################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
#
# mapping names from activity_labels.txt to merged data from y_test.txt + y_train.txt
#####################################################################################################

code <- activity_names[[1]]
name <- activity_names[[2]]
total_activity = total_activity[[1]]

for (i in code) total_activity <- gsub(i, name[i], total_activity)

#####################################################################################################
# 1.Merges the training and the test sets to create one data set.
#
# Merging training and test data sets subject_train.txt + subject_test.txt 
#####################################################################################################

total_subject = rbind(train_subject, test_subject)
colnames(total_subject) <- "Subject"

###################################################i##################################################
# 1.Merges the training and the test sets to create one data set.
#
# Adding activity and subject columns to total data
#####################################################################################################

total_data$Activity = total_activity
total_data$Subject = total_subject$Subject

colnames(total_data)

install.packages("dplyr")
library(dplyr)

###################################################i##################################################
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# Using group_by and summarise_each function for finding average
# In final result I got 180 rows and 88 columns (86 columns with mean and std, I verified this manually using grep, 2 columns are "Activity" and "Subject") 
# Write data in the file name TidyData.txt
#####################################################################################################

final_data <- total_data %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

final_data
write.table(final_data, "UCI HAR Dataset/TidyData.txt", row.name=FALSE)

