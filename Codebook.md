## Codebook

This codebook describes the variables, data and the steps used for the project associated with Getting and Cleaning Data.


## Source of Data

Location of Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip Data Description of Data    : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## DataSet Information

Input Data Zip file present in the URL location specified above contains multiple files listed below.Only the files used in the project have been specified below.

test/X_test.txt:  Test Set having measurements data from 30% of volunteers
test/Y_test.txt:  Test Set having activity code data from 30% volunteers
test/subject_test.txt: Specifies the subject ids of 30% of volunteers who performed the activity for each window sample. Its range is from 1 to 30. 
train/X_train.txt: Training Set having measurements data from 70% of volunteers
train/Y_train.txt: Training Set having activity codes from 70% of volunteers. It can have values from 1 to 6.
train/subject_train.txt:Specifies the subject ids of 70% of volunteers who performed the activity for each window sample. Its range is from 1 to 30. 
activity_labels.txt:Links the class labels with their activity name.It holds these labels - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
features.txt:List of all features. Range of features is from -1 to +1.
features_info.txt:Shows information about the variables used on the feature vector
README.md: Gives overall information about the files and data.


## Data Transformation & Implementation Details

Data Transformation includes the following steps in run_analysis.R code - 

1.Merges the training and the test sets to create one data set.

  - Merges X_test.txt and X_train.txt. The resultant dataframe "merge_x_train_test" has dimensions as 10299 by 561 that is 10299 rows and 561 columns containing actual 
    measurements.
  - Merges Y_test.txt and Y_train.txt. The resultant dataframe "merge_y_train_test" has dimensions as 10299 by 1 that is 10299 rows and 1 column containing activity 
    codes.
  - Merges subject_test.txt and subject_train.txt. The resultant dataframe "merge_sub_train_test" has dimensions as 10299 by 1 that is 10299 rows and 1 column 
    containing subject ids.


2.Extracts only the measurements on the mean and standard deviation for each measurement.
  - Reads the features.txt file to get the 561 column names and assigns column names to "merge_x_train_test" dataframe.
  - Extracts only the mean and standard deviation columns containing those measurements which results in a dataframe "mean_or_std_mergedx" having 10299 rows and 66 
    columns.

3.Uses descriptive activity names to name the activities in the data set
  - Reads activity_labels.txt file and replaces the numeric activity codes 1,2,3,4,5,6 by WALKING
, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING
    LAYING
 respectively in the merged Y dataset "merge_y_train_test" dataframe.
  - Assigns a column name "Activity" to merged Y dataframe "merge_y_train_test".

4.Appropriately labels the data set with descriptive variable  names.
  - Removes hyphens and brackets() from the 66 column names of "mean_or_std_mergedx" dataframe.
  - Assigns the clean and descriptive variable names to those 66 columns in "mean_or_std_mergedx" dataframe.


5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Merges the subsetted X dataset(result of step 2 -"mean_or_std_mergedx") with the merged Y dataframe ("merge_y_train_test).This produces a dataframe "merge_xy" 67 
    columns as it adds an Activity column to the previous 66 columns.
  - Merges the "merge_xy" dataframe with merged suject dataframe "merge_sub_train_test" and the resultant dataframe "merge_xy_subject" contains 68 columns as it adds 
    one more subject column to the previous 67 columns.
  - Aggregate function is applied on this "merge_xy_subject" dataframe to produce the average of mean and standard deviations grouped by activity and subject.
  - Final dataset "finaldataset" is produced which has dimensions 180 by 68. There are 180 rows as there are 30 subjects and 6 activities. There are 68 columns out of 
    which 1st column is Activity, 2nd column is Subject and 3rd column onwards upto 68th column are the measurements showing th average of mean and standard
    deviation.
  - Finally the finaldataset is written to a text file "tidydataset.txt".





