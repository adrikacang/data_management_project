# Load libraries
library('readr')
library('dplyr')

# Selecting the columns, 'LSOA code (2011)', 'LSOA name (2011)', 'Local Authority District code (2013)', 'Local Authority District name (2013)',
# 'Index of Multiple Deprivation (IMD) Score' and 'Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)' 6 columns
Sheffield <- read_csv("Social\ deprivation/Sheffield_social_deprivation.csv")
Sheffield <- as_tibble(Sheffield) # prints a little nicer
Sheffield_data <- select(Sheffield, 1:6) # Select first 6 columns

# Export data
write.csv(Sheffield_data, file="Sheffield_selected.csv", row.names = FALSE)

# Cleansing data

# Step 1, check the values of character variables
count(Sheffield,Sheffield$`Local Authority District code (2013)`)
count(Sheffield,Sheffield$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`)



