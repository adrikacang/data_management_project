# Load libraries
library('readr')
library('dplyr')

# Selecting the columns, 'LSOA code (2011)', 'LSOA name (2011)', 'Local Authority District code (2013)', 'Local Authority District name (2013)',
# 'Index of Multiple Deprivation (IMD) Score' and 'Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)' 6 columns
Sheffield <- as_tibble(Sheffield) # prints a little nicer
Sheffield_data <- select(Sheffield, 1:6) # Select first 6 columns

# Export data
write.csv(Sheffield_data, file="Sheffield_selected.csv", row.names = FALSE)

# Cleansing data

# Step 1, check the values of character variables
count(Sheffield,Sheffield$`Local Authority District code (2013)`)
count(Sheffield,Sheffield$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`)



#Filter to retrieve south yorkshire deprivation datasets only
crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)
crime_merge_lsoa <- crime_merge[,c(8,9)]
crime_merge_lsoa <- distinct(crime_merge_lsoa) #remove duplicated values
social_deprivation_south_yorkshire <- merge(x = social_deprivation, y = crime_merge_lsoa, by.x = "LSOA code (2011)",by.y='LSOA code.x')
