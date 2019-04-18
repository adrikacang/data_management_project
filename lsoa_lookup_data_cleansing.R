library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

#Deprivation
crime_streets <- read_csv('south-yorkshire-street.csv')
crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
lsoa_lookup <- read_csv('lsoa-lookup-2011.csv')

#Filter to retrieve south yorkshire deprivation datasets only
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)
crime_merge_lsoa <- crime_merge[,c("LSOA code.x","Location.x")]
crime_merge_lsoa <- distinct(crime_merge_lsoa) #remove duplicated values


#Check null values of variables for dimension
sum(is.na(lsoa_lookup$LSOA11CD))
sum(is.na(lsoa_lookup$WD17NM))


#Check the LSOA Code pattern
bpa(crime_outcomes$`LSOA code`, unique_only = TRUE)  

#Integrity Checks Between Crime Outcomes and Streets Datasets
find_unidentified_location <- anti_join(crime_merge_lsoa, lsoa_lookup, by = c("LSOA code.x" = "LSOA11CD"))
