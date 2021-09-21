# Manipulating data with dplyr and tidyr

# library packages
library(dplyr) #data manipulation functions, akin to manual filtering, reordering, calculations
library(tidyr) # reshaping data functions
library(readr) #reading and writing csv
library(udunits2) # unit conversions

# read in data
# read_csv: 1) faster 2) strings automatically read as factors 3) interprets dates/times
surveys <- read_csv("data_raw/portal_data_joined.csv")
str(surveys)
dim(surveys)
nrow(surveys); ncol(surveys) #semicolon allows for 2 functions to run at the same time/line
head(surveys)
View(surveys) #equivalent to clicking from Global Environment

# Subsetting by rows (filter) and columns (select)
filter(surveys, year == 1995)
select(surveys, month, species, genus)
select(surveys,-record_id, -day)


surveys_sml <- surveys %>%
  filter(weight<=5) %>%
  select(species_id, sex, weight)

# Adding a calculated column (mutate)
surveys %>%
  mutate(weight_kg = weight/1000, 
         weight_lb = weight_kg/2.2) #original units g

surveys %>% 
  filter(!is.na(weight)) %>%
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "lb"))

# split/apply/combine paradigm, with group_by() and summarize 
# find weight by sex
surveys %>% 
  filter(!is.na(sex) & !is.na(species_id)) %>%
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE),
            n = n()) >%>
  arrange(desc(mean_weight))
         
# Counting, count(), n()
# count() is group_by() and summarize(n = n()); equivalent to table() in base
# n() is used within summarize()
count(surveys, species, sex)
table(surveys$species)

# reshaping data, from 'tidyr'
# from long to wide, pivot_wider()
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))
View(surveys_gw)

surveys_wide <- surveys_gw %>%
  pivot_wider(names_from = genus, values_from = mean_weight)

#from wide to long, pivot_longer()
surveys_long <- surveys_wide %>%
  pivot_longer(-plot_id, names_to = "genus", values_to = "mean_weight") %>%
  filter(!is.na(mean_weight))

View(surveys_long)


#dir.create("data_clean") #created new folder called data_clean
write_csv(surveys_wide, file = "data_clean/surveys_genus_weight.csv") #(readr version)
# hastag added to dir.create("data_clean") so a new folder isnt created next time the script is run

