#merging dataset
q5_crime_merge <- separate(data = crime_merge, col = `LSOA name`, sep="[ ]", remove=FALSE, convert=TRUE, into=c("City", "Code"))

#Select Specific Column
FactQuestion5 <- select(q5_crime_merge, c("Crime ID", "Month.x", "City.x"))
#Rename column name of fact table
colnames(FactQuestion5) <- c("Crime ID", "Time ID", "City")