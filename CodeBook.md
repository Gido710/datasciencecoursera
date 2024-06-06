# Codebook 

Preface
============================================

This Codebook contains a summarized description of the variables, both used and calculated, found in the calculation of the data tables. For more information, please refer to the Codebook found in the UCI HAR Dataset, titled **"README"**, **features**, **"features_info"**.

Participants
============

**Participant**: Numbered 1-30. This variables identifies the participant involved in the HAR experiment conducted by Smartlab/DITEN. 

Activity
============

**Activity**: There are 6 activities, corresponding to the movement the participant was engaged in when the data was collected:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

Feature Selection
=================

All other variables found in **full_data_tbl** are computed values obtained from Smartlab and DITEN's experiment. First, a series of signals were measured using an accelerometer and gyroscope found in a Smasung Galaxy S II attached to the participants' waists. Then, a series of variables were computed with **mean()** and **std()** applied to those signals. I refer you to Smartlab/DITEN's description of the variables below:


    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

    Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

    Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

    These signals were used to estimate variables of the feature vector for each pattern:  
    '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

In brief, **full_data_tbl** contains the following variables:

 1. tBodyAcc-mean()-X
 2. tBodyAcc-mean()-Y
 3. tBodyAcc-mean()-Z
 4. tBodyAcc-std()-X
 5. tBodyAcc-std()-Y
 6. tBodyAcc-std()-Z
 7. tGravityAcc-mean()-X
 8. tGravityAcc-mean()-Y
 9. tGravityAcc-mean()-Z
 10. tGravityAcc-std()-X
 11. tGravityAcc-std()-Y
 12. tGravityAcc-std()-Z
 13. tBodyAccJerk-mean()-X
 14. tBodyAccJerk-mean()-Y
 15. tBodyAccJerk-mean()-Z
 16. tBodyAccJerk-std()-X
 17. tBodyAccJerk-std()-Y
 18. tBodyAccJerk-std()-Z
 19. tBodyGyro-mean()-X
 20. tBodyGyro-mean()-Y
 21. tBodyGyro-mean()-Z
 22. tBodyGyro-std()-X
 23. tBodyGyro-std()-Y
 24. tBodyGyro-std()-Z
 25. tBodyGyroJerk-mean()-X
 26. tBodyGyroJerk-mean()-Y
 27. tBodyGyroJerk-mean()-Z
 28. tBodyGyroJerk-std()-X
 29. tBodyGyroJerk-std()-Y
 30. tBodyGyroJerk-std()-Z
 31. tBodyAccMag-mean()
 32. tBodyAccMag-std()
 33. tGravityAccMag-mean()
 34. tGravityAccMag-std()
 35. tBodyAccJerkMag-mean()
 36. tBodyAccJerkMag-std()
 37. tBodyGyroMag-mean()
 38. tBodyGyroMag-std()
 39. tBodyGyroJerkMag-mean()
 40. tBodyGyroJerkMag-std()
 41. fBodyAcc-mean()-X
 42. fBodyAcc-mean()-Y
 43. fBodyAcc-mean()-Z
 44. fBodyAcc-std()-X
 45. fBodyAcc-std()-Y
 46. fBodyAcc-std()-Z
 47. fBodyAccJerk-mean()-X
 48. fBodyAccJerk-mean()-Y
 49. fBodyAccJerk-mean()-Z
 50. fBodyAccJerk-std()-X
 51. fBodyAccJerk-std()-Y
 52. fBodyAccJerk-std()-Z
 53. fBodyGyro-mean()-X
 54. fBodyGyro-mean()-Y
 55. fBodyGyro-mean()-Z
 56. fBodyGyro-std()-X
 57. fBodyGyro-std()-Y
 58. fBodyGyro-std()-Z
 59. fBodyAccMag-mean()
 60. fBodyAccMag-std()
 61. fBodyBodyAccJerkMag-mean()
 62. fBodyBodyAccJerkMag-std()
 63. fBodyBodyGyroMag-mean()
 64. fBodyBodyGyroMag-std()
 65. fBodyBodyGyroJerkMag-mean()
 66. fBodyBodyGyroJerkMag-std()
 
 Variables in **tidy_tbl** are computed by applying **mean()** on each column, and labeled by formatting with **"Mean: {.col}""**. 
 
 Reference
================

**[1]** Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
