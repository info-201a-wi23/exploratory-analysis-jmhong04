library(tidyverse)
library(openintro)

#load our original dataframe
billionaire_data <- read.csv("final_dataframe.csv")

#load data into new dataframe with renamed columns
industry_bill_df <- billionaire_data %>% 
  rename("industry" = "category", "networth" = "finalWorth") 

#create new dataframe of the number of women billionaires per industry
wom_total <- industry_bill_df %>% 
  group_by(industry) %>% 
  filter(gender == "F", na.rm = TRUE) %>% 
  summarize(sum_women = n())

#create new dataframe of the total number of billionaires per industry in the gender column
gender_total <- industry_bill_df %>% 
  group_by(industry) %>% 
  select(gender) %>% 
  summarize(sum_gender = n())

#create new dataframe of the proportion of female billionaires per industry
women_prop <- left_join(wom_total, gender_total, by = "industry") %>% 
  mutate(proportion_of_women = sum_women / sum_gender) %>% 
  select(industry, proportion_of_women)

#create new dataframe of the number of self-made billionaires per industry
smtrue_total <- industry_bill_df %>% 
  group_by(industry) %>% 
  filter(selfMade == "True", na.rm = TRUE) %>% 
  summarize(sum_true = n())

#create new dataframe of the total number of billionaires per industry in the self-made column
sm_total <- industry_bill_df %>% 
  group_by(industry) %>% 
  select(selfMade) %>% 
  summarize(sum_selfmade = n())

#create new dataframe of the proportion of self-made billionaires per industry
selfmade_prop <- left_join(smtrue_total, sm_total, by = "industry") %>% 
  mutate(proportion_of_selfmade = sum_true / sum_selfmade) %>% 
  select(industry, proportion_of_selfmade)

#edit industry_bill_df to only have columns of industry, average mean, and average networth
industry_bill_df <- industry_bill_df %>% 
  group_by(industry) %>% 
  summarize(avg_networth = mean(networth, na.rm = TRUE), avg_age = mean(age, na.rm = TRUE)) %>% 
  select(industry, avg_networth, avg_age)

#join all dataframes to create a dataframe of industry, average networth, average age, proportion of women, and proportion of self-made billionaires
excl_selfmade_df <- left_join(industry_bill_df, women_prop, by = "industry") 
aggregate_table <- left_join(excl_selfmade_df, selfmade_prop, by = "industry") %>% 
  arrange(-avg_networth)

#round all dataframe values
aggregate_table <- aggregate_table %>% 
  mutate_if(is.numeric,
            round, digits = 2)
