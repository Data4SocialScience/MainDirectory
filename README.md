The run_analysis.R script merges the training and the test sets of the Human Activity Recognition Using Smartphones dataset and creates a tidy data set 
with the average of each variable for each activity and each subject.

The script first downloads and unzips the dataset, then reads in the necessary files using the read.table() function in R. It combines the test and training 
datasets using rbind(), and labels the columns with descriptive names using the features.txt file.

The script then extracts the mean and standard deviation measurements from the dataset using the grep() function, and subsets the dataset to include only these 
measurements using the column indices. It also adds descriptive activity names using the activity_labels.txt file, and cleans up the variable names to make them 
more readable.

Finally, the script groups the data by subject and activity using group_by(), and calculates the average of each variable for each group using summarise_all(). 
The resulting tidy dataset is then written to a text file using write.table().
