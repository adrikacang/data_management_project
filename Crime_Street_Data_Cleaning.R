crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
crime_streets <- read_csv('south-yorkshire-street.csv')


#Rename Column Month to Date 
colnames(crime_streets)[2] <- "Date"

#Check null values of variables for dimension
sum(is.na(crime_streets$`Crime ID`))
sum(is.na(crime_streets$Date))
sum(is.na(crime_streets$`Reported by`))

sum(is.na(crime_streets$`Falls within`))
sum(is.na(crime_streets$Longitude))
sum(is.na(crime_streets$Latitude))
sum(is.na(crime_streets$Location))
sum(is.na(crime_streets$`LSOA code`))
sum(is.na(crime_streets$`LSOA name`))
sum(is.na(crime_streets$`Crime type`))
sum(is.na(crime_streets$`Last outcome category`))
sum(is.na(crime_streets$Context))

#Check the consistency of data types 
table(sapply(crime_streets$Longitude, class))
table(sapply(crime_streets$Latitude, class))
table(sapply(crime_streets$`Crime ID`, class))

#Check the month pattern
bpa(crime_streets$Date, unique_only = TRUE)

#Check the LSOA Code pattern
bpa(crime_streets$`LSOA code`, unique_only = TRUE)  

#Split month and year column
crime_streets <- separate(data = crime_streets, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))

#Select & display invalid specified dates
subset(crime_streets, Month <= 0 & Month > 12 || Year < 2015 & Year > 2018) 

#Remove duplicates observations
crime_streets <- unique(crime_streets)

#Integrity Checks Between Datasets
anti_join(crime_outcomes, crime_streets, by='Crime ID')

#Split Country and code column
crime_streets <- separate(data = crime_streets, col = `LSOA name`, sep="[ ]", remove=FALSE, convert=TRUE, into=c("County", "Code"))
crime_street_sheffield <- crime_streets[which(crime_streets$county == "Sheffield"),]

#merging dataset
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)

counts <- table(crime_merge$County, useNA ="ifany")
names(counts)[is.na(names(counts))] <- "NA"

# Display barplot and pieplot
barplot(counts, main="Country Distribution", xlab='Counts', ylab='Country', horiz=TRUE)
pie(counts, main="Country Distribution")
count(crime_merge, County)

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

# Sheffield County (using the subset function) 
Sheffield1 <- subset(crime_merge, County =="Sheffield")
#display all the sheffield data  
Sheffield1
