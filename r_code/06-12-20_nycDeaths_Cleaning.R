#####R Workshop Practice Problem####### -- Data Clenaning
#########################06-12-20######

getwd()
setwd("/YOUR FILE PATH HERE/")

library(dplyr)
library(tidyverse)
library(stringr)

#donwload original dataset from: 
https://data.cityofnewyork.us/Health/New-York-City-Leading-Causes-of-Death/jb7j-dtam

#name the dataset as "nyc_death_cause.csv"

#load your data 
nycDeath <- read_csv("nyc_death_cause.csv")

#check data structure
glimpse(nycDeath)

#change column name --- better not to have space in column titles 
colnames(nycDeath) <- c("year", "leadingCause", "sex", "raceEthnicity", "deaths", "deathRate", "adjDeathRate")

#change data type
nycDeath$year <- as.character(nycDeath$year)
nycDeath$deaths <- as.numeric(nycDeath$deaths)
nycDeath$deathRate <- as.numeric(nycDeath$deathRate)
nycDeath$adjDeathRate <- as.numeric(nycDeath$adjDeathRate)

#check the data structure once again 
glimpse(nycDeath)

#check how many unique leading cause of deaths in the dataset
unique(nycDeath$leadingCause)


#change the labeling of leading causes------------
#split the leadingCause columns into two at "("
nycDeath2 <- nycDeath %>% separate(leadingCause, c("leadingCause", "cause2"), sep = "[(]")

#remove a column 
nycDeath2 <- nycDeath2[, -3] 

#remove white space on the right
nycDeath2$leadingCause <- str_trim(nycDeath2$leadingCause, "right")

#check the leading causes once again 
unique(nycDeath2$leadingCause)

#changing the labeling of the cause of death (some more of manual changes)
nycDeath2$leadingCause[which(nycDeath2$leadingCause == "Influenza")] <- "Influenza and Pneumonia"
nycDeath2$leadingCause[which(nycDeath2$leadingCause == "Assault")] <- "Homicide"
nycDeath2$leadingCause[which(nycDeath2$leadingCause == "All Other Causes")] <- "Other"
nycDeath2$leadingCause[which(nycDeath2$leadingCause == "Malignant Neoplasms")] <- "Cancer"


#export to csv------------------
#check your work directory
getwd()

#export to csv
write.csv(nycDeath2, "nyc_death_cause_CLN.csv")




