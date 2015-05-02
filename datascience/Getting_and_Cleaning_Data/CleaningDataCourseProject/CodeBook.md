CodeBook
========
This file explains the method I use in run_analysis.R to trainsform the raw data to the tidy data.

## 1. The files used in run_analysis.R:
File path                      |   Purpose
-------------------------------|-----------------------------
/UCI HAR Dataset/train/X_train.txt   |Training set vector
/UCI HAR Dataset/test/X_test.txt    |Testing set vector
/UCI HAR Dataset/train/y_train.txt   |Training set activity labels
/UCI HAR Dataset/test/y_test.txt    |Testing set activity labels
/UCI HAR Dataset/train/subject_train.txt|Training set subjects
/UCI HAR Dataset/test/subject_test.txt |Testnig set subjects
/UCI HAR Dataset/activity_labels.txt|Index to descriptive activity labels
/UCI HAR Dataset/features.txt  |Name vector of all features
   
## 2. Transformation procedure (in general):
- **Read all the files mentioned in part 1.**
  - This is accomplish by using `readLines()`
  - Particularly, the program reads the X_train.txt and X_test.txt as `rawTrainVec` and `rawTestVec`.
- **Make the raw training and testing data tidy by turning them into matrices**
  - Both rawTrainVec and rawTestVec are vectors and each element represents a line in the original input files. The program first split the elements of the vectors by " "(spaces). After that the program removes redundant element that are empty strings (""). After that we get two tidy matrices, `tidyTrainMatrix` and `tidyTestMatrix`.
- **Transform the matrices into data frames and combine them together:**
  - After that we get the data frame called `DF`.
- **Extract only the measurements on the mean and standard deviation:**
  - The program uses `grep()` to match `std()` and `mean()`.
- **Sort the data frame `DF` by the order of "subject" and "acitivity".**
- **Calulate the mean of each measurement:**
   1. Split DF by the intersaction of two factors: "subject" and "activity". Then we get a list called `intermediate`.
   2. For each data frame in the list `intermediate`, we calculate the mean of each measurement.
   3. Unlist the list `intermediate` and get a new data frame called `newDF`.
- **Replace all the activity labels with descriptive acitivity names.**
- **Output a .csv table and print the final data frame we get.**
