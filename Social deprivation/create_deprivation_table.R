#Select Specific Column
crime_dep_fact_table <- select(crime_dep_fact, c("Crime ID", "Month", "Dim Crime ID", "ID")) 

#Rename column name of fact table
colnames(crime_dep_fact_table) <- c("Crime ID", "TimeDim ID", "Dim Crime ID", "Dim Dep ID")

#Pick Specific Columns From Dimension Tables
connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/Asus/Adrian Folders/Database_v4.accdb")

# check to see if we are connected to the access database
sqlTables(connection)

#Drop datable from the access database
#sqlDrop(connection, "DimCrime")

# copy the DimcCrime dataframe to access database table
sqlSave(connection, crime_dep_fact_table, rownames = "id", addPK = T)