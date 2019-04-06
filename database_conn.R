install.packages("RODBC")

library(RODBC)

# Connect to Access db
#connection <- odbcConnectAccess("C:/Documents/github_project")
# Get data
#data <- sqlQuery( connection , paste (Select "Crime_id, Month, Year" From policeYork.Street.csv))
connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=D:/Advance Data Management Project/Crime/Database.mdb")


# check to see if we are connected to the access database
sqlTables(connection)

#Drop datable from the access database
sqlDrop(connection, "DimCrime")
sqlDrop(connection, "DimLocation")
sqlDrop(connection, "DimTime")

# copy the DimcCrime dataframe to access database table
sqlSave(connection, DimCrime, rownames = "id", addPK = T)
sqlSave(connection, DimLocation, rownames = "id", addPK = T)
sqlSave(connection, DimTime, rownames = "id", addPK = T)