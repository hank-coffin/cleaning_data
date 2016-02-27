# run_analysis.R
# Prepares tidy data that can be used for later analysis.
#
# Getting and Cleaning Data Course Project
# Hank Coffin
# 26 February, 2016
#
# Project Deliverables:
# 1. A tidy data set
# 2. A link to Gihub repository with:
#       a) This file, run_analysis.R
#       b) A codebook, called CodeBook.md
#       c) README.md

# This script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set working directory
# setwd( "C:/Users/hank/Documents/mooc/data_science/cleaning_data/project" )
library(reshape2)

# Read ./data/features.txt
# This file contains the names of the measurements
# tBodyAcc-mean()-X, tBodyAcc-mean()-Y, ..., angle(Z,gravityMean)
#
feature.labels <- read.table( "./data/features.txt", 
                            header = FALSE, 
                            sep = " ", 
                            col.names = c("i", "feature"), 
                            colClasses = c("numeric", "character"),
                            stringsAsFactors = FALSE)

# Read ./data/activity_labels.txt
# This file contains the labels of the activity id's.
# WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
#
activity.labels <- read.table( "./data/activity_labels.txt", 
                                header = FALSE, 
                                sep = " ", 
                                col.names = c("i", "activity"), 
                                colClasses = c("numeric", "character"),
                                stringsAsFactors = FALSE )

# Read the training data files
#
subject.id.train   <- read.table(    "./data/train/subject_train.txt", 
                                     header     = FALSE, 
                                     col.names  = c("subject.id"), 
                                     colClasses = c("numeric") )

activity.id.train  <- read.table(   "./data/train/y_train.txt", 
                                    header     = FALSE, 
                                    col.names  = c("activity.id"), 
                                    colClasses = c("numeric") )

measurements.train <- read.table(   "./data/train/x_train.txt", 
                                    header     = FALSE, 
                                    colClasses = "numeric" )


# Read the test data files
#
subject.id.test    <- read.table(   "./data/test/subject_test.txt", 
                                    header     = FALSE, 
                                    col.names  = c("subject.id"), 
                                    colClasses = c("numeric") )

activity.id.test   <- read.table(   "./data/test/y_test.txt", 
                                    header     = FALSE, 
                                    col.names  = c("activity.id"), 
                                    colClasses = c("numeric") )

measurements.test  <- read.table(   "./data/test/x_test.txt", 
                                    header     = FALSE, 
                                    colClasses = "numeric" )


# combine the training and test samples
#
subject.id   <- rbind( subject.id.train,   subject.id.test   )
activity.id  <- rbind( activity.id.train,  activity.id.test  )
measurements <- rbind( measurements.train, measurements.test )

# Intermediate cleanup
#
rm( subject.id.train,   subject.id.test,
    activity.id.train,  activity.id.test,  
    measurements.train, measurements.test )

# name the columns
#
colnames( measurements ) <- feature.labels$feature

#
# create data.frame with subject.ids, named activities, and readings
#

# Create the labeled activity column, map labels onto activity.ids
#
activity <- activity.labels$activity[ activity.id$activity.id ]

# Create the subset of features to be included in the final data.frames
# Only include measurements which are mean or standard deviations
#
features.mean.std <- feature.labels$feature[ grep( "mean|std", feature.labels$feature )]

# Create a measurements data.frame with only mean and standard deviation measurements
#
measurements.mean.std <- measurements[, features.mean.std]

# Create the final data frame with subject id, activity labels, and only mean and std measurements
#
final <- cbind( subject.id, activity, measurements.mean.std )

# melt using subject.id and activity as id to reshape in next step
#
final.melted <- melt( final, id=c("subject.id", "activity"), measure.vars = features.mean.std )

# cast melted data.frame to show means for each activity for each subject
# subject.id  activity   tBodyAccMean-X()
#     1       LAYING     0.2323232
#     1       SITTING    0.242322
#    ...
final.summary <- dcast( final.melted, subject.id+activity ~ variable, mean)

# write the final data.frames out as .csv files
#
write.csv( final.summary, "./data/final_summary.csv" )
write.csv( final,         "./data/final.csv"         )

# read files which were just written
# review.final.summary <- read.csv(    "./data/final_summary.csv", header = TRUE )
# review.final         <- read.csv(    "./data/final.csv",         header = TRUE )

# cleanup, leaving final.summary and final
#
rm( activity, 
    measurements.mean.std, 
    measurements, 
    activity.id, 
    subject.id, 
    activity.labels, 
    feature.labels, 
    features.mean.std, 
    final.melted )

