#Manipulating data with tidyr and dyplr


#library packages
library(dplyr) # data manipulation functions,akin to manual filtering, calculations
library(tidyr) # reshaping data functions 
library(readr) # reading and writing csvs
library(udunits2) # unit conversions #does not work

# read in data 
# using read_csv 1.reads data names as factors, 2.reads faster 3. interprets dates/times

surveys <- read_csv("data_raw/portal_data_joined.csv")  
str(surveys)
dim(surveys)
nrow(surveys);ncol(surveys)
head(surveys)

# Subsetting by row (filter) and columns (select)
filter(surveys,year==1995)
select(surveys,month,species,genus)
select(surveys,-record_id,-day)

survey_sml <- surveys %>%
  filter (weight< 5) %>%
  select(species_id,sex,weight)

# adding a calculated column (mutate)
surveys %>%
  mutate(weight_kg = weight/1000,
         weigh_lb= weight_kg/2.2) #original units g 

surveys %>% 
  filter(!is.na(weight)) %>% 
  select(weight) %>% 
  mutate(weight_kg)= ud.convert (weight,'g',"kg") # 

# split/apply/ combine paradigm with group_by( )and summarize by()

surveys %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex,species_id) %>%
  summarize (mean_weight = mean (weight),
             sd_weight = sd (weight),
             n= n()) %>%
arrange (desc (mean_weight))


# counting count (),n()
# count () is  group_by() and summerize (n=n()); equivalent to table ()in base 
#n()is used withing summerizw (
count(surveys,species,sex)

# Reshaping data 
# from long to wide, pivot_wider ()
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id,genus) %>%
  summarize (mean_weight = mean(weight))

View(surveys_gw)

surveys_wide <- surveys_gw %>%
  pivot_wider(names_from = genus,values_from = mean_weight)

# from wide to long, pivot_longer(

survey_long <- surveys_wide %>%
  pivot_longer(-plot.id, names_to = "genus", values_to = "mean_weight" ) %>% 
  filter(!is.na(mean_weight))

# dir.create ("data clean")

write_csv(surveys_wide, file = "data_clean")


