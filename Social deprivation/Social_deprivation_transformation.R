library(readr)

#Read social deprivation data, in following sections use "sd data" referring to "social deprivation data"
social_deprivation <- read_csv("social_deprivation.csv")

crime_streets <- read_csv('south-yorkshire-street.csv')
crime_outcomes <- read_csv('south-yorkshire-outcome.csv')

#Clean social deprivation data


#Filter to retrieve south yorkshire deprivation datasets only
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)
crime_merge_lsoa <- crime_merge[,c(8,9)]
crime_merge_lsoa <- distinct(crime_merge_lsoa) #remove duplicated values
social_deprivation_south_yorkshire <- merge(x = social_deprivation, y = crime_merge_lsoa, by.x = "LSOA code (2011)",by.y='LSOA code.x')
