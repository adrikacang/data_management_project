##### Creating dimension tables
# Named a new table
DimDeprivation <- Sheffield_selected

# Create IDs for each record, then a dimension table is created
DimDeprivation$'ID' <- seq.int(nrow(DimDeprivation))

show(DimDeprivation)

# Select only ID and LSOA_code, preparing for fact table
part1 <- select(DimDeprivation, c("LSOA_code", "ID"))

##### Creating fact tables
# First merge part one from social deprivation dimension table and rename the ID to 'DimDeprivation_ID'
FactDeprivation <- part1
show(FactDeprivation)
names(FactDeprivation)[2]<-"DimDeprivation_ID"

# 

# Rename
DimCrimeMerge <- DimCrime[DimCrime$`Outcome type` == '' | is.na(DimCrime$`Outcome type`), ]
crime_streets_merge_dim <- merge(x = crime_streets, y = DimCrimeMerge, by.x ="Crime type", by.y = "Crime type")
crime_dep_fact <- merge(x = crime_streets_merge_dim, y = DimDeprivationJoin, by.x="LSOA code", by.y = "LSOA code (2011)", all.x = TRUE)

#Remove missing values of deprivation id
crime_dep_fact <- crime_dep_fact[complete.cases(crime_dep_fact[ ,c("Dim Deprivation ID")]),]

