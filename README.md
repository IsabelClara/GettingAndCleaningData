# GettingAndCleaningData
week4

## Step 1: Merges the training and the test sets to create one data set.
The data set has been created from x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt. 
In order to create this data set intermetiate variables has been created:
x <- contains the merged x_train.txt and x_test.txt
y <- contains the merged y_train.txt and y_test.txt
sbj <- contains the merged subject_train.txt and subject_test.txt

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
From the data set created in step1, there have been selected the columns in which appears "mean" or "std" using grep

## Step 3: Uses descriptive activity names to name the activities in the data set
The second column of the data set from step1 contains the number of the activity. Each number correspond to a different activity.

# Step 4: Appropriately labels the data set with descriptive activity names.
The second column of the data set from step1 contains the number of the activity. This column has been converted into a factor and the names of the levels of this factor has been changed by the names that appear in the activity_labels.txt file.

## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The final data set has been created grouping the columns by the subject and the activity and the final data set has been saved.
