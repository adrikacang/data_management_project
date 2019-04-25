# Load libraries
library('readr')
library('dplyr')

# Selecting the columns, 'LSOA code (2011)', 'LSOA name (2011)', 'Local Authority District code (2013)', 
#'Local Authority District name (2013)','Index of Multiple Deprivation (IMD) Score' 
#'and 'Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)' 6 columns
Sheffield <- read_csv("Social\ deprivation/Sheffield_social_deprivation.csv")
Sheffield <- as_tibble(Sheffield) # prints a little nicer
Sheffield_data <- select(Sheffield, 1:6) # Select first 6 columns using location to select

# Cleansing data

# Step 1, check the values of character variables, the first four attributes
count(Sheffield_data,Sheffield_data$`LSOA code (2011)`)
count(Sheffield_data,Sheffield_data$`LSOA name (2011)`)
count(Sheffield_data,Sheffield_data$`Local Authority District code (2013)`)
count(Sheffield_data,Sheffield_data$`Local Authority District name (2013)`)

# Step 2, identify and locate invalid values
# Listing missing values
MissingValues= which(is.na(Sheffield_data), arr.ind=TRUE)
x = rownames(Sheffield_data)[MissingValues[,1]]
y = colnames(Sheffield_data)[MissingValues[,2]]
LocatedMissingValues = paste(x, y, sep=" ")
LocatedMissingValues

# Check for non numeric values
NonNum <- unlist(lapply(Sheffield_data, is.numeric)) 
NonNum
# List all values in non-numeric columns 
Sheffield_data[ , NonNum]

# Check for non character values
NonChar <- unlist(lapply(Sheffield_data, is.character)) 
NonChar
Sheffield_data[ , NonChar]

# Step 3, check the values of numeric variables
summary(Sheffield_data)
hist(Sheffield_data$`Index of Multiple Deprivation (IMD) Score`,col="red") 
hist(Sheffield_data$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`, col="green")

# The rank value should be bigger than 0
#Select & display missing Rank values
Sheffield_data %>% filter(is.na(Sheffield_data$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`))
outliers1 <- subset(Sheffield_data, Sheffield_data$`Index of Multiple Deprivation (IMD) Rank (where 1 is most deprived)`<0)
outliers1

# So no missing values and outliers

# Step 4, dealing with duplicate records
# create data frame to hold duplicate values from defined column
duplicate <- data.frame(table(Sheffield_data$`LSOA code (2011)`))
# count the frequency of each duplicate(s) 
duplicate[duplicate$Freq > 1,]
# show observations with user-defined duplicates
Sheffield_data[Sheffield_data$`LSOA code (2011)` %in% duplicate$Var1[duplicate$Freq > 1],]

# So no duplicate records

# Rename the columns
names(Sheffield_data)[1]<-"LSOA_code"
names(Sheffield_data)[2]<-"LSOA_name"
names(Sheffield_data)[3]<-"Local_authority_district_code"
names(Sheffield_data)[4]<-"Local_authority_district_name"
names(Sheffield_data)[5]<-"IMD_score"
names(Sheffield_data)[6]<-"IMD_rank"

Sheffield_selected <- Sheffield_data
# Export data
write.csv(Sheffield_selected, file="Social\ deprivation/Sheffield_selected.csv", row.names = FALSE)
