# Extracting Sheffield area records filtering with 'Local Authority District name (2013)' equals to (contains) 'Sheffield'

library(readr)
library(dplyr)
library(tidyverse)


#Load social deprivation data
social_deprivation <- read_csv("social_deprivation.csv")

#Extract Sheffield data
Sheffield <- social_deprivation[which(social_deprivation$`Local Authority District name (2013)`== "Sheffield"),]
