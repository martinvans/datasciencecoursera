# Tidied Data from the Human Activity Recognition Using Smartphones Dataset


The purpose of this project is to demonstrate my ability to collect, work with, and
clean a data set. The goal is to prepare tidy data that can be used for later analysis. Based on my results, I will be graded by my peers on a series of yes/no questions related to the project. I have submitted the following: 

1) a tidy data set as described below, 
2) a link to the Github repository with my script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



Using the `run_analysis.R` script, the data was pulled in from the website. The test and train sets have were merged and the subject identifiers and activity labels were pulled in to create a single data set. The activity identifiers were translated from identifiers to more verbose names. Only the mean and standard deviation variables were kept. Those variables were further summarized by taking their mean for each subject/activity pair. 

The final data set can be found in the `tidyMeans.txt` file, which can be read into R with `read.table("tidyMeans.txt", header = TRUE)`. A detailed description of the variables can be found in `CodeBook.md`. The basic naming convention is:

  Mean{Time|Freq}{measurement name}{Mean|StdDev}{X|Y|Z}

Where `Time|Freq` is either Time or Frequency, indicating whether the measurement comes from the time or frequency domain, `measurement name` is the name of one of the original measurement features, `Mean|StdDev` is either Mean or StdDev, indicating whether the original measurement was a mean or standard deviation variable, and `X|Y|Z` is X, Y, or Z, indicating the axis along which the measurement was taken. For magnitude measurements, there is no axis. In that case the variable will not have an X, Y or Z at the end of the name.
