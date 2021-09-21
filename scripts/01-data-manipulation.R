# Manipulating data with dplyr and tidyr

# library packages
library(dplyr)
library(tidyr)
library(readr)
library(udunits2)

# read in data
# read_csv: 1) faster 2) strings automatically read as factors 3) interprets dates/times
surveys <- read_csv("data_raw/portal_data_joined.csv") #because we saved this as a project we are at the same starting point
str(surveys)
dim(surveys)
nrow(surveys); ncol(surveys)
head(surveys)

# Subsetting by rows (filter) and columns (select)
filter(surveys, year == 1995) # with no assignment (i.e., <-), no object created and you can just view
select(surveys, month, species, genus)
select(surveys, -record_id, -day)

surveys_sml <- surveys %>% 
  filter(weight < 5) %>%
  select(species_id, sex, weight) # point here when we run this nothing will show up in the console because we are doing an assignment; something will showup in the environment because we are creating a new object

# Adding a calculated column (mutate)
surveys %>%
  mutate(weight_kg = weight/1000,
         weight_lb = weight_kg/2.2) # original units g

surveys %>%
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "kg"))

surveys %>%
  select(weight) %>%
  mutate(weight_lb = ud.convert(weight, "g", "lb"))

surveys %>%
  filter(!is.na(weight)) %>%
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "kg"))

# OR
surveys %>%
  na.omit(weight) %>%
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "kg"))

# Split/apply/combine paradigm, with group_by() and summarize()
surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE))
  
# OR can remove the na.rm command we had before because they were removed with the other line of code
surveys %>% 
  filter(!is.na(weight) & !is.na(sex)) %>%
  group_by(sex, species_id) %>% 
    summarize(mean_weight = mean(weight),
              sd_weight = sd(weight),
              n = n()) %>%
  arrange(desc(mean_weight))
  

# Counting, count(), n()
# count() is a group_by() and summarize(n = n())
count(surveys, species)
table(surveys$species)
count(surveys, species, sex)

# Reshaping data
# from long to wide, pivot_wider() 
# its easier to plot in ggplot() with long data
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))
View(surveys_gw)

surveys_wide <- surveys_gw %>%
  pivot_wider(names_from = genus, values_from = mean_weight)
View(surveys_wide) # now shows the mean_weight of each genus by plot

# from wide to long, pivot_longer()
surveys_long <- surveys_wide %>%
  pivot_longer(-plot_id, names_to = "genus", values_to = "mean_weight")
View(survey_long)

# dir.create("data_clean") # ran this and then commented it out; it created a new file/directory in your working directory for cleaned data
write_csv(surveys_wide, file = "data_clean/surveys_genus_weight.csv")
 