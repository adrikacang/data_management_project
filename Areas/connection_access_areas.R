

library(RODBC)

# From Adrian code
# Connect to Access db
#connection <- odbcConnectAccess("C:/Documents/github_project")
# Get data
#data <- sqlQuery( connection , paste (Select "Crime_id, Month, Year" From policeYork.Street.csv))


# Connect to Access file
connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/Anna/Documents/GitHub/data_management_project/Database/Datamart_v1.accdb")

# From Adrian code
# check to see if we are connected to the access database
#sqlTables(connection)

# Use this before saving table to Access: drop datable from the access database
sqlDrop(connection, 'DimLocation')

# From Adrian code
#sqlDrop(connection, "DimTime")
#sqlDrop(connection, "FactQuestion5")


# Copy table to Access database
sqlSave(connection, DimLocation, tablename = 'DimLocation', rownames = "id", addPK = T, safer = FALSE)

# copy the DimcCrime dataframe to access database table
#sqlSave(connection, DimCrime, rownames = "id", addPK = T)
#sqlSave(connection, DimTime, rownames = "id", addPK = T)
#sqlSave(connection, FactQuestion5, rownames = "id", addPK = T)

close(connection)
  
