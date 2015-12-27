##FINAL PROJECT##


##Select WD

setwd(MyDyrectory)

#Required packages
install.packages('plyr')
install.packages('dplyr')


act<-read.table("./activity_labels.txt"); dim(act) # [1] 6 2 #Activity labels
features<-read.table("./features.txt"); dim(features)#[1] 561   2
#Test
Test1<-read.table("./test/subject_test.txt") ;dim(Test1) #[1] 2947    1
Test2<-read.table("./test/X_test.txt"); dim(Test2) #[1] 2947  561
Test3<-read.table("./test/y_test.txt") ; dim(Test3) # [1] 2947    1 
Test<-cbind(Test1,Test3,Test2); dim(Test)#[1] 2947  563

#Train
Train1<-read.table("./train/subject_train.txt") ; dim(Train1) #[1] 7352    1 
Train2<-read.table("./train/X_train.txt") ; dim(Train2) #[1] 7352  561
Train3<-read.table("./train/y_train.txt") ; dim(Train3) #[1] 7352    1 
Train<-cbind(Train1,Train3,Train2); dim(Train) #[1] 7352  563

#Combine Train and Test
db<-rbind(Test, Train); dim(db) #[1] 10299   563
names<-c("id","class",as.character(features[,2]))
db<-setNames(db,names)

#q2 Extracts only the measurements on the mean and standard deviation for each measurement.


db<-db[, grep("id|class|mean[[:punct:]]|std[[:punct:]])",names(db))]  
names(db)

#q3 Uses descriptive activity names to name the activities in the data set

#Required packages
library(plyr)
names<-c("class","class_ft")
act<-setNames(act,names)
db<-arrange(join(db,act),class); names(db)
#Rearrenge data set 
db<-db[c("class_ft",names(db[-69]))]; names(db)
class(db$class_ft) #"factor"

#q4 Appropriately labels the data set with descriptive variable names

names(db)

#q5 From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.

#install.packages('dplyr')
library(dplyr)
fdb<-db%>%
  group_by(id,class_ft)%>% 
  summarise_each(funs(mean(.,na.rm=TRUE)),contains("mean()"),contains("std()")) 


#Print data base
write.table(fdb,file="tidy_dat.txt",row.names=FALSE)

#Load data base to R. 
data<-read.table("./tidy_dat.txt",header=TRUE)
View(data)



