#Store indexes of missing values in an integer-valued vector MissingValues=
which(is.na(crime_merge), arr.ind=TRUE)

#Store indexes of missing values in an integer-valued vector 
MissingValues= which(is.na(crime_merge), arr.ind=TRUE)
#Get rownames of missing values and store in object x 
x = rownames(crime_merge)[MissingValues[,1]]
#Get column names of missing values and store in object y 
y = colnames(crime_merge)[MissingValues[,2]]
#Merge objects x and y with equal dimensions 
LocatedMissingValues = paste(x, y, sep=" ") 
LocatedMissingValues


#Check if the columns contain any non-numeric values 
NonNum <- unlist(lapply(crime_merge, is.numeric)) 
NonNum
#List all values in non-numeric columns 
crime_merge[ , NonNum]

#Check if the columns contain any non-character values 
NonChar <- unlist(lapply(crime_merge, is.character)) 
NonChar
#List all values in non-character columns 
crime_merge[ , NonChar]

summary(crime_merge)