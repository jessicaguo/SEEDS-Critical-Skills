# Manipulating data with dplyr and tidyr

# Loading packages
library(dplyr) # data manipulation
library(tidyr) # reshaping data functions
library(readr) # reading and writing csvs
library(udunits2) # unit conversions

# Read in data
# Using read_csv is 1) faster and 2) reads strings as factors
surveys <- read.csv("data_raw/portal_data_joined.csv")
head(surveys)
View(surveys)
str(surveys)
dim(surveys)
nrow(surveys); ncol(surveys)

# read_csv IS NOT WORKING- figure out what's going on

# Subsetting by rows (filter) and columns (select)
filter(surveys, year == 1995)
select(surveys, month, species, genus)
select(surveys, -record_id, -day)

surveys_sml <- surveys %>% # This is called a pipe and allows you to 
  filter(weight < 5) %>%
  select(species_id, sex, weight)

surveys_sml <- surveys %>% # This is called a pipe and allows you to 
  filter(weight < 5) %>%
  select(species_id, sex, weight) %>%
  head()

# Adding a calculated column (mutate)
surveys %>%
  mutate(weight_kg = weight/1000)

surveys %>%
  mutate(weight_kg = weight/1000,
         weight_lb = weight_kg/2.2)

# Same as above but using ud.convert
surveys %>%
  filter(!is.na(weight)) %>%    # ! means the inverse of; you are telling it that na = TRUE???
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "kg"))

# Other options for removing NAs?
na.omit()

# Changing to lbs
weight_lb <- surveys %>%
                select(weight) %>%
                mutate(weight_lb = ud.convert(weight, "g", "lb"))

# Split, apply, combine paradigm, with group_by() and summarize()
surveys %>% 
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE))

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE))      # Not sure that this worked

# Counting, count(), n()
# count() is group_by() and summarize(n = n()); equivalent to table() in base
count(surveys, species)
count(surveys, species, sex)
table(surveys$species) # Same as above

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            n = n())

# Filter, summarize and arrange by weight
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            n = n()) %>%
  arrange(mean_weight)

# Alternatively: arrange descending
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            n = n()) %>%
  arrange(desc(mean_weight))

# Reshaping data, from "tidyr"

# From long to wide, with pivot_wider()
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))

# Filter NAs in weight column, group by plot ID and genus, and summarize mean weights
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))

# Pivot from long to wide, with pivot_wider()
surveys_wide <- surveys_gw %>%
  pivot_wider(names_from = genus, values_from = mean_weight)

# Pivot from wide to long, with pivot_longer
surveys_long <- surveys_wide %>%
  pivot_longer(-plot_id, names_to = "genus", values_to = "mean_weight") # In pivot_longer you need to use quotations

surveys_long <- surveys_wide %>%
  pivot_longer(-plot_id, names_to = "genus", values_to = "mean_weight") %>% # You exclude plot_id because it's the column you don't want to pivot
  filter(!is.na(mean_weight)) # Remove the NAs, should match surveys_gw now

# dir.create("data_clean")
write.csv(surveys_wide, file = "data_clean/surveys_genus_weight.csv",
          row.names= FALSE) # Only for write.csv, not for write_csv
