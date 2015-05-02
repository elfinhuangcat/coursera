READ ME
=======

###What are in This Repo
1. A directory "UCI HAR Dataset": contains all data needed.
2. run_analysis.R: The source script. This is the only one.
3. README.md: The file you are reading now.
4. CodeBook.md: The code book telling you how the program transform the data into what we need.
5. data.csv: The output of the program. It is the tidy data we need.
6. .Rhistory: It is just an auto-generated file. You can ignore it.

###Before You Run the Program
**Important:**
Because the size of data set is 269MB(unzipped) and it is too large to put it here. Every time I clone the datasciencecoursera repo I can feel the pain. So you will need to download the dataset on your own and put the zipped dataset under the directory "CleaningDataCourseProject". Finally you will need to unzip it.
**Where can you find the data set:**
Human Activity Recognition Using Smartphones Data Set 
https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###How to Run This Program
1. Clone this repository to your local machine.
2. All the data and scripts needed lie in this repo.
3. In your R platform, type:

       `source("..path_to_the_script_file/run_analysis.R")`

   And then call the function `run()` by typing:

       `run("..path_to_the_script_file")`

   This will set the current working directory to the specified dir.

   **Or you can set the working directory before you source the file (preferred):**

       `setwd("..path_to_the_script_file")`

   And then source the file by typing:

       `source("run_analysis.R")`	

   And then call the function run by typing:

       `run()` 


_Contact Info:_

_Yaxin_

_yaxinhuangcat@icloud.com_


