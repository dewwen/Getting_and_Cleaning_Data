## "Getting and Cleaning Data" Course Project CookBook ##


### Data ###

Dataset used in this project comes from an experiment called "Human Activity Recognition Using Smartphones". 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Variables ###

- **test_X**: data of test set
- **test_Y**: data of test labels
- **test_subject**: Each row identifies the subject who performed the activity for each window sample
- **train_X**: data of training set
- **train_Y**: data of training labels
- **train_subject**: each row identifies the subject who performed the activity for each window sample
- **features**: list of all features
- **merge_X**: merged data of test set and training set
- **merge_subject**: merged data of subjects who performed the activity for each window sample
- **merge_Y**: merged data of test labels and training labels
- **features_clean**: a vector which contains a list of features
- **exper_data**: merged data of test and training sets and  features
- **valid_column**: a list of integers that represent number of columns that have std or mean data
- **valid_data**: a subset of table from exper_data that only contain mean or str data
- **subject_data**: add "subject" to the first row before the merge_subject data
- **activity_data**: add "activity" to the first row before the merge_Y data
- **merge_data**: merged data of valid_data, subject_data and activity_data
- **data_melt**: data after changing merge_data from wide table to long table using melt()
- **data_cast**: data after changing data_melt back to wide table using dcast(). data set with the average of each variable for each activity and each subject
- **new_tidy_data**: same as data_cast.


### Data Transformations ###

In this project, data set from test and train group are merged together to build up a complete experiment data. Data in each columns are simply labeled by features data as header. 

The header of columns are modified to be easily read and more descriptive. All the letters are turned to lowercase. '-' are replaced by '.' and '()' are removed. In the body of the data, the numbers in the Activity column are all replaced by descriptive activity names, like 'standing', 'sitting'.

The new_tidy_data is a independent tidy data set with the average of each variable for each activity and each subject. I use two functions: melt() and dcast() in resharp2 package to transform data between wide and long format, which are introduced in the Weekly 3 class 'Reshaping Data' section.

To label the column with corresponding descriptions, features data is merged with merge_X data first as the first row, so as the 'subject' and 'activity' label. After these three kind of data merged together, the first row of the data set is the labels that should be shown as headers. By using names(), the header is replaced by the first row data. The final step is to remove the first row (the labels) to keep the data clean. 