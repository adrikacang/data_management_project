#Select Specific Column
crime_fact_table <- select(crime_fact, c("Crime ID", "Date.x", "Date.y", "Dim Crime ID.x", "Dim Location ID"))
crime_dimension_table <- select(DimCrimeMerge, c("Dim Crime ID","Crime Type", "Outcome Type"))
location_dimension_table <- select(DimLocationMerge, c("Dim Location ID", "LSOA Code", "City", "Area", "Street"))
time_dimension_table <- select(DimTime, c("Time ID", "Year", "Month"))

#Rename column name of fact table
colnames(crime_fact_table) <- c("Crime ID", "Start TimeDim ID", "End TimeDim ID", "CrimeDim ID", "LocationDim ID")
colnames(crime_dimension_table) <- c("CrimeDim ID", "Crime Type", "Outcome Type")
colnames(location_dimension_table) <- c("LocationDim ID", "LSOA Code", "End TimeDim ID", "City", "Area", "Street")
colnames(time_dimension_table) <- c("TimeDim ID", "Year", "Month")
#Pick Specific Columns From Dimension Tables