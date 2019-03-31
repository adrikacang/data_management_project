install.packages('dplyr')
install.packages('readr')
install.packages('tidyverse')
install.packages('tidyr')
install.packages('bpa')

library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

crime_outcomes <- read_csv('south-yorkshire-outcome.csv')

#Rename Column Month to Date 
colnames(crime_outcomes)[2] <- "Date"

#Check null values of variables for dimension
sum(is.na(crime_outcomes$`Crime ID`))
sum(is.na(crime_outcomes$Month))
sum(is.na(crime_outcomes$Longitude))
sum(is.na(crime_outcomes$Latitude))
sum(is.na(crime_outcomes$Location))
sum(is.na(crime_outcomes$`LSOA code`))
sum(is.na(crime_outcomes$`Outcome type`))

#Check the consistency of data types 
table(sapply(crime_outcomes$Longitude, class))
table(sapply(crime_outcomes$Latitude, class))
table(sapply(crime_outcomes$`Crime ID`, class))

#Check the month pattern
bpa(crime_outcomes$Month, unique_only = TRUE)

#Check the LSOA Code pattern
bpa(crime_outcomes$`LSOA code`, unique_only = TRUE)  

#split month and year column
crime_outcomes <- separate(data = crime_outcomes, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=crime_date)

#Identify Potential Outliers
date_range <- subset(crime_outcomes, Month <= 0 & Month > 12 || Year < 2015 & Year > 2018) 

#Identify Invalid Dates


#Remove duplicates observations
crime_outcomes <- unique(crime_outcomes)

#Integrity Checks Between Datasets
