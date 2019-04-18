crime_outcomes <- read_csv('south-yorkshire-outcome.csv')
crime_streets <- read_csv('south-yorkshire-street.csv')

#Rename Column Month to Date 
colnames(crime_streets)[2] <- "Date"
colnames(crime_outcomes)[2] <- "Date"

#Split month and year column
crime_outcomes <- separate(data = crime_outcomes, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))
crime_streets <- separate(data = crime_streets, col = Date, sep="[-]", remove=FALSE, convert=TRUE, into=c("Year", "Month"))

crime_merge <- merge(x=crime_streets, y=crime_outcomes, by='Crime ID', all=TRUE)

