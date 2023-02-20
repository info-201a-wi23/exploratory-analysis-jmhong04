#Load Library
library("tidyverse")
library("dplyr")
library("ggplot2")
library("RColorBrewer")

# Load dataset
data <- na.omit(read.csv("final_dataframe.csv"))

# Creating plot
data %>% ggplot(aes(x = philanthropyScore, fill=selfMade)) +
  geom_histogram(position="stack", binwidth = 0.5) + 
  labs(title = "Philanthropy Score vs. Number of Billionaires",
       x = "Philanthropy Score (1-5)",
       y = "Number of Billionaires",
       fill = "Source of Wealth", ) +
  scale_fill_discrete(labels=c('Not Self-Made', 'Self-Made'), guide = guide_legend(reverse=TRUE)) +
  scale_color_manual(values=c("#ADBDFF", "#3185FC")) 

