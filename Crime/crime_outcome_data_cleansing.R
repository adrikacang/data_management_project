library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
crime_streets <- read_csv('south-yorkshire-street.csv')

#Rename Column Month to Date 
colnames(crime_outcomes)[2] <- "Date"

#Simple Frequency count
count(crime_outcomes, 'Crime ID')
count(crime_outcomes, 'Month')
count(crime_outcomes, 'Reported by')
count(crime_outcomes, 'Falls within')
count(crime_outcomes, 'Longitude')
count(crime_outcomes, 'Latitude')
count(crime_outcomes, 'Location')
count(crime_outcomes, 'LSOA code')
count(crime_outcomes, 'LSOA name')
count(crime_outcomes, 'Outcome type')

#Check null values of variables for dimension
sum(is.na(crime_outcomes$`Crime ID`))
sum(is.na(crime_outcomes$Date))
sum(is.na(crime_outcomes$Longitude))
sum(is.na(crime_outcomes$Latitude))
sum(is.na(crime_outcomes$Location))
sum(is.na(crime_outcomes$`LSOA code`))
sum(is.na(crime_outcomes$`Outcome type`))

#Check the consistency of data types 
table(sapply(crime_outcomes$`Crime ID`, class))

#Store indexes of missing values in an integer-valued vector 
MissingValues= which(is.na(crime_outcomes), arr.ind=TRUE)
#Get rownames of missing values and store in object x 
x = rownames(crime_outcomes)[MissingValues[,1]]
#Get column names of missing values and store in object y 
y = colnames(crime_outcomes)[MissingValues[,2]]
#Merge objects x and y with equal dimensions 
LocatedMissingValues = paste(x, y, sep=" ") 
LocatedMissingValues


#Check if the columns contain any non-numeric values 
NonNum <- unlist(lapply(crime_outcomes, is.numeric)) 
NonNum
#List all values in non-numeric columns 
crime_outcomes[ , NonNum]

#Check if the columns contain any non-character values 
NonChar <- unlist(lapply(crime_outcomes, is.character)) 
NonChar
#List all values in non-charactor columns 
crime_outcomes[ , NonChar]

#Identify and locating invalid value
#Select & display missing Crime ID value
crime_outcomes %>% filter(is.na(`Crime ID`))
crime_outcomes %>% filter(is.na(Month))
crime_outcomes %>% filter(is.na(Longitude))
crime_outcomes %>% filter(is.na(Latitude))
crime_outcomes %>% filter(is.na(`LSOA code`))
crime_outcomes %>% filter(is.na(`Outcome type`))


#Check the month pattern
bpa(crime_outcomes$Month, unique_only = TRUE)

#Check the LSOA Code pattern
bpa(crime_outcomes$`LSOA code`, unique_only = TRUE)  

#Split month and year column
crime_outcomes <- separate(data = crime_outcomes, col = Month, sep="[-]", 
                           remove=FALSE, convert=TRUE, into=c("Year","Month"))

#Select & display invalid specified dates
subset(crime_outcomes, Month <= 0 & Month > 12 || Year < 2015 & Year > 2018) 

#Identifying duplicate values of crime ID
#Create data frame to hold duplicate values from defined coumn
duplicate1 <- data.frame(table(crime_outcomes$`Crime ID`))
#count the frequency of each duplicate
duplicate1[duplicate1$Freq > 1,]
#show the observation with user defined duplicate 
crime_outcomes[crime_outcomes$`Crime ID` %in% duplicate1$Var1[duplicate1$Freq > 1],]

#Remove duplicates observations
crime_outcomes <- unique(crime_outcomes)

#Integrity Checks Between Datasets
anti_join(crime_outcomes, crime_streets, by='Crime ID')

