# CourseProject3
This project was very ardous and took a lot of thinking, imagination, will, and sacrafice to do.

"run_analysis.R" is not as complicated as it looks.  
Here are the basic steps:

1. I read in all the data I need
2. Next I idenify the variables that calculated the mean/standard deviation of a measurement (done by using a for-loop and idenifying key words in column names and then transferring needed columns to a list)
3. The orginial tables that were created were updated to only include the columns with mean/standard deviation measurement (done by using select function and using the list from the previous step to idenify the columns needed)
4. Then, I rename the numbers in the activity column of each table to a descriptive name (done by for-looping and refering to table with the activity names)
5. Then find the average of each variable for each combination of subject and activity for both tables (done by group_by and summarise_each function)
6. Finally merge the different tables together by row to create a finished table and "writing" the table on txt file(done by rbind and write.table functions) 
