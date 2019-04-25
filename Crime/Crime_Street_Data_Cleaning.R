library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
crime_streets <- read_csv('south-yorkshire-street.csv')

#Rename Column Month to Date 
colnames(crime_streets)[2] <- "Date"

#Simple Frequency count
count(crime_streets, 'Crime ID')
count(crime_streets, 'Month')
count(crime_streets, 'Reported by')
count(crime_streets, 'Falls within')
count(crime_streets, 'Longitude')
count(crime_streets, 'Latitude')
count(crime_streets, 'Location')
count(crime_streets, 'LSOA code')
count(crime_streets, 'LSOA name')
count(crime_streets, 'Crime type')
count(crime_streets, 'Last outcome category')
count(crime_streets, 'Context')

#Check null values of variables for dimension
sum(is.na(crime_streets$`Crime ID`))
sum(is.na(crime_streets$Month))
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

#Store indexes of missing values in an integer-valued vector 
MissingValues= which(is.na(crime_streets), arr.ind=TRUE)
#Get rownames of missing values and store in object x 
x = rownames(crime_streets)[MissingValues[,1]]
#Get column names of missing values and store in object y 
y = colnames(crime_streets)[MissingValues[,2]]
#Merge objects x and y with equal dimensions 
LocatedMissingValues = paste(x, y, sep=" ") 
LocatedMissingValues


#Check if the columns contain any non-numeric values 
NonNum <- unlist(lapply(crime_streets, is.numeric)) 
NonNum
#List all values in non-numeric columns 
crime_streets[ , NonNum]

#Check if the columns contain any non-character values 
NonChar <- unlist(lapply(crime_streets, is.character)) 
NonChar
#List all values in non-charactor columns 
crime_streets[ , NonChar]

#Identify and locating invalid value
#Select & display missing Crime ID value
crime_streets %>% filter(is.na(`Crime ID`))
crime_streets %>% filter(is.na(Month))
crime_streets %>% filter(is.na(`Reported by`))
crime_streets %>% filter(is.na(`Falls within`))
crime_streets %>% filter(is.na(Longitude))
crime_streets %>% filter(is.na(Latitude))
crime_streets %>% filter(is.na(`LSOA code`))
crime_streets %>% filter(is.na(`LSOA name`))
crime_streets %>% filter(is.na(`Crime type`))
crime_streets %>% filter(is.na(`Last outcome category`))
crime_streets %>% filter(is.na(Context))

#Check the consistency of data types 
table(sapply(crime_streets$`Crime ID`, class))

#Check the month pattern
bpa(crime_streets$Date, unique_only = TRUE)

#Check the LSOA Code pattern
bpa(crime_streets$`LSOA code`, unique_only = TRUE)  

#Split month and year column
crime_streets <- separate(data = crime_streets, col = Date, sep="[-]", 
                          remove=FALSE, convert=TRUE, into=c("Year", "Month"))

#Split Country and code column
crime_streets <- separate(data = crime_streets, col = `LSOA name`, sep="[ ]", 
                          remove=FALSE, convert=TRUE, into=c("County", "Code"))

#Select & display invalid specified dates
subset(crime_streets, Month <= 0 & Month > 12 || Year < 2015 & Year > 2018) 

#Identifying duplicate values of crime ID
#Create data frame to hold duplicate values from defined coumn
duplicate <- data.frame(table(crime_streets$`Crime ID`))
#count the frequency of each duplicate
duplicate[duplicate$Freq > 1,]
#show the observation with user defined duplicate 
crime_streets[crime_streets$`Crime ID` %in% duplicate$Var1[duplicate$Freq > 1],]

#Remove duplicates observations
crime_streets <- unique(crime_streets)

#Integrity Checks Between Datasets
anti_join(crime_outcomes, crime_streets, by='Crime ID')

<<<<<<< HEAD
#Split Country and code column
crime_streets <- separate(data = crime_streets, col = `LSOA name`, sep="[ ]", remove=FALSE, convert=TRUE, into=c("County", "Code"))
crime_street_sheffield <- crime_streets[which(crime_streets$County == "Sheffield"),]

#merging dataset
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)
=======
>>>>>>> f262a57927aa764892eecee7a0695f8c5436c00b






# Sheffield County (using the subset function) 
Sheffield1 <- subset(crime_merge, County =="Sheffield")
#display all the sheffield data  
Sheffield1
