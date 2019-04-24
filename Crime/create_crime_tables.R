#Select Specific Column
crime_fact_table <- select(crime_fact, c("Crime ID", "Date.x", "Date.y", "Dim Crime ID.x", "Dim Location ID"))
crime_dimension_table <- select(DimCrimeMerge, c("Dim Crime ID","Crime Type", "Outcome Type"))
location_dimension_table <- select(DimLocationMerge, c("Dim Location ID", "LSOA Code", "City", "Area", "Street"))
time_dimension_table <- select(DimTime, c("Time ID", "Year", "Month"))

#Rename column name of fact table
colnames(crime_fact_table) <- c("Crime ID", "Start TimeDim ID", "End TimeDim ID", "CrimeDim ID", "LocationDim ID")
colnames(crime_dimension_table) <- c("CrimeDim ID", "Crime Type", "Outcome Type")
colnames(location_dimension_table) <- c("LocationDim ID", "LSOA Code", "End TimeDim ID", "City", "Area", "Street")
colnames(time_dimension_table) <- c("TimeDim ID", "Years", "Months")
#Pick Specific Columns From Dimension Tables



connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/Asus/Adrian Folders/Database_v4.accdb")

# check to see if we are connected to the access database
sqlTables(connection)

#Drop datable from the access database
#sqlDrop(connection, "DimCrime")

# copy the DimcCrime dataframe to access database table
sqlSave(connection, crime_fact_table, rownames = "id", addPK = T)
sqlSave(connection, crime_dimension_table, rownames = "id", addPK = T)
sqlSave(connection, location_dimension_table, rownames = "id", addPK = T)
sqlSave(connection, time_dimension_table, rownames = "id", addPK = T)
