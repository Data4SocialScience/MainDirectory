# Load necessary packages
library(dplyr)

# Read in data
train_x <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/X_train.txt")
train_labels <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/y_train.txt")
test_x <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/X_test.txt")
test_labels <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/y_test.txt")

# Read subject ID
testing_subject <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/subject_test.txt")
training_subject <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/subject_train.txt")

# combine train and test data set with corresponding subject ID.
train_combined <- cbind (training_subject, train_x)
test_combined <- cbind(testing_subject, test_x)

# Combine training and test sets
x_data <- rbind(test_combined, train_combined)
# Combine labels
all_labels <- rbind(train_labels, test_labels)

# Read in activity labels
activity_labels <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/activity_labels.txt", col.names = c("code", "activity"))
key_names <- activity_labels$activity[match(all_labels$V1, activity_labels$code)]
key_names <- as.data.frame(key_names)
all_data <- cbind(key_names, x_data)


# Read column/variable names from features.txt
col_namess <- read.table("./Assignment 3/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/features.txt")
colnames(all_data)[3:563] <- col_namess$V2
colnames(all_data)[1:2] <- c("activity", "subject")


# Find column indices for mean and standard deviation measurements
mean_std_cols <- grep("mean|std", names(all_data))


# Subset data frame to include only mean and standard deviation measurements
#while also retaining first two columns i.e. activity and subject
mean_std_data <- all_data[, c(mean_std_cols, 1, 2)]


# Group data by subject and activity
grouped_data <- group_by(mean_std_data, subject, activity)

# Summarise data by taking the mean of each variable
tidy_data <- summarise_all(grouped_data, mean)

# Write tidy data to a text file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

