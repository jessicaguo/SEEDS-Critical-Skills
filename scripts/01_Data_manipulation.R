# Manipulating data 

#### library packages ####
library(dplyr) # data manipulation functions, excel-like, rename columns, akin to manual filtering, reordering, calculations
#call something specific from a data base
library(tidyr) # reshaping data functions
library(readr) # reading and writing csvs
library(udunits2) # unit conversions

#### read in data ####
surveys <- read_csv("data_raw/portal_data_joined.csv") # underscore strings reads as factors more intuitive and faster reading cvs than dot 3) interprets data/times
str(surveys) # displaying the internal structure of a R object
dim(surveys) #rows and columns
nrow(surveys) ; ncol(surveys) #separate small commands with ;
head(surveys) # with read_csv it tibbles or prints pretty
# prints the first 6 rows of the table
#View (surveys) #equivalent to clicking the table

#### Subsetting by rows (filter) and columns (select) ####

filter(surveys, year == 1995) 
select(surveys, month, species, genus) # no need of dollar sign in this library
select(surveys, -record_id, -day) # take out those columns

# New object using filter and select
surveys_sml <- surveys %>% # piping or basically linking functions in a new code
  filter(weight <= 5) %>% # input pipe into the next function
  select(species_id, sex,weight) # easier to read, sequentially, not creating new objects for every code
# piping in the tidyverse

#### Adding a calculated column (mutate) ####

surveys %>%
  mutate(weight_kg = weight/1000) #original units g without library units

# using unit package
surveys %>%
  filter(!is.na(weight)) %>% # exclamation point to exclude something is.na read NA in weight but erase them
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g","kg")) %>% # automatically changes between the two units
  mutate(weight_lb = ud.convert(weight, "g","lb")) # to pounds

#### Group and analize data ####
# split/apply/combine paradigm, with group_by() and summarize()

surveys %>%
  group_by(sex, species_id) %>% # is.na to take out NA values
  summarize(mean_weight = mean(weight, na.rm = TRUE), #same as summarise
            sd_weight = sd(weight, na.rm = TRUE)) # keep adding new column variables

surveys %>%
  filter(!is.na(sex), !is.na(weight)) %>% #instead of na.rm every time
  group_by(sex, species_id) %>% # is.na to take out NA values
  summarize(mean_weight = mean(weight), #same as summarise
            sd_weight = sd(weight)) # keep adding new column variables

# counting, count(), n()
count(surveys, species, sex) # count is group by and summarize n=n

surveys %>%
filter(!is.na(sex), !is.na(weight)) %>% #instead of na.rm every time
  group_by(sex, species_id) %>% # is.na to take out NA values
  summarize(mean_weight = mean(weight), #same as summarise
            sd_weight = sd(weight), # keep adding new column variables
            n = n()) #n() use within summarize to count elements in the group

# arranging

surveys %>%
  filter(!is.na(sex), !is.na(weight)) %>% #instead of na.rm every time
  group_by(sex, species_id) %>% # is.na to take out NA values
  summarize(mean_weight = mean(weight), #same as summarise
            sd_weight = sd(weight), # keep adding new column variables
            n = n()) %>% #n() use within summarize to count elements in the group
  arrange(mean_weight) #from lightest to heaviest, desc from heaviest to lightest

#### Reshaping data ####

#from longer to wider changes rows into columns, pivot_wider()
surveys_gw <- surveys %>% #new object to later use pivot function
  filter(!is.na(weight)) %>% #no NA values
  group_by(plot_id, genus) %>%
  summarise(mean_weight = mean(weight)) # add here into pipe pivot wider and do everything in one step
View(surveys_gw)

surveys_wide <- surveys_gw %>% # use the new object to switch rows of genus into columns
  pivot_wider(names_from = genus, values_from = mean_weight) #names headers of the columns # values separate calculations
View(surveys_wide) #helpful for PCAs or community ecology

#from wider to longer, reverse what we did in surveys wide, pivot_longer()
surveys_long <- surveys_wide %>% #using our previous table
  pivot_longer(-plot_id, names_to = "genus", values_to = "mean_weight") %>% #remove plotid because it is not a genus or 2:11 columns, names_to group headers into one column
  #in this case column names have to be between ""
  filter(!is.na(mean_weight)) #pivot longer does not removes back NA values do it manually

# Create a new directory (one time only)
dir.create("data_clean") #new folder name in quotes

#### Write or create a new CSV from an object ####

write_csv(surveys_wide, "data_clean/survey_weight_genus.csv") # add file type .csv when creating the name

#End up adding everything to github every time
