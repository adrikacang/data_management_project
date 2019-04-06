library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

names(crime_merge_lsoa)[names(crime_merge_lsoa) == "LSOA code.x"] <- "LSOA11CD"
lsoa_lookup_merge <- merge(x=lsoa_lookup, y=crime_merge_lsoa, by='LSOA11CD')

DimLocation <- select(lsoa_lookup_merge, c("LSOA11CD","WD17NM", "LAD17NM"))

colnames(DimLocation) <- c("Location ID", "Area", "City")
#Remove duplicates observations
write.csv(lsoa_lookup_merge, file="LSOA Lookup Merge.csv", row.names = FALSE)