## Data Dictionary 

#### data collected from the accelerometers from the Samsung Galaxy S smartphone.
#### 2012-12-10
#### Factor variables
#### id
* Factor variable 
* i=[1,...,30] being i the volunteer id.  
#### class_ft  
* Factor variable

 class   |     class_f

1  | WALKING

2  | WALKING_UPSTAIRS

3  | WALKING_DOWNSTAIRS

4  | SITTING

5  | STANDING

6  | LAYING

### Scalar  variables
[Taken form original data base extra files]
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

From the description obove there were stimates on the mean (variables that contain "mean()") and standard deviation (variables that contain "sd()"). The data set is constructuted obtaining the mean of all these variables, collapsing a data set containing 69 variables and 10299 observations to a data set of 68 variables and 180 observations. The list of variables of the means of the means and of the means of the standard deviations are as follows. 

