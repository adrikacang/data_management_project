library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

#Deprivation
social_deprivation <- read_csv("Indices-of-Deprivation-2015.csv")
crime_streets <- read_csv('south-yorkshire-street.csv')
crime_outcomes <- read_csv('south-yorkshire-outcome.csv')

#Filter to retrieve south yorkshire deprivation datasets only
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)
crime_merge_lsoa <- crime_merge[,c(8,9)]
crime_merge_lsoa <- distinct(crime_merge_lsoa) #remove duplicated values
social_deprivation_south_yorkshire <- merge(x = social_deprivation, y = crime_merge_lsoa, by.x = "LSOA code (2011)",by.y='LSOA code.x')

#Check null values of variables for dimension
sum(is.na(social_deprivation$`LSOA code (2011)`))
sum(is.na(social_deprivation$`LSOA name (2011)`))
sum(is.na(social_deprivation$`Local Authority District code (2013)`))
sum(is.na(social_deprivation$`Local Authority District name (2013)`))
sum(is.na(social_deprivation$`Index of Multiple Deprivation (IMD) Score`))
sum(is.na(social_deprivation$`Index of Multiple Deprivation (IMD) Decile (where 1 is most deprived 10% of LSOAs)`))
sum(is.na(social_deprivation$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`))


#Check the LSOA Code pattern
bpa(crime_outcomes$`LSOA code`, unique_only = TRUE)  

#Integrity Checks Between Crime Outcomes and Streets Datasets
join_deprivation_streets <- anti_join(crime_streets, social_deprivation, by = c("LSOA code" = "LSOA code (2011)"))
join_deprivation_outcome <- anti_join(crime_outcomes, social_deprivation, by = c("LSOA code" = "LSOA code (2011)"))
