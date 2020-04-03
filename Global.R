
## libs
library(shiny)
library(tidyverse)
library(collapsibleTree)
library(data.tree)

## Data
df_fam <- read_csv("data/UKRoyalFamily.csv") %>% 
  arrange(generation) %>% 
  mutate_at(vars(parent,child), str_to_title) %>%
  mutate_at(vars(parent,child), str_replace_all, "Ii", "II")
  
