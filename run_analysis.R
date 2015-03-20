## Getting and Cleaning Data
## Project
## Ryan Summe

# Make sure all files exist
checkFiles <- function(){
    
    # Required files
    files <- c("UCI HAR Dataset/test/X_test.txt","UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/test/subject_test.txt","UCI HAR Dataset/train/X_train.txt",
               "UCI HAR Dataset/train/y_train.txt","UCI HAR Dataset/train/subject_train.txt",
               "UCI HAR Dataset/features.txt","UCI HAR Dataset/activity_labels.txt")
    
    # Make sure they are there
    status <- sapply(files,file.exists)
    if(!all(status)){
        stop("File(s) missing, consult README.")
    }
    print("Files OK.")
}

# Loads "test" or "train" data set
loadFiles <- function(set){
    
    # Read files
    root <- "UCI HAR Dataset/"
    x <- read.table(paste(root,set,"/X_",set,".txt",sep=""),col.names=features)
    y <- read.table(paste(root,set,"/y_",set,".txt",sep=""),col.names="Activity.Factor")
    subjects <- read.table(paste(root,set,"/subject_",set,".txt",sep=""),col.names="Subject")
    
    # Bind files together, replace factors with labels, and reorder
    data <- cbind(subjects,y,x)
    data <- merge(data,activityLabels,by="Activity.Factor")
    
    print(paste(set,"data set loaded."))
    return(data[,c(2,564,3:563)])
}

# Check that all files exist
checkFiles()

# Load variable names (remove punctuation) and activities
features <- read.table("UCI HAR Dataset/features.txt")[,2]
features <- gsub("[[:punct:]]","",features)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",
                             col.names=c("Activity.Factor","Activity"))

# Load test and train data
testData <- loadFiles("test")
trainData <- loadFiles("train")
fullData <- rbind(testData,trainData)

# Extract mean and standard deviation columns
msData <- fullData[,grepl("subject|activity|mean|std",
                          names(testData),ignore.case=TRUE)]

# Melt and cast data for result, taking the mean for each subject's activity
dataMelt <- melt(msData,id=c("Subject","Activity"),measure.vars=names(msData)[3:88])
result <- dcast(dataMelt,Subject+Activity~variable,mean)

# Write result to file
write.table(result,"results.txt")
print("Result file exported as results.txt")

# Clean up workspace
rm(features,activityLabels,loadFiles,checkFiles,testData,
   trainData,fullData,msData,dataMelt)
print("Workspace cleaned up.")

