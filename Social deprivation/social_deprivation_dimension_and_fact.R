## Merge social deprivation and crime streets data of Sheffield 
DimDeprivation <- Sheffield_data
DimDeprivation <- unique(DimDeprivation)
DimDeprivation$'Dim Deprivation ID' <- seq.int(nrow(DimDeprivation))

DimDeprivationJoin <- select(DimDeprivation, c("LSOA code (2011)", "Dim Deprivation ID"))

## Create fact table by merging crime dataset with deprivation dataset
DimCrimeMerge <- DimCrime[DimCrime$`Outcome type` == '' | is.na(DimCrime$`Outcome type`), ]
crime_streets_merge_dim <- merge(x = crime_streets, y = DimCrimeMerge, by.x ="Crime type", by.y = "Crime type")
crime_dep_fact <- merge(x = crime_streets_merge_dim, y = DimDeprivationJoin, by.x="LSOA code", by.y = "LSOA code (2011)", all.x = TRUE)
crime_dep_fact <- crime_dep_fact[complete.cases(crime_dep_fact[ ,c("Dim Deprivation ID")]),]

