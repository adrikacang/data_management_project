#Sheffield Hallam University 2019
#ADM project
#Anna Kosheleva
#Dimension and fact tables

# Use this library to read CSV files
library(tidyverse)

# Use this library to filter dataset
library(dplyr)

#----
# load lsoa codes from file using library tidyverse
location <- read_csv("Areas/lsoa-lookup-SY-2011.csv")

# Dimension Table

# Loaction Dimension

# Split year and month into integer columns
DimLocation <- select(location,c("LSOA11CD","WD17NM","LAD17NM"))
colnames(DimLocation)<- c("LSOA Code","Area","City")
write.csv(DimLocation, file="Areas/DimLocation_SY_Areas_City.csv")

# Time Dimension
#DimTime <- select(crime_areas, c("X1","Year","Month"))
#colnames(DimTime) <- c("Time ID", "Year", "Month")
#DimTime <- unique(DimTime)
#write.csv(DimTime, file="Areas/DimTime_SY_Areas.csv")

# Fact table: already created in the extract_transform_areas.R
#FactQ2 <- select(crime_areas, c("Year","Month","Location", "Crime type", "Area"))
#

