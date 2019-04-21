crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
crime_streets <- read_csv('south-yorkshire-street.csv')

#Rename Column Month to Date 
colnames(crime_streets)[2] <- "Date"
colnames(crime_outcomes)[2] <- "Date"

#Split month and year column
crime_outcomes <- separate(data = crime_outcomes, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))
crime_streets <- separate(data = crime_streets, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))

crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)

#Create Crime Dimension
DimCrime <- select(crime_merge,c("Crime type","Outcome type"))
DimCrime <- unique(DimCrime[c("Crime type", "Outcome type")])
DimCrime$'Dim Crime ID' <- seq.int(nrow(DimCrime))
colnames(DimCrime)<- c("Crime Type","Outcome Type", "Dim Crime ID")

#Create Time Dimension
DimTime <- select(crime_merge, c("Date.x"))
DimTime <- separate(data = DimTime, col = Date.x, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year","Month"))
colnames(DimTime) <- c("Time ID", "Year", "Month")
