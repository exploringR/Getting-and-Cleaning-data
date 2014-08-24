
•Step 1: Download and unzip the zip file to get data for analysis (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) to a folder on your pc. Example - "C:\Users\Myname\Documents\Coursera\Gettingandcleaningdata\Project\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset"


•Step 2: Put the run_analysis.R file to "C:\Users\Myname\Documents\Coursera\Gettingandcleaningdata\Project\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset"


•Step 3: Open R studio and set working directory using setwd() command to "C:\Users\Myname\Documents\Coursera\Gettingandcleaningdata\Project\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset"


•Step 4: Source and run the run_analysis.R code using command source("run_analysis.R") in RStudio


•Step 5: Once the run_analysis.R script runs, it will produce the final tidy dataset which comprises of 180 rows and 68 columns. One additional row on the top will show the column names as well.

The name of the dataset produced is tidydataset.txt. 

Following are the steps which the R code will perform - 

a. Merges the X training and test datasets, Y training and test datasets and subject train and test datasets to create 3 different merged datasets respectively.

b. Extracts only the measurements on the mean and standard deviation for each measurement.
   
   A total of 66 columns with mean and standard deviation measurements are extracted for this step. 
   
   Note - 
 
   Only the column names having strings "mean()" or "std()" in the variable names have been considered for extraction of mean and standard deviation measurements,         hence only 66 columns with mean and standard deviation measurements are extracted.
 
   Example - 
   tBodyAcc-mean()-X   has been considered as it has a string "mean()" embedded in the variable name.
   fBodyAcc-meanFreq()-X has not been considered as it does not have  a mean() string but has "meanFreq()" embedded in the variable name.


c. Assigns descriptive activity names to name the activities in the data set.
   To achieve this, R code reads the activity_labels.txt file into R and replaces all the numeric activity codes by descriptive activity labels.

d. Appropriately labels the data set with descriptive variable names.
   The 66 variable names obtained from features.txt in step 2 have been cleaned up to remove hyphens and parenthesis using gsub command and clean descriptive variable 
   names have been assigned to the columns.

e. Creates a second, independent tidy data set [tidydataset.txt] with the average of each variable for each activity and each subject.
   Aggregate function has been  used to find out the average of each mean and standard deviation variables grouped by activity and subject.

   Note -
   Final output file "tidydataset.txt" has 180 rows and 68 columns. 
   There is one row for each activity and subject combination and there are a total of 66 mean or standard deviation columns for each combination plus 1 activity 
   column and 1 subject column.