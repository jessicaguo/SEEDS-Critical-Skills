#### Plotting with ggplot2 

#### library packages ####

library(dplyr)
library(ggplot2)

#### data manipulation ####

#read in data
surveys <- readr::read_csv("data_raw/portal_data_joined.csv") #readr:: if you only need one function from this specific package

#filter to remove NAs
surveys_complete <- surveys %>%
  filter(!is.na(weight),
         !is.na(hindfoot_length),
         !is.na(sex))
# extract most common species 
species_counts <- surveys_complete %>%
  count(species_id) %>%
  filter(n >= 30)

# only keep most common species 
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id) # the function %in% is to select from where do you want to take the data

#### Plotting with ggplot2 ####

#layers, with data frame

ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) + #aes can be located in geom
  geom_point(alpha = 0.1, aes(color = species_id)) #transparency #color inside eas because it becomes a third varible

# boxplot
ggplot(data = surveys_complete,
       aes(x = species_id, y = weight)) +
  geom_boxplot()

#adding another geom layer
ggplot(data = surveys_complete,
       aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(alpha = 0.1) #look at distributions

ggplot(data = surveys_complete,
       aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.1) + #check difference with point
  geom_boxplot(alpha = 0, color = "forestgreen") #the order of the layers matter 

#### combining plots with for loops ####

# weight - hindfoot_length correlation for each species
sp <- species_counts$species_id #create a new vector with the number of species
#for(i in 1:nrow(species_counts)) {#use nrow instead of length because species is a data frame not a vector

for(i in 1:nrow(species_counts)) { 
  sub <- surveys_complete %>% #subset the data
    filter(species_id == sp[i])
  fig <- ggplot(data = sub,
                mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1)
  ggsave(filename = paste0("Plots/", sp[i],"_length_weight_scatter.jpg"),
         fig,
         height = 4,
         width = 4,
         units = "in")
}

#### Time series plots ####
surveys_complete %>%
  filter(species_id == "DM") %>%
  group_by(year) %>%
  summarise(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = year, y = mean_weight)) +  #no need to specify the data because everything from pipe will get in
  geom_pointrange(aes(ymin = mean_weight - sd_weight, #add error bars vs geom_point
                      ymax = mean_weight + sd_weight))

surveys_complete %>%
  filter(species_id == "DM") %>%
  group_by(year) %>%
  summarise(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = year, y = mean_weight)) +
  geom_point()

## Challenge 
surveys_complete %>%
  filter(genus == "Dipodomys") %>%
  group_by(year,sex, species_id) %>%
  summarise(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = year, y = mean_weight, color = sex)) +  #no need to specify the data because everything from pipe will get in
  geom_pointrange(aes(ymin = mean_weight - sd_weight, #add error bars vs geom_point
                      ymax = mean_weight + sd_weight))

surveys_complete %>%
  filter(genus == "Dipodomys") %>%
  group_by(year,sex, species_id) %>%
  summarise(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = year, y = mean_weight, color = sex)) +  #no need to specify the data because everything from pipe will get in
  geom_pointrange(aes(ymin = mean_weight - sd_weight, #add error bars vs geom_point
                      ymax = mean_weight + sd_weight)) +
  facet_wrap(vars(species_id), scales = "free_y", nrow = 3)

surveys_complete %>%
  filter(genus == "Dipodomys") %>%
  group_by(year, species_id, sex) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = year, y = mean_weight, color = sex)) +
  geom_pointrange(aes(ymin = mean_weight - sd_weight,
                      ymax = mean_weight + sd_weight)) +
  facet_grid(rows = vars(species_id), 
             cols = vars(sex),
             scales = "free_y")
