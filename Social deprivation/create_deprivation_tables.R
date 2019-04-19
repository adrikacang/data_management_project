#Select Specific Column
crime_dep_fact_table <- select(crime_dep_fact, c("Crime ID", "Date", "Dim Deprivation ID", "Dim Crime ID"))
deprivation_dimension_table <- select(DimDeprivation, c(1,5,6,7))

#Rename column name of fact table
colnames(deprivation_dimension_table) <- c("LSOA Code", "IMD Score", "IMD Rank", "Dim Deprivation ID")
#Pick Specific Columns From Dimension Tables


