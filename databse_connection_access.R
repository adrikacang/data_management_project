install.packages("RODBC")

library(RODBC)

connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:/Users/kingsparadise/Documents/GitHub/data_management_project/github_project.accdb")

# check to see if we are connected to the access database
sqlTables(connection)

#collect data from csv files 
addData = sqlQuery(connection, select(policeYork.street, Month))