## Tidy data assignment
### Description of the run_analysis.R file

The script requires that the source data is in the user's working directory.

Required libraries are loaded into R.

The subject_test.txt and subject_train.txt files containing the volunteer IDs are loaded into R variables and then combined into a single vector combinedRespID.  
The y_test.txt file and y_train.txt containing the activity IDs are loaded into R and combined into a single vector combinedActivityID.  
The X_test.txt file and X_train.txt containing the collected data are loaded into R and combined into a data set combinedMeasures.  

A combined data set, combinedData, containing the volunteer Ids, the activity IDs and the collected data is made.

The columns containing the IDs and the all the measure variables that end with either mean() or std() from the data set are identified in the variable colsToKeep and these columns are loaded into a new data set combinedDataMeanSD.

A new variable called Activity is created that replaces the codes in the original activity variables with text. The old activity variable is removed and the new one moved to the second column position so it is next to the Subject ID field.

The subject ID fields and Activity fields are named "SubjectID" and "Activity" respectively. The other variables take the same names as in the document features.txt that came with the raw data.

The melt function transforms the data so that the third column contains the measures name and the fourth column the value. 

The dcast function is then used to calculate the a mean for each variable for each combination of subjectId and Activity.

The melt function is used again to produce a long thin data set with the measure names in the third column and the means in the fourth column.

Descriptive labels are applied to each of the four columns in the final tidy data set.

Finally, The tidy data is exported to a text file.

Codebook.md describes the variables in the tidy data set.