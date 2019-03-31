install.packages('dplyr')

crime_outcomes = read_csv('south-yorkshire-outcome.csv')
library(dplyr)

#Check null values of variables for dimension
sum(is.na(crime_outcomes$`Crime ID`))
sum(is.na(crime_outcomes$Month))
sum(is.na(crime_outcomes$Longitude))
sum(is.na(crime_outcomes$Latitude))
sum(is.na(crime_outcomes$Location))
sum(is.na(crime_outcomes$`LSOA code`))
sum(is.na(crime_outcomes$`LSOA name`))
sum(is.na(crime_outcomes$`Outcome type`))

#check data consistency
