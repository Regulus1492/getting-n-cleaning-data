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
#### **Required packages: plyr and dplyr**

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
To extract from the previous data set only the measurements on the mean and standard deviation for each measurement I use the *grep()* function and a code [[:punct:]]. The grep() functions allows me to select a stryng form the variables names. The function allows for bolean operators. The [[:punct:]] indicates that R should pick anything that has puntuation on it after the specified string. 


```r
db<-db[, grep("id|class|mean[[:punct:]]|std[[:punct:]])",names(db))]  
names(db)
```
The data base contains 68 variables and 10299 observations, the id variable and class variable are factors for the subjects and the different measured activities respectively, and the remaining 66 are the the measurements on the mean and standard deviation for each measurement. Mean() indicates mean, and std() is standard deviation. 

### Question 3
The descriptive activity names are in the previously created data frame *act* (see question 1 step b), which is used to name the activities in the data set. 
```R
library(plyr)
names<-c("class","class_ft")
act<-setNames(act,names)
db<-arrange(join(db,act),class); names(db)
#Rearrenge data set 
db<-db[c("class_ft",names(db[-69]))]; names(db)
class(db$class_ft) #"factor"
```
The variable *class_ft* contains the name of each activity. Notice that I check weather the *class_ft* variable (that contains the name of the factor class) is actually a factor variable. 

### Question 4

Since from Question 1 I have been working with a lebeled data set we only need to check wether the variable names are descriptive. 

```
names(db)
```

### Question 5
To create the tidy data set with the average of each variable for each activity and each subject I use the *dplyr* package. The group() functions groups the original data set into subject and activity and then using *summarise_each* I get the desired tidy data set. The *contain()* is a dplyr verb that selects the variables that contain the strings *mean()* and *std()*.   
```r
library(dplyr)
fdb<-db%>%
  group_by(id,class_ft)%>% 
  summarise_each(funs(mean(.,na.rm=TRUE)),contains("mean()"),contains("std()")) 
#na.rm=TRUE tells R to remove NA. The(.) is a shorcut for the dataset. 
```
### Final steps
```r
#Print data base
write.table(fdb,file="tidy_dat.txt",row.names=FALSE)

#Load data base to R. 
data<-read.table("./tidy_dat.txt",header=TRUE)
View(data)
```

## References
### General resources

* https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

### grep()

* http://stackoverflow.com/questions/24176448/subset-data-based-on-partial-match-of-column-names
 
### dplyr resources

* https://cran.r-project.org/web/packages/dplyr/dplyr.pdf
* https://www.youtube.com/watch?v=jWjqLW-u3hc&feature=youtu.be
* https://github.com/justmarkham/dplyr-tutorial/blob/master/dplyr-tutorial.Rmd
 
##NOTE:
I did this final Project for a previous session of the Getting and Cleaning data course, but this time I am applying to get a certificate. That is why the files appear as created a month ago. 


