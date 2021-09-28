# plotting with ggplot2

# Library packages
library(dplyr)
library(ggplot2)

#read in data 
surveys <- readr::read_csv("data_raw/portal_data_joined.csv")

# Filter to compleate survey data 

surveys_complete <-  surveys %>% 
  filter(!is.na (weight),
         !is.na (hindfoot_length),
          !is.na (sex))

# Extract most common species 
species_counts <- surveys_complete %>% 
           count(species_id)  %>% 
           filter(n >= 30)

surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)


## plotting with ggplot2 

#ggplot(data = DATA, mapping = aes()) +
#  geom_point()

ggplot(data= surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha= 0.1,aes(color= species_id)) 
  

# boxplot 
ggplot (data = surveys_complete,
        aes(x = species_id, y = weight)) +
  geom_jitter (alpha= 0.1) +
  geom_boxplot(alpha= 0, color= "blue") 

# Weight - hindfoot_length correlation for each species  
species <- surveys_complete$species_id


for (i in 1:species) {
  sub <- surveys_complete %>% 
    filter (species_id==species[i])
}
  

fig1 <- ggplot(data= surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha= 0.1) 





  

