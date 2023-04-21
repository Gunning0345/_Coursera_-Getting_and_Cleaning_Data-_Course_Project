##run_analysis.R


--------------------------------------------------------------------------------
  
  
##Step 1 - Packages
  
  
##Firstly, load in any necessary packages
library(reshape2)
library(dplyr)
library(tidyverse)


--------------------------------------------------------------------------------

    
##Step 2 - Naming the dataset
  
  
##Naming the dataset from the zip file for use in the next step
  dataset <- "getdata_projectfiles_UCI HAR Dataset"
  
    ##This is what mine was named when I downloaded it
    
--------------------------------------------------------------------------------
    
    
##Step 3 - Downloading and unzipping the data
    
    
##Check if the file exist
##Store the url to an object
##Download and unzip the dataset:
  if (!file.exists(dataset)) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
      download.file(fileURL, dataset, method="curl")  }  
  
  if (!file.exists("UCI HAR Dataset")) 
  { unzip(dataset) }
  
  
--------------------------------------------------------------------------------
    
    
##Step 4 - Activity & Features
    
    
##Need to gather the information on the activities & features from the activity_labels & features .txt files
    
    
##Activity
##Read in the activity labels file
  Activity <- read.table("UCI HAR Dataset/activity_labels.txt")
    
##Here, using "[,2]" to specify that the 2nd column should be a character
  Activity[,2] <- as.character(Activity[,2])
    
    
##Features
##Read in the features file
  Features <- read.table("UCI HAR Dataset/features.txt")
    
##Again specifying that the 2nd column is a character
  Features[,2] <- as.character(Features[,2])
    
    
    ##Now we want to grab the observations in "Features" that only contain data on the mean or std
    
    
    ##We'll single out these observations by scanning for "mean" or "std" in the 2nd column, storing them to an object
      Useful_Features <- grep(".*mean.*|.*std.*", Features[,2])
        ##"Useful_Features" = a count of the observations in the 2nd column of "Features" that contain "mean" or "std"
          ##We will use this object when loading in the Test & Train set files ("X_") to subset them with the mean / std columns
    
      Useful_Features_Names <- Features[Useful_Features,2]
        ##"Useful_Features_Name" = a subset of the named observations within "Features" that contain "mean" or "std"
          ##We will edit then use this object later to represent variable names after we merge the two datasets in the next steps
    
    
--------------------------------------------------------------------------------
      
      
##Step 5 - Loading & Sub-setting Training & Test
      
      
##Both folders have 3 .txt files we want to combine together (X_"", Y_"", subject_"")
  ##For the X_"" files, we want to load them in with only the columns tied to mean / std by sub-setting them with "Useful_Features"
      
      
##Training Data
      
  X_Train <- read.table("UCI HAR Dataset/train/X_train.txt")[Useful_Features] #Sub-setting using the "Useful_Features" object from earlier
    
    ##Load in the Y_"" and Subject_"" files
      Y_Train <- read.table("UCI HAR Dataset/train/Y_train.txt")
    
      Subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    
      ##Now bind them together into one
        Train <- cbind(Subject_Train, Y_Train, X_Train) ##In this order (Subjects, Labels, Set)
          ##"Train" will be merged with the "Test" before we change/add labels
    

      
##Test Data (Same as above)
    
  X_Test <- read.table("UCI HAR Dataset/test/X_test.txt")[Useful_Features] #Sub-setting using the "Useful_Features" object from earlier
    
    ##Load in the Y_"" and Subject_"" files
      Y_Test <- read.table("UCI HAR Dataset/test/Y_test.txt")
    
     Subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    
      ##Now bind them together into one
        Test <- cbind(Subject_Test, Y_Test, X_Test) ##In this order (Subjects, Labels, Set)
          ##"Test" will be merged with the "Train" before we change/add labels
    
    
--------------------------------------------------------------------------------
      
      
##Step 6 - Merging Training + Test
      
      
##Merging the two datasets together into one
  Full_Data <- rbind(Train, Test)
    
    
--------------------------------------------------------------------------------
      
      
##Step 7 - Labeling Variables
      
      
##Replacing certain characters
  Useful_Features_Names = gsub('-mean', '.Mean_', Useful_Features_Names)
  Useful_Features_Names = gsub('mean', '.Mean_', Useful_Features_Names)
  Useful_Features_Names = gsub('-std', '.Std_', Useful_Features_Names)
  Useful_Features_Names = gsub('std', '.Std_', Useful_Features_Names)
  Useful_Features_Names = gsub('[-()]', '', Useful_Features_Names)
  Useful_Features_Names = gsub("Acc", "Accelerometer", Useful_Features_Names)
  Useful_Features_Names = gsub("Gyro", "Gyroscope", Useful_Features_Names)
  Useful_Features_Names = gsub("BodyBody", "Body", Useful_Features_Names)
  Useful_Features_Names = gsub("Mag", "Magnitude", Useful_Features_Names)
  Useful_Features_Names = gsub("^t", "Time", Useful_Features_Names)
  Useful_Features_Names = gsub("^f", "Frequency", Useful_Features_Names)
  Useful_Features_Names = gsub("tBody", "TimeBody", Useful_Features_Names)  
  Useful_Features_Names = gsub("angle", "Angle", Useful_Features_Names)
  Useful_Features_Names = gsub("gravity", "Gravity", Useful_Features_Names)
  Useful_Features_Names = gsub("FreqX", "Freq_X", Useful_Features_Names)
  Useful_Features_Names = gsub("FreqY", "Freq_Y", Useful_Features_Names)
  Useful_Features_Names = gsub("FreqZ", "Freq_Z", Useful_Features_Names)
  

##Applying the columns names
  colnames(Full_Data) <- c("Subject", "Activity", Useful_Features_Names)
    
    
##corrections to the variable names
    
    
  ##Removing extra "_" ends
    Full_Data <- rename(Full_Data,
                        TimeBodyAccelerometerMagnitude.Mean = TimeBodyAccelerometerMagnitude.Mean_,
                        TimeBodyAccelerometerMagnitude.Std = TimeBodyAccelerometerMagnitude.Std_,
                        TimeGravityAccelerometerMagnitude.Mean = TimeGravityAccelerometerMagnitude.Mean_,
                        TimeGravityAccelerometerMagnitude.Std = TimeGravityAccelerometerMagnitude.Std_,
                        TimeBodyAccelerometerJerkMagnitude.Mean = TimeBodyAccelerometerJerkMagnitude.Mean_,
                        TimeBodyAccelerometerJerkMagnitude.Std = TimeBodyAccelerometerJerkMagnitude.Std_,
                        TimeBodyGyroscopeMagnitude.Mean = TimeBodyGyroscopeMagnitude.Mean_,
                        TimeBodyGyroscopeMagnitude.Std = TimeBodyGyroscopeMagnitude.Std_,
                        TimeBodyGyroscopeJerkMagnitude.Mean = TimeBodyGyroscopeJerkMagnitude.Mean_,
                        TimeBodyGyroscopeJerkMagnitude.Std = TimeBodyGyroscopeJerkMagnitude.Std_,
                        FrequencyBodyAccelerometerMagnitude.Mean = FrequencyBodyAccelerometerMagnitude.Mean_,
                        FrequencyBodyAccelerometerMagnitude.Std = FrequencyBodyAccelerometerMagnitude.Std_,
                        FrequencyBodyAccelerometerJerkMagnitude.Mean = FrequencyBodyAccelerometerJerkMagnitude.Mean_,
                        FrequencyBodyAccelerometerJerkMagnitude.Std_ = FrequencyBodyAccelerometerJerkMagnitude.Std_,
                        FrequencyBodyGyroscopeMagnitude.Mean = FrequencyBodyGyroscopeMagnitude.Mean_,
                        FrequencyBodyGyroscopeMagnitude.Std = FrequencyBodyGyroscopeMagnitude.Std_,
                        FrequencyBodyGyroscopeJerkMagnitude.Mean = FrequencyBodyGyroscopeJerkMagnitude.Mean_,
                        FrequencyBodyGyroscopeJerkMagnitude.Std = FrequencyBodyGyroscopeJerkMagnitude.Std_)
    
    
--------------------------------------------------------------------------------
      
      
##Step 8 - Factors
      
##Changing the "Subject" and "Activity" columns into factors
      
  ##Activity
    Full_Data$Activity <- factor(Full_Data$Activity,
                                 levels = Activity[,1],
                                 labels = Activity[,2] )
    
    
  ##Subject
    Full_Data$Subject <- as.factor(Full_Data$Subject)
    
      ##Subject & Activity now = factors; the rest should be numeric
    
    
--------------------------------------------------------------------------------
      
      
##Step 9 - Melting & Casting
      
##Melting - Melting the dataset by the factors columns as a tall/skinny dataset
  Full_Data_Melted <- melt(Full_Data, id = c("Subject", "Activity"))
    
    
##Recasting - Reshaping the dataset back by with the variable averages for each Activity & Subject
  Full_Data_Mean <- dcast(Full_Data_Melted, Subject + Activity ~ variable, mean)
    
    
--------------------------------------------------------------------------------

  
##Step 10 - Save as an independent tidy dataset
  write.table(Full_Data_Mean, "Tidy_Data.txt", 
              row.names = FALSE, 
              quote = FALSE)

    
##END