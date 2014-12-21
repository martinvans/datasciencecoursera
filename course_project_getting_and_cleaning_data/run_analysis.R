# Course Project 'Getting and Cleaning Data'


## Get the data from the web and unzip it to 'UCI HAR Dataset' directory 
setwd( "F:/My Documents/R/Coursera/Assignments/Getting and Cleaning Data - Peer Assignment")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
downloadDir <- "data"
path <- function( ...) { paste( ..., sep = "/") }
zipFile <- path( downloadDir, "dataset.zip")
if(!file.exists( zipFile)) { download.file( url, zipFile) }
dataDir <- path( downloadDir, "UCI HAR Dataset")
if(!file.exists( dataDir)) { unzip( zipFile, exdir = downloadDir) }




## Course Project Part 1 - Merge the training and the test sets to create one data set.
read <- function( path) { read.table( path( dataDir, path)) }
if(!exists( "XTrain")) { XTrain <- read( "train/X_train.txt") }
if(!exists( "XTest"))  { XTest  <- read( "test/X_test.txt") }
merged <- rbind( XTrain, XTest)
featureNames <- read( "features.txt")[, 2]
names( merged) <- featureNames




## Course Project Part 2 - Extract only the measurements on the mean and standard deviation for each measurement. 
matches <- grep( "(mean|std)\\(\\)", names( merged))
limited <- merged[, matches]




## Course Project Part 3 - Use descriptive activity names to name the activities in the data set.

yTrain <- read( "train/y_train.txt")
yTest  <- read( "test/y_test.txt")
yMerged <- rbind( yTrain, yTest)[, 1]
activityNames <- c( "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[yMerged]




## Course Project Part 4 - Appropriately label the data set with descriptive variable names.

### Use verbose names instead of abbreviations
names( limited) <- gsub( "^t", "Time", names( limited))
names( limited) <- gsub( "^f", "Frequency", names( limited))
names( limited) <- gsub( "-mean\\(\\)", "Mean", names( limited))
names( limited) <- gsub( "-std\\(\\)", "StdDev", names( limited))
names( limited) <- gsub( "-", "", names( limited))

### Clean up names where 'Body' is repeated
names( limited) <- gsub( "BodyBody", "Body", names( limited))  

### Bind activities and subjects and use descriptive names
subjectTrain <- read( "train/subject_train.txt")
subjectTest  <- read( "test/subject_test.txt")
subjects <- rbind( subjectTrain, subjectTest)[, 1]
tidy <- cbind( Subject = subjects, Activity = activities, limited)   




## Course Project Part 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject.

library( plyr)
### Column means for all but the subject and activity columns
limitedColMeans <- function( data) { colMeans(data[,-c(1,2)]) }
tidyMeans <- ddply( tidy, .( Subject, Activity), limitedColMeans)
names( tidyMeans)[-c(1,2)] <- paste0( "Mean", names(tidyMeans)[-c(1,2)])




## Write the tidy data set containing the means (average) from Part 5 to be uploaded to the Coursera website as part of the assignment.

write.table( tidyMeans, "tidyMeans.txt", row.names = FALSE)
### Read data set back in to check if all went well
tidyMeansCheck <- read.table( "tidyMeans.txt", header = TRUE)


## End of Assignment
