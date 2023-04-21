## **CodeBook**

------------------------------------------------------------------------

I have also written the steps taken inside the `run_analysis.R` script as well as here so it can be followed line by line

> ### **`run_analysis.R`**
>
> #### **Step 1 - Packages**
>
> -   Load in necessary packages
>
>     `library(reshape2)`
>
>     `library(dplyr)`
>
>     `library(tidyverse)`
>
> #### **Step 2 - Naming the dataset**
>
> -   Name the dataset from the zip file for use in the next step
>     -   `dataset` \<- `getdata_projectfiles_UCI HAR Dataset`
>
> #### **Step 3 - Downloading and unzipping the data**
>
> -   Check if the file exist
>
> -   Store the url to an object
>
> -   Download and unzip the dataset
>
> #### **Step 4 - Activity & Features**
>
> -   Need to gather the information on the activities & features from the `activity_labels` & `features` .txt files
> -   `Activity`
>     -   Read in the "`activity_labels`" file
>     -   Here, using "[,2]" to specify that the 2nd column should be a character
> -   `Features`
>     -   Read in the features file (same as with `Activity`)
>
>     -   Again specifying that the 2nd column is a character (same as with `Activity`)
>
>     -   Now we want to grab the observations in `Features` that only contain data on the mean or std
>
>     -   We'll single out these observations by scanning for "mean" or "std" in the 2nd column, storing them to an object
>
>         -   "`Useful_Features`" = a count of the observations in the 2nd column of "`Features`" that contain "mean" or "std"
>
>         -   We will use this object when loading in the `Test` & `Train` set files ("`X_`") to subset them with the mean / std columns
>
>         -   "`Useful_Features_Names`" = a subset of the named observations within "`Features`" that contain "mean" or "std"
>
>         -   We will edit then use this object later to represent variable names after we merge the two datasets in the next steps
>
> #### **Step 5 - Loading & Sub-setting Training & Test**
>
> -   Both folders have 3 .txt files we want to combine together
>
>     -   For the "`X_`" files, we want to load them in with only the columns tied to mean / std by sub-setting them with "`Useful_Features`"
>
> -   `Training`
>
>     -   Load in the "`X_`" File
>
>         -   Sub-setting using the "`Useful_Features`" object from earlier
>
>     -   Load in the "`Y_`" and "`Subject_`" files
>
>     -   Bind them together into one with cbind (In this order (Subjects, Labels, Set))
>
> -   `Test`
>
>     -   Follow the same steps as `Training`
>
> #### **Step 6 - Merging `Training` + `Test`**
>
> -   Merging the two datasets together into one (using `rbind()`)
>
> -   = `Full_Data`
>
> #### **Step 7 - Labeling Variables**
>
> -   Replacing characters within `Useful_Features_Names` (using `gsub()`)
>
> -   Applying the columns names to `Full_Data` using `colnames()` with `Subject`, `Activity` & `Useful_Features_Names`
>
> -   Final corrections to the variable names using `rename()`
>
> #### **Step 8 - Factors**
>
> -   Changing the `Subject` and `Activity` columns into factors
>
>     -   `Activity` - `Full_Data$Activity`
>
>     -   `Subject` - `Full_Data$Subject` + `as.factor()`
>
> #### **Step 9 - Melting & Casting**
>
> -   Melting the dataset by the factors columns as a tall/skinny dataset (=`Full_Data_Melted)`
>
> -   Re-casting the dataset back by with the variable averages for each `Activity` & `Subject` (=`Full_Data_Mean`)
>
> #### **Step 10 - Save as an independent tidy dataset**
>
> -   `write.table()` to create = "`Tidy_Data.txt`"

------------------------------------------------------------------------

### **Activity Labels**

-   `WALKING` - The `Subject` was recorded as walking

-   `WALKING_UPSTAIRS` - The `Subject` was recorded as walking up an incline

-   `WALKING_DOWNSTAIRS` - The `Subject` was recorded as walking down an incline

-   `SITTING` - The `Subject` was recorded as sitting down

-   `STANDING` - The `Subject` was recorded as standing

-   `LAYING` - The `Subject` was recorded as laying down, inactive

------------------------------------------------------------------------

### **Identifier Columns**

-   `Subject` - The individual ID number assigned to each volunteer

-   `Activity` - The activity that was measured at the time of recording

------------------------------------------------------------------------

### **Measured Features**

-   `TimeBodyAccelerometer.Mean_X`
-   `TimeBodyAccelerometer.Mean_Y`
-   `TimeBodyAccelerometer.Mean_Z`
-   `TimeBodyAccelerometer.Std_X`
-   `TimeBodyAccelerometer.Std_Y`
-   `TimeBodyAccelerometer.Std_Z`
-   `TimeGravityAccelerometer.Mean_X`
-   `TimeGravityAccelerometer.Mean_Y`
-   `TimeGravityAccelerometer.Mean_Z`
-   `TimeGravityAccelerometer.Std_X`
-   `TimeGravityAccelerometer.Std_Y`
-   `TimeGravityAccelerometer.Std_Z`
-   `TimeBodyAccelerometerJerk.Mean_X`
-   `TimeBodyAccelerometerJerk.Mean_Y`
-   `TimeBodyAccelerometerJerk.Mean_Z`
-   `TimeBodyAccelerometerJerk.Std_X`
-   `TimeBodyAccelerometerJerk.Std_Y`
-   `TimeBodyAccelerometerJerk.Std_Z`
-   `TimeBodyGyroscope.Mean_X`
-   `TimeBodyGyroscope.Mean_Y`
-   `TimeBodyGyroscope.Mean_Z`
-   `TimeBodyGyroscope.Std_X`
-   `TimeBodyGyroscope.Std_Y`
-   `TimeBodyGyroscope.Std_Z`
-   `TimeBodyGyroscopeJerk.Mean_X`
-   `TimeBodyGyroscopeJerk.Mean_Y`
-   `TimeBodyGyroscopeJerk.Mean_Z`
-   `TimeBodyGyroscopeJerk.Std_X`
-   `TimeBodyGyroscopeJerk.Std_Y`
-   `TimeBodyGyroscopeJerk.Std_Z`
-   `TimeBodyAccelerometerMagnitude.Mean`
-   `TimeBodyAccelerometerMagnitude.Std`
-   `TimeGravityAccelerometerMagnitude.Mean`
-   `TimeGravityAccelerometerMagnitude.Std`
-   `TimeBodyAccelerometerJerkMagnitude.Mean`
-   `TimeBodyAccelerometerJerkMagnitude.Std`
-   `TimeBodyGyroscopeMagnitude.Mean`
-   `TimeBodyGyroscopeMagnitude.Std`
-   `TimeBodyGyroscopeJerkMagnitude.Mean`
-   `TimeBodyGyroscopeJerkMagnitude.Std`
-   `FrequencyBodyAccelerometer.Mean_X`
-   `FrequencyBodyAccelerometer.Mean_Y`
-   `FrequencyBodyAccelerometer.Mean_Z`
-   `FrequencyBodyAccelerometer.Std_X`
-   `FrequencyBodyAccelerometer.Std_Y`
-   `FrequencyBodyAccelerometer.Std_Z`
-   `FrequencyBodyAccelerometer.Mean_Freq_X`
-   `FrequencyBodyAccelerometer.Mean_Freq_Y`
-   `FrequencyBodyAccelerometer.Mean_Freq_Z`
-   `FrequencyBodyAccelerometerJerk.Mean_X`
-   `FrequencyBodyAccelerometerJerk.Mean_Y`
-   `FrequencyBodyAccelerometerJerk.Mean_Z`
-   `FrequencyBodyAccelerometerJerk.Std_X`
-   `FrequencyBodyAccelerometerJerk.Std_Y`
-   `FrequencyBodyAccelerometerJerk.Std_Z`
-   `FrequencyBodyAccelerometerJerk.Mean_Freq_X`
-   `FrequencyBodyAccelerometerJerk.Mean_Freq_Y`
-   `FrequencyBodyAccelerometerJerk.Mean_Freq_Z`
-   `FrequencyBodyGyroscope.Mean_X`
-   `FrequencyBodyGyroscope.Mean_Y`
-   `FrequencyBodyGyroscope.Mean_Z`
-   `FrequencyBodyGyroscope.Std_X`
-   `FrequencyBodyGyroscope.Std_Y`
-   `FrequencyBodyGyroscope.Std_Z`
-   `FrequencyBodyGyroscope.Mean_Freq_X`
-   `FrequencyBodyGyroscope.Mean_Freq_Y`
-   `FrequencyBodyGyroscope.Mean_Freq_Z`
-   `FrequencyBodyAccelerometerMagnitude.Mean`
-   `FrequencyBodyAccelerometerMagnitude.Std`
-   `FrequencyBodyAccelerometerMagnitude.Mean_Freq`
-   `FrequencyBodyAccelerometerJerkMagnitude.Mean`
-   `FrequencyBodyAccelerometerJerkMagnitude.Std`
-   `FrequencyBodyAccelerometerJerkMagnitude.Mean_Freq`
-   `FrequencyBodyGyroscopeMagnitude.Mean`
-   `FrequencyBodyGyroscopeMagnitude.Std`
-   `FrequencyBodyGyroscopeMagnitude.Mean_Freq`
-   `FrequencyBodyGyroscopeJerkMagnitude.Mean`
-   `FrequencyBodyGyroscopeJerkMagnitude.Std`
-   `FrequencyBodyGyroscopeJerkMagnitude.Mean_Freq`
