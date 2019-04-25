# data_management_project
Data warehousing for crime activities in South Yorkshire
Group project for *Advanced Data Management module*.

## Business questions
+ What are the total number of crimes by crime type in south Yorkshire by area  for 2015 - 2018?
+ Provide a month by month breakdown of crime types by area of sheffield for  2015 - 2018?
+ Provide a month by month breakdown of crime types , in sheffield, by social deprivation category for  2015 - 2018 (4 categories)?
+ What are the total number of crimes in sheffield by street name  for 2015 - 2018?
+ Provide a year by year breakdown of the crime types by crime outcomes for sheffield for 2015 to 2018?

**Suggestion**
Provide a year by year breakdown of the crime types based on the age and race?

**understand the data fields**

Police Recorded Crime and Outcomes: Open Data Tables User Guide
https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/560132/pprc-user-guide-oct16.pdf

Convert long and latitude to address name (Using R)
https://stackoverflow.com/questions/29921605/r-how-to-convert-latitude-and-longitude-coordinates-into-an-address-human-rea

**Understanding of dim tables**

https://www.sciencedirect.com/topics/computer-science/dimension-table

**Data Diagram**
![alt text](https://raw.githubusercontent.com/adrikacang/data_management_project/bdbe4ac4dc0a806cc7488b973a743d7f0824b036/diagram.png)


## How To Run
1. Run load_library.R (in 'Crime' folder)
2. Run crime_outcome_data_cleansing.R (in 'Crime' folder)
3. Run crime_streets_data_cleansing.R (in 'Crime' folder)
4. Run crime_data_transformation.R (This will make crime dimension and time dimension, (in 'Crime' folder))
5. Run lsoa_lookup_data_cleansing.R  (in 'Crime' folder)
6. Run lsoa_lookup_data_transformation.R (This will make location dimension) (in 'Crime' folder)
7. Run Q1245_Fact.R (This will create fact table for Q1, Q2, Q3, Q4, and Q5) (in 'Crime' folder)
8. Run "create_crime_tables.R" (will write table to access database)
9. Run "Extract sheffield.R" (data checking and cleansing for deprivation) (in 'Social Deprivation' folder)
10. Run Deprivation_Cleansing_Transformation.R (create dimension table for deprivation) (in 'Social Deprivation' folder)
11. Run social_deprivation_dimension_and_fact.R (create fact table) (in 'Social Deprivation' folder)
12. Run create_deprivation_table.R (write fact & dim table) (in 'Social Deprivatin' folder)
