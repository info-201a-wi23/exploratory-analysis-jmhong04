billionaire_data <- read.csv("C:\\Users\\iyoab\\Desktop\\INFO201\\exploratory-analysis-jmhong04\\final_dataframe.csv", stringsAsFactors = FALSE)
library("dplyr")
library("tidyverse")
library("stringr")

# AGE: WHAT IS THE MEDIAN AND MEAN AGE?
average_age <- billionaire_data %>% 
  summarize(median_age = median(age, na.rm = TRUE))

# GENDER
total_num_billionaires <- nrow(billionaire_data)

gender_variable <- billionaire_data$gender
num_of_men <- length(gender_variable[gender_variable == 'M'])
num_of_women <- length(gender_variable[gender_variable == "F"])
perc_of_women <- num_of_women/total_num_billionaires
perc_of_men <- num_of_men/total_num_billionaires


# PRIVILEGE
Privilege <- billionaire_data$selfMade
amt_inherited <- length(privilege[privilege == "False"])
amt_selfMade <- length(privilege[privilege == "True"])

proportion_inherited <- amt_inherited/total_num_billionaires
proportion_selfMade <- amt_selfMade/total_num_billionaires

##LOCATION
country_amt_billionaires <- billionaire_data %>% 
  group_by(country) %>% 
  summarize(total_billionaires = n())

highest_num_country <- country_amt_billionaires %>% 
  filter(total_billionaires == max(total_billionaires, na.rm = TRUE)) %>% 
  pull(country)

state_amt_billionaires <- billionaire_data %>%
  filter(country == "United States") %>% 
  group_by(state) %>% 
  summarize(num_billionaires_state = n())

highest_num_state <- state_amt_billionaires %>% 
  filter(num_billionaires_state == max(num_billionaires_state, na.rm = TRUE)) %>% 
  pull(state)

#PHILANTROPHY
avg_philantrophy <- billionaire_data %>% 
  filter(country == "United States") %>% 
  summarize(average_philantrophy_score = mean(philanthropyScore, na.rm = TRUE))

#Summary Statistics
summary_info <- list()
summary_info$averageAge <- average_age
summary_info$proportion_of_women <- percentage_of_women
summary_info$proportion_of_men <- percentage_of_men
summary_info$proportion_inherited <- proportion_inherited
summary_info$proportion_selfmade <- proportion_selfMade
summary_info$most_country <- highest_num_billionaires_country
summary_info$most_state <- highest_num_billionaires_state
summary_info$mean_philantrophy <- avg_philantrophy_score