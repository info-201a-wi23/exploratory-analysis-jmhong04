# billionaire_data <- read.csv("C:\\Users\\iyoab\\Desktop\\INFO201\\exploratory-analysis-jmhong04\\final_dataframe.csv", stringsAsFactors = FALSE)
library("dplyr")
library("tidyverse")
library("stringr")
library("styler")

# AGE: WHAT IS THE MEDIAN AND MEAN AGE?
average_age <- billionaire_data %>%
  summarize(median_age = median(age, na.rm = TRUE)) %>%
  pull(median_age)

# GENDER
total_num_billionaires <- nrow(billionaire_data)

gender_variable <- billionaire_data$gender
num_of_men <- length(gender_variable[gender_variable == "M"])
num_of_women <- length(gender_variable[gender_variable == "F"])
perc_of_women <- num_of_women / total_num_billionaires
perc_of_men <- num_of_men / total_num_billionaires


# PRIVILEGE
Privilege <- billionaire_data$selfMade
amt_inherited <- length(Privilege[Privilege == "False"])
amt_selfMade <- length(Privilege[Privilege == "True"])

proportion_inherited <- amt_inherited / total_num_billionaires
proportion_selfMade <- amt_selfMade / total_num_billionaires

## LOCATION
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

# PHILANTROPHY
avg_philantrophy <- billionaire_data %>%
  filter(country == "United States") %>%
  summarize(average_philantrophy_score = mean(philanthropyScore, na.rm = TRUE)) %>%
  pull(average_philantrophy_score)

# Summary Statistics
summary_info <- list()
summary_info$average_age <- average_age
summary_info$perc_of_women <- perc_of_women
summary_info$perc_of_men <- perc_of_men
summary_info$proportion_inherited <- proportion_inherited
summary_info$proportion_selfMade <- proportion_selfMade
summary_info$highest_num_country <- highest_num_country
summary_info$highest_num_state <- highest_num_state
summary_info$avg_philantrophy <- avg_philantrophy
