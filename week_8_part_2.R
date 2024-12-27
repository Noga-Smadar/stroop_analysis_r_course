# Added comments for the Github repository: 
#This is the first script, the purpose of which is presenting descriptive statistics and plotting the data.
#Written by Noga on December 27 2024



# R course for beginners
# Week 8
# assignment by Noga Smadar
# script 2 - descriptive statistics

#load file
load("./data/filtered_data.rdata")

#libraries
library(tidyverse)
library(dplyr)
library(ggpubr)

#descriptives
summary_task <- filtered_data |>
  group_by(task)|>
  summarise(mean_rt = mean(rt), sd_rt = sd(rt))

summary_congruencey <- filtered_data |>
  group_by(congruency)|>
  summarise(mean_rt = mean(rt), sd_rt = sd(rt))

#plot
ggerrorplot(data = filtered_data,
            x = "task",
            y = "rt",
            color = "congruency",
            desc = "mean_sd",
            palette = "npg")


