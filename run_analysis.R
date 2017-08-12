library(reshape2)

#Read the data
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
sub_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
sub_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')

#Step 1
# add names for subject, measurment, labels.
names(sub_train) <- "subject"
names(sub_test) <- "subject"
features <- read.table('./UCI HAR Dataset/features.txt')
names(x_train) <- features$V2
names(x_test) <- features$V2
names(y_train) <- "activity"
names(y_test) <- "activity"

# combine files into one dataset
train <- cbind(sub_train, y_train, x_train)
test <- cbind(sub_test, y_test, x_test)
combined <- rbind(train, test)

#Step 2
# determine which columns contain mean or std
mscols <- grepl("mean\\(\\)", names(combined)) | grepl("std\\(\\)", names(combined))

# remove other columns
mscols[1:2] <- TRUE
combined_ms <- combined[, mscols]

#Step 3 & 4
#Uses descriptive activity names to name the activities in the data set.

combined_ms$activity <- factor(combined_ms$activity, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

#Step 5
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# create the tidy data set
melted <- melt(combined_ms, id=c("subject","activity"))
tidy <- dcast(melted, subject+activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidy, "tidy.txt", row.names=FALSE)
