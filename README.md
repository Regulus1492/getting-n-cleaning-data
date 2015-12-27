# getting-n-cleaning-data
Johns Hopkins’ Getting and Cleaning Data. 
## Final project
### Project Instructions 
(abstract from Coursera)

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available 
Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.

2.  Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Getting Started

### Question 1
a. Set working directory (wd) that contains data base
```c++
setwd("MyWorkingDirectory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset") #Notice last part of the wd
```
b.Store data base containg data "activity labels" (e.g.WALKING) and check its dimension
```r
act<-read.table("./activity_labels.txt"); dim(act) # [1] 6 2 #Activity labels
```
In order to check the number of variables we are dealing with, we might check the dimensions of the features data base. This data base will be useful later !!
```r
features<-read.table("./features.txt"); dim(features)#[1] 561   2
```


c. Using the cbind command, we create the data base on the 9 individuals used for testing combining three data sets: *subject_test.txt* that is a factor of the 9 individuals; *X_test.txt* that contains the actual measures of the 561 variables for the 9 individuals and *y_test.txt* that contains the class labels (activities. I.e walking, etc) 
```r
#Test
Test1<-read.table("./test/subject_test.txt") ;dim(Test1) #[1] 2947    1
Test2<-read.table("./test/X_test.txt"); dim(Test2) #[1] 2947  561
Test3<-read.table("./test/y_test.txt") ; dim(Test3) # [1] 2947    1 
Test<-cbind(Test1,Test3,Test2); dim(Test)#[1] 2947  563
```

d. Using the cbind command, we create the data base on the 21 individuals used for testing the data combining three data sets: *subject_test.txt* that is a factor of the 21 individuals; *X_train.txt* that contains the actual measures of the 561 variables for the 21 individuals and *y_train.txt* that contains the class labels (activities. I.e walking, etc) 

```r
#Train
Train1<-read.table("./train/subject_train.txt") ; dim(Train1) #[1] 7352    
Train2<-read.table("./train/X_train.txt") ; dim(Train2) #[1] 7352  561
Train3<-read.table("./train/y_train.txt") ; dim(Train3) #[1] 7352    1 
Train<-cbind(Train1,Train3,Train2); dim(Train) #[1] 7352  563
```

e. Combine Train and Test data sets into one data base using rbind
```r
db<-rbind(Test, Train); dim(db) #[1] 10299   563
```
f. Now I will take a step forward and name the variables according to their original label names, as they are descriptive. Notice the use of the *features* data set that we created in section b; now we use it to label the variables. 
```r
names<-c("id","class",as.character(features[,2]))
db<-setNames(db,names)
```

### Question 2

