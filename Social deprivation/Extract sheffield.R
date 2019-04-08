# Extracting Sheffield area records filtering with 'Local Authority District name (2013)' equals to (contains) 'Sheffield'
# Load libraries
library(readr)
library(dplyr)
library(tidyverse)


# Load social deprivation data, in following sections use "sd data" referring to "social deprivation data"
social_deprivation <- read_csv("Social\ deprivation/social_deprivation.csv")

# Extract Sheffield data
Sheffield <- social_deprivation[which(social_deprivation$`Local Authority District name (2013)`== "Sheffield"),]

# Export Data to csv file
write.csv(Sheffield, file="Social\ deprivation/Sheffield_social_deprivation.csv", row.names = FALSE)
