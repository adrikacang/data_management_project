## Merge social deprivation and crime streets data of Sheffield 
DimDeprivation <- Sheffield_data
DimDeprivation <- unique(DimDeprivation)
DimDeprivation$'Dim Deprivation ID' <- seq.int(nrow(DimDeprivation))

DimDeprivationJoin <- select(DimDeprivation, c("LSOA code (2011)", "Dim Deprivation ID"))

## Create fact table by merging crime dataset with deprivation dataset
DimCrimeMerge <- DimCrime[DimCrime$`Outcome type` == '' | is.na(DimCrime$`Outcome type`), ]
crime_streets_merge_dim <- merge(x = crime_streets, y = DimCrimeMerge, by.x ="Crime type", by.y = "Crime type")
crime_q4_fact <- merge(x = crime_streets_merge_dim, y = DimDeprivationJoin, by.x="LSOA code", by.y = "LSOA code (2011)", all.x = TRUE)

#Select only specific column to be inserted into the table
crime_dep_fact <- select(crime_q4_fact, c("Crime ID", "Date", "Dim Deprivation ID", "Dim Crime ID"))