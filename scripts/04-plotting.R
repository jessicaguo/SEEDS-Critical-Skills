# Plotting with ggplot

library(dplyr) # data manipulation
library(tidyr) # reshaping data functions
library(readr) # reading and writing csvs
library(udunits2) # unit conversions
library(ggplot2)

# Read in data
# Using read_csv is 1) faster and 2) reads strings as factors
surveys <- read_csv("data_raw/portal_data_joined.csv")

# If you are only using one function from a package you can package::function instead of calling the whole library

surveys <-readr::read_csv("data_raw/portal_data_joined.csv")

# Filter to complete survey data
surveys_complete <- surveys %>%
  filter(!is.na(weight),
         !is.na(hindfoot_length),
         !is.na(sex))

# Extract most common species
species_counts <- surveys %>%
  count(species_id) %>%
  filter(n >= 30)

# Only keep most common species
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)

#### Plotting with ggplot ####

# ggplot(data = DATA, mapping = aes()) +
#        geom_point()

ggplot(data= surveys_complete,
       mapping = aes(x= weight, y= hindfoot_length)) +
  geom_point(alpha = 0.1)

# aes can be in the top ggplot or in the geom line

ggplot(data= surveys_complete,
       mapping = aes(x= weight, y= hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

# Boxplot
ggplot(data = surveys_complete,
       aes(x= species_id, y =weight)) +
  geom_jitter(alpha = 0.1) +   # layers are built in the order that you add them in the ggplot
  geom_boxplot(alpha = 0, color = "forestgreen")

# Weight - hindfoot_length correlation for each species

species <- species_counts$species_id
for(i in 1:nrow(species_counts)) {    # doesn't work
  sub <- surveys_complete %>%
    filter(species_id == species[i])
}

fig1 <- ggplot(data = sub,
       aes(x= weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)
