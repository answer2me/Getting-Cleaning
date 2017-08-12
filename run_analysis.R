#Read the data
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
sub_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
sub_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')


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
