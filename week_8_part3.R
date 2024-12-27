# Added comments for the Github repository: 
#This is the first script, the purpose of which is conducting a linear regression. 
#Written by Noga on December 27 2024



# R course for beginners
# Week 8
# assignment by Noga Smadar
# script 3 - analysis

#prepare script
load("./data/filtered_data.rdata")
library(tidyverse)
library(lme4)

# regression
model <- lmer(rt ~  task + congruency + (1|subject), data = filtered_data)
summary(model)

