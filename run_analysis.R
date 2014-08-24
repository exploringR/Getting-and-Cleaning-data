## STEP 1 - Merges the training and the test sets to create one data set. 
##

## Read all the Training datasets

xtrain <- read.table("X_train.txt")         ## Read X training dataset
ytrain <- read.table("y_train.txt")         ## Read Y training dataset
subtrain <- read.table("subject_train.txt") ## Read subject training dataset

## Read all the Test datasets

xtest <- read.table("X_test.txt")           ## Read X test dataset
ytest <- read.table("y_test.txt")           ## Read Y test dataset
subtest <- read.table("subject_test.txt")   ## Read subject test dataset

## Merge training and test datasets

merge_x_train_test <- rbind(xtrain,xtest)         ## Merge X training and test dataset
merge_y_train_test <- rbind(ytrain,ytest)         ## Merge Y training and test dataset
merge_sub_train_test <- rbind(subtrain,subtest)   ## Merge subject training and test dataset


## STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
##

## Read the features.txt dataset and assign column names to merged X dataset

features <- read.table("features.txt")
colnames(merge_x_train_test) <- features[,2]

## Extract the mean and standard deviation measurements

subsetfeatures <- features[grep("(mean|std)\\(", features[,2]),] ## Get the mean and standard deviation column names from 								 ## features dataset
mean_or_std_mergedx <- merge_x_train_test[,subsetfeatures[,1]]   ## Get the actual values of mean and standard deviation


## step 3 Uses descriptive activity names to name the activities in the data set
##

## Read the activity_labels.txt file and replace the activity codes by activity label names 

activities <- read.table("activity_labels.txt")                 ## Read the activity labels dataset
merge_y_train_test[,1] = activities[merge_y_train_test[,1], 2]  ## Replace the activity code by labels
colnames(merge_y_train_test) <- "Activity"                      ## Assign column name to merged Y dataset as "Activity"


## step 4 Appropriately labels the data set with descriptive variable names.
## 

## Cleanup the column names to remove any ".", "-", "()" and label the dataset with 
## descriptive variable names

features_remove_hyphen <- gsub("-","",subsetfeatures$V2)        ## Remove hyphen from column names
features_remove_paren <- gsub("\\()","",features_remove_hyphen) ## Remove parenthesis() from column names

## Assign the modified descriptive column names to the original column names

colnames(mean_or_std_mergedx)  <-  features_remove_paren


## sTEP 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##

merge_xy <- cbind(mean_or_std_mergedx, merge_y_train_test)     ## Merge the subsetted X and Y datasets
colnames(merge_sub_train_test) <- "Subject"                    ## Assign a column name to merged subject dataset
merge_xy_subject <- cbind(merge_xy, merge_sub_train_test)      ## Merge the merged XY dataset with subject dataset
attach(merge_xy_subject)
tidyds <- aggregate(merge_xy_subject, by=list(Activity,Subject), FUN=mean)  ## Aggregate to find average of each mean and 															    ## standard deviation and group by activity and subject
			
## Drop duplicate columns produced by aggregate

keep_columns <- tidyds[c(1:68)]                          
colnames(keep_columns)[1] <- "Activity"
colnames(keep_columns)[2] <- "Subject"

finaldataset <- keep_columns

## Write the final dataset produced into a text file

write.table(finaldataset,"./tidydataset.txt",row.names=F)