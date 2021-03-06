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
crime_areas <- read_csv("Areas/crime-areas-SY.csv")

# Dimension Table

# Loaction Dimension

# Split year and month into integer columns
DimLocation <- select(crime_areas,c("LSOA code","Area","City"))
colnames(DimLocation)<- c("Location ID","Area","City")
#write.csv(DimLocation, file="Areas/DimLocation_SY_Areas.csv")

# Time Dimension
DimTime <- select(crime_areas, c("X1","Year","Month"))
colnames(DimTime) <- c("Time ID", "Year", "Month")
DimTime <- unique(DimTime)
write.csv(DimTime, file="Areas/DimTime_SY_Areas.csv")

# Fact table: already created in the extract_transform_areas.R
#FactQ2 <- select(crime_areas, c("Year","Month","Location", "Crime type", "Area"))
#

