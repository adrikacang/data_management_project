#Sheffield Hallam University 2019
#ADM project
#Anna Kosheleva
#Extract and transform datasets
#for South Yorkshire

# Use this library to read CSV files
library(tidyverse)

# Use this library to filter dataset
library(dplyr)

#----
# load lsoa codes from file using library tidyverse
lsoa <- read_csv("lsoa-lookup-2011.csv")

# load crimes by streets using library tidyverse
crimestreets <- read_csv("south-yorkshire-street.csv")

#----
# extract SY lsoa codes only
lsoa_sheffield <- lsoa[ lsoa$LAD17NM == "Sheffield" | lsoa$LAD17NM == "Rotherham" | lsoa$LAD17NM == "Doncaster" | lsoa$LAD17NM == "Barnsley",]

# Save in csv file
write.csv(lsoa_sheffield, file="lsoa-lookup-SY-2011.csv")

# Reduced table for LSOA codes: street LSOA code, street LSOA name, area LSOA code, area LSOA name
lsoa_sheffield_red <- lsoa_sheffield[ ,c(1:4,7)]

#---- 
# check for missing values
# first show total number of missing values
# LSOA (only check in use columns)
sum(is.na(lsoa_sheffield_red$LSOA11CD))
sum(is.na(lsoa_sheffield_red$WD17NM))
# Crime (only check in use columns)
sum(is.na(crimestreets$'LSOA code'))
sum(is.na(crimestreets$'Crime type'))

# second remove rows with missing values. use complete.cases() with column number
# LSOA
# column LSOA11CD - 1 column (street code)
lsoa_sheffield_nona <- lsoa_sheffield_red[complete.cases(lsoa_sheffield_red[,1]), ]
# column WD17NM - 4 column (area name)
lsoa_sheffield_nona <- lsoa_sheffield_nona[complete.cases(lsoa_sheffield_nona[,4]), ]

# Crime
# column LSOA.code - 8 column (LSOA code street)
crimestreets_nona <- crimestreets[complete.cases(crimestreets[,8]), ]
# column Crime.type -  10 column (crime type)
crimestreets_nona <- crimestreets_nona[complete.cases(crimestreets_nona[,10]), ]

# Reduced tables: Date, Street, Street LSOA code, street LSOA name, Crime type
crimestreets_nona_red <- crimestreets_nona[ ,c(2,7:11)]

# Split year and month into integer columns
crimestreets_nona_red <- separate(data = crimestreets_nona_red, col = Month, into=c("Year","Month"), sep="[-]", remove=TRUE, convert=TRUE)

#----
# Merge crime streets with areas
# Create data frame
crimestreets_area_red = mutate(crimestreets_nona_red, Area='', City='')
t2<-data.frame(c1=character(),
               c2=character(),
               c3=character(),
               c4=character(),
               c5=character(),
               c6=character(),
               c7=character(),
               c8=character(),
               c9=character(),
               stringsAsFactors=FALSE)

# Column names
names(t2)<-names(crimestreets_area_red)

# Add area column
for(n in 1:nrow(lsoa_sheffield_nona)){
  
  # Select all rows with LSOA codes with index n
  t  <- crimestreets_area_red[crimestreets_area_red$`LSOA code`== as.character(lsoa_sheffield_nona[n,1]), ]
  
  # Remove all missing values in dates
  t1 <- t[complete.cases(t[ ,c(1,2)]), ]
  
  # Add area name to empty column 8
  t1[ ,8] <- as.character(lsoa_sheffield_nona[n,4])
  # Add city name to empty column 7
  t1[ ,9] <- as.character(lsoa_sheffield_nona[n,5])
  
  # Add table t1 at the end of t2
  t2 <-rbind(t2,t1)
}

#Save results in csv file
write.csv(t2, file="crime-areas-SY.csv")




