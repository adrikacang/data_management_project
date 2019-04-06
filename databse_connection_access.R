
install.packages("RODBC")

library(RODBC)

connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/kingsparadise/Documents/GitHub/data_management_project/github_project.accdb")

# check to see if we are connected to the access database
sqlTables(connection)

#Drop datable from the access database
#sqlDrop(connection, "DimCrime")

# copy the DimcCrime dataframe to access database table
sqlSave(connection, DimCrime, rownames = "id", addPK = T)
