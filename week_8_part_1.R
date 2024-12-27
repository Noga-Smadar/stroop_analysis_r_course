# R course for beginners
# Week 8
# assignment by Noga Smadar
# script 1 - raw and filtered data

#### RAW DATA ----

# unite files into a data frame
files_titles <- dir("data")

df <- data.frame()

for(file in files_titles) {
  temp_data <- read.csv(file.path("data", file))
  df <- rbind(df, temp_data)
}

# adjust variables
library(dplyr)

df <- df |>
  mutate(task = ifelse(grepl("ink_naming", condition), "ink_naming", "word_reading"),
         congruency = ifelse(grepl("incong", condition), "incongruent", "congruent"),
         accuracy = ifelse(participant_response == correct_response, 1, 0)
  )

#choose relevant data
raw_data <- data.frame(
  subject = factor(df$subject),
  task = factor(df$task),
  congruency = factor(df$congruency),
  block = as.numeric(df$block),
  trail = as.numeric(df$trial),
  accuracy = factor(df$accuracy),
  rt = as.numeric(df$rt)
)

#check factors

contrasts(raw_data$task) #  ink_naming 0, word_reading 1
contrasts(raw_data$congruency) #congruent 0, incongruent 1

#save data file
save(raw_data, file = "./data/raw_data.rdata")


#### FILTERED DATA ----

#count subjects
library(dplyr)
raw_data |> 
  summarise(count = n_distinct(subject)) # 30 distinct subjects

#omit NA 
filtered_data <- na.omit(raw_data)

#omit outliers from the rt column
filtered_data <- filtered_data |>
  filter((rt < 3000), (rt > 300)) 

# trails percentage post omission

raw_data |>
  group_by(subject) |>
  summarise(count = n()) # 400 trails per subject

trail_percentage <- filtered_data |>
  group_by(subject) |>
  summarise(percentage = (n()/400),
            ommision = 1 - percentage)

mean(trail_percentage$ommision)
sd(trail_percentage$ommision)

#save filtered data
save(filtered_data, file = "./data/filtered_data.rdata")


