# Jessene Aquino-Thomas
# 9/21/2021
#Manipulating data with dplyr and tidyr

# library packages
library(dplyr) # data manipulation functions, akin to manual filtering, reordering, calculations
library(tidyr) # reshaping
library(readr) # reading and writing csvs
library(udunits2) # unit conversions

# read in data
# read_cvs: 1) faster 2) strings automatically read as factors
surveys <- read_csv("data_raw/portal_data_joined.csv")
str(surveys)
dim(surveys)
nrows(surveys); ncol(surveys)
head(surveys)
tail(surveys)
View(surveys) # equivalent to clicking in the Global Environment 

# Subsetting by rows (filter) and columns (select)
filter(surveys, year == 1995)
select(surveys, month, species, genus)
select(surveys, -record_id, -day)


surveys_sml <- surveys %>% 
  filter(weight <= 5) %>%
  select(species_id, sex, weight)

# Adding a calculated column (mutate)
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000, 
         weight_lb = weight_kg/2.2) # original units g

surveys %>% 
  filter(!is.na(weight)) %>% 
  select(weight) %>% 
  mutate(weight_kg = ud.convert(weight, "g", "kg")) %>% # original units g
  mutate(weigth_lb = ud.comvert(weight, "kg", "lb"))

# split/apply/combine paradigm, with group_by() and summarize ()
surveys %>% 
  group_by(sex, species) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE),
            n = n()) %>% 
  arrange(mean_weight)


surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            n = n()) %>% 
  arrange(mean_weight)

# Counting, count(), n()
# count is group_by() and summarize(n = n())
# n() is used within summarize()
count(surveys, species, sex)


# Reshaping data
# from long to wide, pivot_wider
surveys_gw <- surveys %>%
  filter(!is.na(weight)) 

