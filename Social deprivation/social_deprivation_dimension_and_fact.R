##### Creating dimension tables
# Named a new table
DimDeprivation <- Sheffield_selected

# Create IDs for each record, then a dimension table is created
DimDeprivation$'ID' <- seq.int(nrow(DimDeprivation))

show(DimDeprivation)

# Select only LOSA_code ID, preparing for fact table
part1 <- select(DimDeprivation, c("LSOA_code","ID"))

##### Creating fact tables
DimCrimeMerge <- DimCrime[is.na(DimCrime$`Outcome Type`), ]
crime_streets_merge_dim <- merge(x = crime_streets, y = DimCrimeMerge, by.x ="Crime type", by.y = "Crime Type")
crime_dep_fact <- merge(x = crime_streets_merge_dim, y = part1, by.x="LSOA code", by.y = "LSOA_code", all.x = TRUE)

#Checking missing values of deprivation id and remove
crime_dep_fact <- crime_dep_fact[complete.cases(crime_dep_fact[ ,c("ID")]),]



