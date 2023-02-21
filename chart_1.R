# load library
library("ggplot2")
library("plotly")
library("dplyr")

all_data <- read.csv("final_dataframe.csv", stringsAsFactors = FALSE)

chart_world_data <- all_data %>%
  select(age, finalWorth, gender) %>%
  filter(gender == "F" | gender == "M")

chart_world_data <- chart_world_data %>%
  na.omit(chart_world_data)

ggplot(data = chart_world_data) +
  geom_line(mapping = aes(x = age, y = finalWorth, color = gender)) +
  geom_point(mapping = aes(x = age, y = finalWorth, color = gender)) +
  scale_x_continuous(breaks = seq(20, 100, 5)) +
  scale_y_continuous(breaks = seq(0, 220, 25)) +
  labs(title = "Distribution of Age vs Net Worth by Gender", x = "Age", y = "Net Worth (in billions)", color = "Gender") +
  scale_color_hue(labels = c("Women", "Men"))
