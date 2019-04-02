install.packages("RODBC")

library(RODBC)

# Connect to Access db
#connection <- odbcConnectAccess("C:/Documents/github_project")
# Get data
#data <- sqlQuery( connection , paste (Select "Crime_id, Month, Year" From policeYork.Street.csv))

connection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=D:/Advance Data Management Project/Crime/Database.mdb")



# Get data

#data <- sqlQuery( connection , paste ("select * from Name_of_table_in_my_database"))