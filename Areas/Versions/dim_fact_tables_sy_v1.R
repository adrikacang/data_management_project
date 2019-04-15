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
DimLocation <- select(location,c("LSOA11CD","WD17NM","LAD17NM"))
colnames(DimLocation)<- c("LSOA Code","Area","City")
write.csv(DimLocation, file="Areas/DimLocation_SY_Areas_City.csv")

# Time Dimension
# Split year and month into integer columns

Time <- data.frame(TimeID=character(), TimeYear=character(), TimeMonth=character(),stringsAsFactors=FALSE)
k=0;
for(m in 2015:2018){
  for(n in 1:12){
    k=k+1
    Time[k,1] <- sprintf("%d-%d",m,n)
    Time[k,2] <- m #sprintf("%d",n)
    Time[k,3] <- n #sprintf("%d",m)
    if(n<10)
        Time[k,1] <- sprintf("%d-0%d",m,n)
  }
}

names(Time)<-c('Time ID', 'Year', 'Month')    
write.csv(Time, file="Areas/DimTime_SY_Areas.csv")

#----
# Crime type
# load crimes from file using library tidyverse
crime_areas_SY <- read_csv("Areas/crime-areas-SY.csv")
Crime <- data.frame(CrimeID=integer(), CrimeType=character(),stringsAsFactors=FALSE)
names(Crime) <- c('Crime ID','Crime Type')
crimetype <- unique(crime_areas_SY$`Crime type`)

for( n in 1:length(crimetype)){
  Crime[n,2]<- crimetype[n]
}
Crime$`Crime ID` <- seq.int(nrow(Crime))

write.csv(Crime, file="Areas/DimCrime_SY_Areas.csv")

#DimTime <- select(crime_areas, c("X1","Year","Month"))
#colnames(DimTime) <- c("Time ID", "Year", "Month")
#DimTime <- unique(DimTime)
#write.csv(DimTime, file="Areas/DimTime_SY_Areas.csv")

# Fact table: already created in the extract_transform_areas.R
#FactQ2 <- select(crime_areas, c("Year","Month","Location", "Crime type", "Area"))
#

