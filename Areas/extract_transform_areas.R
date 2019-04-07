#Sheffield Hallam University 2019
#ADM project
#Anna Kosheleva
#Extract and transform datasets

#Use this library to read CSV files
library(tidyverse)

#Use this library to filter dataset
library(dplyr)

#----
# load lsoa codes from file using library tidyverse
lsoa <- read_csv("lsoa-lookup-2011.csv")
# load lsoa codes from file using R function
#lsoa <- read.csv(file="lsoa-lookup-2011.csv", header=TRUE, sep=",")

#load crimes by streets using library tidyverse
crimestreets <- read_csv("south-yorkshire-street.csv")
#load crimes by streets using R function
#crimestreets <- read.csv(file="south-yorkshire-street.csv", header=TRUE, sep=",")

#----
# extract sheffield lsoa codes only
lsoa_sheffield <- lsoa[ lsoa$LAD17NM == "Sheffield",]
#Save in csv file
write.csv(lsoa_sheffield, file="lsoa-lookup-Sheffield-2011.csv")

lsoa_sheffield_red <- lsoa_sheffield[ ,c(1:4)]

#Not in use
#lsoa_sheffield <- filter(lsoa, LAD17NM == "Sheffield")
#attach(lsoa)
#lsoa_sheffield <- lsoa[ which(LAD17NM == "Sheffield"), ]
#detach(lsoa)

#---- 
# check for missing values
# first show total number of missing values
#LSOA (only check in use columns)
sum(is.na(lsoa_sheffield_red$LSOA11CD))
sum(is.na(lsoa_sheffield_red$WD17NM))
#Crime (only check in use columns)
sum(is.na(crimestreets$'LSOA code'))
sum(is.na(crimestreets$'Crime type'))

# second remove rows with missing values. use complete.cases() with column number
# LSOA
# column LSOA11CD - 1 column
lsoa_sheffield_nona <- lsoa_sheffield_red[complete.cases(lsoa_sheffield_red[,1]), ]
# column WD17NM - 4 column
lsoa_sheffield_nona <- lsoa_sheffield_nona[complete.cases(lsoa_sheffield_nona[,4]), ]

#Crime
# column LSOA.code - 8 column
crimestreets_nona <- crimestreets[complete.cases(crimestreets[,8]), ]
# column Crime.type -  10 column
crimestreets_nona <- crimestreets_nona[complete.cases(crimestreets_nona[,10]), ]

crimestreets_nona_red <- crimestreets_nona[ ,c(2,7:10)]

#----
# merge
#lsoa_sheffield_nona[,1] <- factor(lsoa_sheffield_nona[,1], levels=levels(crimestreets[,8]))

crimestreets_area_red = mutate(crimestreets_nona_red, Area='')
t2<-data.frame(c1=character(),
               c2=character(),
               c3=character(),
               c4=character(),
               c5=character(),
               c6=character(),
               stringsAsFactors=FALSE)
names(t2)<-names(crimestreets_area_red)

for(n in 1:nrow(lsoa_sheffield_nona)){
  t<-crimestreets_area_red[crimestreets_area_red$`LSOA code`== as.character(lsoa_sheffield_nona[n,1]), ]
  t1 <-t[complete.cases(t[ ,1]), ]
  t1[ ,6] <- as.character(lsoa_sheffield_nona[n,4])
  t2 <-rbind(t2,t1)
}
  
write.csv(t2, file="crime-areas-Sheffield.csv")




