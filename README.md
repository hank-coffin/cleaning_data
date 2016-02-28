# Getting and Cleaning Data Course Project

## Overview
This project reads several data files, combines them, filters out unwanted measurements, and finally summarizes the data.
Two datasets are generated and saved as csv files.

I believe I have satisfied all of the requirements of the project:

1. The submitted data set is tidy.
  * The final data set is easy to view and see the averaged data for the mean and std measurements by activity by user.
2. The Github repo contains the required scripts.
  * Just one script, run_analysis.R
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
  * See CODEBOOK.md
4. The README that explains the analysis files is clear and understandable.
  * This file
5. The work submitted for this project is the work of the student who submitted it.
  * I did all of the work myself 

## Deliverable Files
| File              | Description                              |
|-------------------|------------------------------------------|
| README.md         | This file                                |
| CODEBOOK.md       | The codebook                             |
| run_analysis.R    | The script used to generate the datasets |
| final_summary.csv | The finished dataset, in csv format      |


## Input Files
1. data.zip       Archive of the input files.

This archive contains the original data files in their original layout.
The script run_analysis.R should run with the data files in original structure as below.
None of the data files have been edited.  
The output file final_summary.csv is created in the same directory as run_analysis.R.

* run_analysis.R
* data\
  * activity_labels.txt
  * features.txt
  * test\
    * subject_test.txt
    * X_test.txt
    * y_test.txt
  * train\
    * subject_train.txt
    * X_train.txt
    * y_train.txt
    
