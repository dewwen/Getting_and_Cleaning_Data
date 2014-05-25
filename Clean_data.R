setwd("C:/Users/wdu/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
test_X <- read.table("test/X_test.txt", header = F)
test_Y <- read.table("test/y_test.txt", header = F)
test_subject <- read.table("test/subject_test.txt", header = F)

train_X <- read.table("train/X_train.txt", header = F)
train_Y <- read.table("train/y_train.txt", header = F)
train_subject <- read.table("train/subject_train.txt", header = F)

features <- read.table("features.txt", header = F)

merge_X <- rbind(test_X, train_X)
merge_subject <- rbind(test_subject, train_subject)
merge_Y <- rbind(test_Y, train_Y)
features_clean <- as.vector(features[,2])

exper_data <- rbind(features_clean, merge_X)

valid_column <- grep("mean\\(\\)|std\\(\\)",exper_data[1,])

valid_data <- exper_data[,valid_column]

subject_data <- rbind('subject',merge_subject)
activity_data <- rbind('activity',merge_Y)

merge_data <- cbind(valid_data,subject_data,activity_data)
names(merge_data)<-merge_data[1,]
merge_data <- merge_data[-1,]

merge_data$activity[merge_data$activity==1]<-'walking'
merge_data$activity[merge_data$activity==2]<-'walking.upstairs'
merge_data$activity[merge_data$activity==3]<-'walking.downstairs'
merge_data$activity[merge_data$activity==4]<-'sitting'
merge_data$activity[merge_data$activity==5]<-'standing'
merge_data$activity[merge_data$activity==6]<-'laying'

names(merge_data) <- tolower(names(merge_data))
names(merge_data) <- gsub("-",".",names(merge_data))
names(merge_data) <- gsub("\\(\\)","",names(merge_data))

merge_data[,c(1:66)] <- sapply(merge_data[,c(1:66)], as.numeric)
data_melt <- melt(merge_data,id = c('subject','activity'))
data_cast <- dcast(data_melt,subject+activity ~ variable,mean)
rownames(data_cast) <- NULL

new_tidy_data <- data_cast
write.table(new_tidy_data, "C:/Users/wdu/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/new_tidy_data.txt", sep= "\t", row.names = FALSE)
