install.packages("RODBC")

library(RODBC)

# Connect to Access db
#connection <- odbcConnectAccess("C:/Documents/github_project")
# Get data
#data <- sqlQuery( connection , paste (Select "Crime_id, Month, Year" From policeYork.Street.csv))
connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/Asus/Adrian Folders/Database_v4.accdb")


# check to see if we are connected to the access database
sqlTables(connection)

#Drop datable from the access database
sqlDrop(connection, "DimCrime")
sqlDrop(connection, "DimLocation")
sqlDrop(connection, "DimTime")
sqlDrop(connection, "FactQuestion5")
sqlDrop(connection, "deprivation_dimension_table")
sqlDrop(connection, "crime_dep_fact_table")

# copy the DimcCrime dataframe to access database table
sqlSave(connection, DimCrime, rownames = "id", addPK = T)
sqlSave(connection, DimLocation, rownames = "id", addPK = T)
sqlSave(connection, DimTime, rownames = "id", addPK = T)
sqlSave(connection, FactQuestion5, rownames = "id", addPK = T)
sqlSave(connection, deprivation_dimension_table, rownames="id", addPK = T)
sqlSave(connection, crime_dep_fact_table, rownames = "id", addPK = T)