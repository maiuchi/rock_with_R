#####R Workshop Practice Problem####### -- Data Analysis
#########################06-12-20######

#nyc leading cause of death------------------------------------------------------------------------------
getwd()
setwd("/Users/maiuchida/Desktop/rock_with_R/data/")

#upload data
nycDeath <- read_csv("nyc_death_cause_CLN.csv")

glimpse(nycDeath)

#change the data type of year to charactor
nycDeath$year <- as.character(nycDeath$year)

#check how many years they are in the dataset
table(nycDeath$Year)


#check the top leading cause of death
nycDeath %>% arrange(desc(deaths))


#filter 2014, female, and heart disease 
death2014_heart_f <- nycDeath %>% 
  filter(year == 2014) %>% 
  filter(sex == "F") %>% 
  filter(leadingCause == "Diseases of Heart") %>%
  arrange(desc(deaths))

ggplot(death2014_heart_f, aes(reorder(raceEthnicity, - deaths), deaths, group = year, fill = year)) + 
  geom_bar(stat = "identity")

#compare 2014 female heart death with that of 2007. order the table by year and the number of deaths 
death2007_14_heart_f <- nycDeath %>%
  filter(year == 2007 | year == 2014) %>% 
  filter(sex == "F") %>% 
  filter(leadingCause == "Diseases of Heart") %>% 
  arrange(year, deaths)

#visualize the number of deaths by heart diseases (2007 vs 20017) by race - ethnicities
ggplot(death2007_14_heart_f, aes(raceEthnicity, deaths, group = year, fill = year)) + 
  geom_bar(stat = "identity", position = position_dodge())

#remove other and unknown 
death2007_14_heart_f_2 <- death2007_14_heart_f %>%
  filter(raceEthnicity != "Not Stated/Unknown") %>%
  filter(raceEthnicity != "Other Race/ Ethnicity")

#clean up the graphs a bit 
ggplot(death2007_14_heart_f_2, aes(reorder(raceEthnicity, - deaths), deaths, group = year, fill = year)) + 
  geom_bar(stat = "identity", position = position_dodge()) + 
  scale_fill_manual(values = c("#0339A6", "#4CB1F7")) +
  labs(title = "Deaths by Heart Diseases across Race",
       subtitle = "(Female, 2007 vs 2014)",
       caption = "source: NYCDOH") +
  xlab("race") + 
  ylab("cases") + 
  theme_classic() + 
  theme(
    legend.position = "bottom", 
    plot.caption = element_text(color = "grey60", size = 6)
  )
  

#filter leading cause of them among white women  
deathTrends_f_white <- nycDeath %>% 
  filter(sex == "F") %>% 
  filter(raceEthnicity == "White Non-Hispanic") %>%
  arrange(desc(deaths)) 

#filter top 3 causes of death among while women (excluding "All the Other Cause")
deathTrends_f_white_top <- deathTrends_f_white %>% 
  filter(leadingCause == "Diseases of Heart"|
         leadingCause == "Cancer"|
         leadingCause == "Influenza and Pneumonia")

#change the order of the cause of death (to make the legend being ordered)
deathTrends_f_white_top$leadingCause <- factor(deathTrends_f_white_top$leadingCause, levels = 
                                                                                     c("Diseases of Heart",
                                                                                       "Cancer", 
                                                                                       "Influenza and Pneumonia"))
  
#create a visualization that shows the yearly trends of the three top cause of deaths among white women
ggplot(deathTrends_f_white_top, aes(year, deaths, group = leadingCause, color = leadingCause)) +
  labs(title = "Leading Cause of Deaths in NYC among White Females",
       subtitle = "(2007 - 2014)", 
       caption = "source: NYCDOH") + 
  xlab("year") +
  ylab("cases") + 
  geom_line() +
  scale_color_manual(values = c("#F20774", "#418EF2", "#F2B80C")) + 
  geom_point() + 
  theme_classic() + 
  theme(
    legend.position = "bottom", 
    legend.title = element_blank(), 
    plot.caption = element_text(color = "grey60", size = 6)
  )
