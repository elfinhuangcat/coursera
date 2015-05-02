## run_analysis.R
## This file should be put in the same directory with the folder
## "UCI HAR Dataset".

## FUNCTIONALITY:
## The functionality of this source file is to transform the UCI HAR
## Dataset by doing the following stuff:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard 
##    deviation for each measurement. 
## 3. Creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject. 

## HOW TO USE:
## In your R platform, type:
##     source("..path_to_this_file/run_analysis.R")
## And then call the function run() by typing:
##     run("..path_to_this_file")
## This will set the current working directory to the specified dir.
## * Or you can set the working directory before you source the file:
##     setwd("..path_to_this_file")
##   And then source the file by typing:
##     source("run_analysis.R")
##   And then call the function run by typing:
##     run()

## Author: Yaxin
## Contact: yaxinhuangcat@icloud.com

run <- function(pathToFile = NULL) {
    homedir <- NULL
    if (is.null(pathToFile)) {
        # The current working directory is set up by the user.
        homedir <- getwd()
    }
    else {
        # Set the current working directory as user input.
        setwd(pathToFile)
        homedir <- getwd()
    }
    
    # Read raw training set vectors.
    rawTrainVec <- readLines(paste0(homedir,
                                    "/UCI HAR Dataset/train/X_train.txt"))
    # Read raw testing set vectors.
    rawTestVec <- readLines(paste0(homedir,
                                   "/UCI HAR Dataset/test/X_test.txt"))
    # Read feature names.
    featureVec <- readLines(paste0(homedir,
                                   "/UCI HAR Dataset/features.txt"))
    # Read training set subjects.
    subjectTrain <- readLines(paste0(homedir,
                                     "/UCI HAR Dataset/train",
                                     "/subject_train.txt"))
    # Read testing set subjects.
    subjectTest <- readLines(paste0(homedir,
                                    "/UCI HAR Dataset/test",
                                    "/subject_test.txt"))
    # Read training set activity labels.
    labelTrain <- readLines(paste0(homedir,
                                   "/UCI HAR Dataset/train",
                                   "/y_train.txt"))
    # Read testing set activity labels.
    labelTest <- readLines(paste0(homedir,
                                  "/UCI HAR Dataset/test",
                                  "/y_test.txt"))
    # Read activity names:
    activities <- readLines(paste0(homedir,
                                   "/UCI HAR Dataset/activity_labels.txt"))
    activityTable <- make_tidy_matrix_from_list(activities,2)
    activityTable <- activityTable[,2] # Now it is a vector
    
    # Number of features:
    numofFeature <- length(featureVec)
    # Size of training/testing set:
    sizeofTrain <- length(subjectTrain)
    sizeofTest <- length(subjectTest)
    
    # Tidy up the featurevec
    featureVec <- sub("^[0-9]* ",replacement="",featureVec)
    
    # Transform the raw training/testing set into tidy matrices.
    tidyTrainMatrix <- make_tidy_matrix_from_list(rawTrainVec,numofFeature)
    tidyTestMatrix <- make_tidy_matrix_from_list(rawTestVec,numofFeature)
    
    # Transform the matrices into data frames.
    trainDF <- data.frame(tidyTrainMatrix,stringsAsFactors = F)
    testDF <- data.frame(tidyTestMatrix,stringsAsFactors = F)
    
    # Add another column "subject" to trainDF & testDF
    # Add another column "activity" to trainDF & testDF
    trainDF <- cbind(subjectTrain,labelTrain,trainDF)
    testDF <- cbind(subjectTest,labelTest,testDF)
    
    # So now the data frames looks like:
    # subjectTest, labelTest, and other features.
    
    # Modify the column names according to the feature names we read.
    featureVec <- c("subject","activity",featureVec)
    numofFeature <- numofFeature + 2
    colnames(trainDF) <- featureVec
    colnames(testDF) <- featureVec
    
    # Merges the training and the test sets to create one data set.
    DF <- rbind(trainDF,testDF)
    
    # Extracts only the measurements on the mean and standard 
    # deviation for each measurement. 
    DF <- DF[,grep("std()|mean()|subject|activity", featureVec)]
       
    # Creates a second, independent tidy data set with the average of 
    # each variable for each activity and each subject. 
    ## 1. Sort the dataframe according to the order of subject and activity.
    DF <- DF[order(DF$subject,DF$activity),]
    newDF <- summarize_DF(DF)
    
    # Uses descriptive activity names to name the activities in the data set.
    newDF <- replace_activity_names(newDF,activityTable)
    
    # Directly returns the result table.
    write.table(newDF,file="data.csv",sep=",",col.names=T,row.names=F)
    newDF
}

## Function name: good_vec
## Given: A vector vec
## Returns: A vector without elements that are "" (empty string)
good_vec <- function(vec) {
    vec <- vec[vec != ""]
    vec
}

## Function name: desired_cols
## Given: A vector featureVec with all the feature names
## Returns: A boolean vector indicating which are desired features (True)
desired_cols <- function(featureVec) {
    grepl("std()|mean()|subject|activity", featureVec)
}

## Function name: make_tidy_matrix_from_list
## Given: A list of vectors (The lengths of the vectors can be different, 
##        since they might contain "")
## Returns: A tidy matrix
make_tidy_matrix_from_list <- function(messyvec, featureNum) {
    splitList <- strsplit(messyvec," ")
    matrix(unlist(lapply(splitList,good_vec)),ncol = featureNum,byrow=T)
} 

## Function name: replace_activity_names
## Given: A data frame with a column named "activity" and its values are
##        indices to the table "activityTable".
## Returns: A data frame like the original one, but with the activity values
##          using the descriptive activity names.
replace_activity_names <- function(df, activityTable) {
    newActCol <- c()
    for (i in seq(1,nrow(df))) {
        newActCol[i] <- activityTable[as.numeric(df[i,"activity"])]
    }
    df$activity <- as.factor(newActCol)
    df
}

## Function name: summarize_DF
## Given: A data frame, with columns named "subject" and "activity" and
##        the data frame is sorted by them.
## Returns: A data frame (independent tidy data set with the average of 
##          each variable for each activity and each subject. )
summarize_DF <- function(df) {
    df$subject <- as.factor(df$subject)
    df$activity <- as.factor(df$activity)
    intermediate <- split(df,interaction(df$subject,df$activity))
    intermediate <- lapply(intermediate,mean_df)
    newDF <- intermediate[[1]]
    for (i in 2:length(intermediate)) {
        newDF <- rbind(newDF,intermediate[[i]])
    }
    newDF
}

## Function name: mean_DF
## Given: A data frame with columns name "subject" and activity" which
##        are not numeric values. Other columns consist of numeric values
##        and we need to calculate their average.
## Returns: A data frame, with only one row. Except the "subject" and 
##          "activity" attributes hold the same value as input, other
##          attributes are the average of the repective column of the 
##          input data frame.
mean_df <- function(df) {
    newDF <- df[1,]
    for (i in 3:ncol(newDF)) {
        newDF[1,i] <- mean(as.numeric(df[,i]))
    }
    newDF
}