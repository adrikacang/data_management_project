library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

crime_streets <- read_csv('south-yorkshire-street.csv')


#Rename Column Month to Date 
colnames(crime_streets)[2] <- "Date"

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

#Check the consistency of data types 
table(sapply(crime_streets$Longitude, class))
table(sapply(crime_streets$Latitude, class))
table(sapply(crime_streets$`Crime ID`, class))

#Check the month pattern
bpa(crime_streets$Month, unique_only = TRUE)

#Check the LSOA Code pattern
bpa(crime_streets$`LSOA code`, unique_only = TRUE)  

#Split month and year column
crime_streets <- separate(data = crime_streets, col = Month, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))

#Select & display invalid specified dates
subset(crime_streets, Month <= 0 & Month > 12 || Year < 2015 & Year > 2018) 

#Remove duplicates observations
crime_streets <- unique(crime_streets)

#Integrity Checks Between Datasets
anti_join(crime_outcomes, crime_streets, by='Crime ID')

crime_streets <- separate(data = crime_streets, col = `LSOA name`, sep="[ ]", remove=FALSE, convert=TRUE, into=c("County", "Code"))
crime_street_sheffield <- crime_streets[which(crime_streets$county == "Sheffield"),]
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)

#CrimeLocationDim (LSOA code, Crime ID, Location)
CrimeLocationDim <- select(crime_merge,1,6,7)

#CrimeOutcomeDim (CrimeID, Outcome, LastOutcome, CrimeType)
CrimeOutcomeDim <- select(crime_merge,1) 
#LocationDim (LSOA code, LSOA name, Distinct)
#SocialDep (MDI Rank, LSOA code, MDI Score, MDI Percentile)