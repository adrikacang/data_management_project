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
crime_areas <- read_csv("crime-areas-Sheffield.csv")

# Dimension Table

# Loaction Dimension

# Split year and month into integer columns
t <- separate(data = crime_areas, col = 'LSOA name', into=c("City","code"), sep="[ ]", remove=TRUE, convert=TRUE)
DimLocation <- select(t,c("LSOA code","Area","City"))
colnames(DimLocation)<- c("Location ID","Area","City")

# Time Dimension
DimTime <- select(crime_areas, c("X1","Year","Month"))
colnames(DimTime) <- c("Time ID", "Year", "Month")
DimTime <- unique(DimTime)

# Fact table: already created in the extract_transform_areas.R
#FactQ2 <- select(crime_areas, c("Year","Month","Location", "Crime type", "Area"))
#

