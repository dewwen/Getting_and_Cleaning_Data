# "Getting and Cleaning Data" Course Project #
----------

Clean_data.R is a script that performs merge and clean funtion towards the Dataset comming from an experiment called "Human Activity Recognition Using Smartphones". It creates a tidy dataset in the end which includes the average of each variable for each activity and each subject.

For the details of the data, variables and transformations used in the script, please see the CookBook.md.


### How the script works ###

The script can be divided into 7 major parts:

- **read dataset from source**: data is read from 7 files given in the project requirement.
- **merge test and training data**: since the experiment is done in two groups: test group and training group, it's necessary to merge their data sets together. After this step, there are three major data sets: X, Y and subjects.
- **merge features and X data and extract valid data**: this step first merge features data with X data and then filters mean and std data out using grep(). This completes the second requirements of the project.
- **merge X, Y and subjects data**: this parts merges all the data together into one data set.
- **replace activities with descriptive names**: this parts completes another project requirements. All the numbers (1-5) are replaced by names(standing, laying...)
- **label data set with easy-read description**: in this part, headers of the data set are edited in a series of steps: lowercase, change '_' to '.', remove '()'. It's the 4th requirement of the project.
- **reshape the data to get a tidy data set**: in this part, melt() and dcast() fuctions are used to transform data set and get the second tidy data set as final deliverable.

