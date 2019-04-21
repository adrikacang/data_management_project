#merge with crime dimension for crime_id
DimCrimeMerge <- DimCrime
DimCrimeMerge <- unite(DimCrimeMerge,"type_outcome" ,c("Crime Type", "Outcome Type"), remove = FALSE)
crime_fact <- crime_merge
crime_fact <- unite(crime_fact, "type_outcome", c("Crime type", "Outcome type"))
crime_fact <- merge(x=crime_fact, y=DimCrimeMerge, by="type_outcome")

#Merge with location dimension for location_id
DimLocationMerge <- unite(DimLocation, "lsoa_street", c("LSOA Code", "Street"), remove = FALSE)
crime_fact <- unite(crime_fact, "lsoa_street", c("LSOA code.x", "Location.x"))
crime_fact <- merge(x=crime_fact, y=DimLocationMerge, by="lsoa_street")