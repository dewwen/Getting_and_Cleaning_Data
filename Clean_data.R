setwd("C:/Users/wdu/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

# the first part: read data
test_X <- read.table("test/X_test.txt", header = F)
test_Y <- read.table("test/y_test.txt", header = F)
test_subject <- read.table("test/subject_test.txt", header = F)

train_X <- read.table("train/X_train.txt", header = F)
train_Y <- read.table("train/y_train.txt", header = F)
train_subject <- read.table("train/subject_train.txt", header = F)

features <- read.table("features.txt", header = F)

# the second part: merge data set
merge_X <- rbind(test_X, train_X)
merge_subject <- rbind(test_subject, train_subject)
merge_Y <- rbind(test_Y, train_Y)

# the second column of features data is what we need
features_clean <- as.vector(features[,2])

# the third part: extract valid dataset: mean and std data
exper_data <- rbind(features_clean, merge_X)
valid_column <- grep("mean\\(\\)|std\\(\\)",exper_data[1,])
valid_data <- exper_data[,valid_column]

# the fourth part: merge everything together
subject_data <- rbind('subject',merge_subject)
activity_data <- rbind('activity',merge_Y)
merge_data <- cbind(valid_data,subject_data,activity_data)
names(merge_data)<-merge_data[1,]
merge_data <- merge_data[-1,]

# the fifth part: replace activities with names
merge_data$activity[merge_data$activity==1]<-'walking'
merge_data$activity[merge_data$activity==2]<-'walking.upstairs'
merge_data$activity[merge_data$activity==3]<-'walking.downstairs'
merge_data$activity[merge_data$activity==4]<-'sitting'
merge_data$activity[merge_data$activity==5]<-'standing'
merge_data$activity[merge_data$activity==6]<-'laying'

# the sixth part: make headers more readable and descriptive
names(merge_data) <- tolower(names(merge_data))
names(merge_data) <- gsub("-",".",names(merge_data))
names(merge_data) <- gsub("\\(\\)","",names(merge_data))

# the seventh part: transform data set into a second tidy one
merge_data[,c(1:66)] <- sapply(merge_data[,c(1:66)], as.numeric)
data_melt <- melt(merge_data,id = c('subject','activity'))
data_cast <- dcast(data_melt,subject+activity ~ variable,mean)
rownames(data_cast) <- NULL

# save the tidy data set
new_tidy_data <- data_cast
write.table(new_tidy_data, "C:/Users/wdu/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/new_tidy_data.txt", sep= "\t", row.names = FALSE)
