library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")
library("dplyr")
library("ggplot2")
library("RColorBrewer")
library("maps")
library("stringr")

billionaire_data <- read.csv("final_dataframe.csv", stringsAsFactors = FALSE)

billionaire_amt_state <- billionaire_data %>% 
  filter(country == "United States") %>% 
  group_by(state) %>%
  summarize(state_number = n())

billionaire_amt_country <- billionaire_data %>% 
  group_by(country) %>%
  summarize(country_number = n())

state_shape <- map_data("state")
world_shape <- map_data("world")

#State Map
my_regions <- state_shape$region
updated_regions <- str_to_title(my_regions)
state_shape <- state_shape %>% 
  mutate(updated_regions)

billionaire_shape_state_data <- state_shape %>% 
  left_join(billionaire_amt_state, by = c("updated_regions" = "state"))

ggplot(data = billionaire_shape_state_data) +
  geom_polygon(aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = state_number)) +
  coord_map() +
  labs(title = 'Billionaires in the US', fill = 'Number of Billionaires')

#World Map
my_countries <- world_shape$region
updated_countries <- str_replace(my_countries, "USA", "United States")
world_shape <- world_shape %>% 
  mutate(updated_countries)
billionaire_shape_world_data <- world_shape %>% 
  left_join(billionaire_amt_country, by = c("updated_countries" = "country"))


world_map <- ggplot(data = billionaire_shape_world_data) +
  geom_polygon(aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = country_number)) +
  coord_map() +
  labs(title = 'Billionaires Around the World', fill = 'Number of Billionaires')

world_map + coord_map(xlim=c(-180,180))
