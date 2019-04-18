library(readr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(bpa)

#Create Location Dimension in South Yorkshire
names(crime_merge_lsoa)[names(crime_merge_lsoa) == "LSOA code.x"] <- "LSOA11CD"
lsoa_lookup_merge <- merge(x=lsoa_lookup, y=crime_merge_lsoa, by='LSOA11CD')
DimLocation<- lsoa_lookup_merge[ lsoa_lookup_merge$LAD17NM == "Sheffield" |  lsoa_lookup_merge$LAD17N == "Rotherham" | lsoa_lookup_merge$LAD17N == "Doncaster" |  lsoa_lookup_merge$LAD17N == "Barnsley", ]
DimLocation <- select(DimLocation, c("LSOA11CD","WD17NM", "LAD17NM", "Location.x"))
colnames(DimLocation) <- c("LSOA Code", "Area", "City", "Street")
DimLocation <- unique(DimLocation)

#Remove duplicates observations
write.csv(lsoa_lookup_merge, file="Location Dimension.csv", row.names = FALSE)