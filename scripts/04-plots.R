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
sp <- species_counts$species_id


for (i in 1:nrow(species_counts)) {
  sub <- surveys_complete %>% 
    filter (species_id==sp[i])
  
  fig <- ggplot(data= sub,
                mapping = aes(x = weight, y = hindfoot_length)) + 
    geom_point(alpha= 0.1) 
  ggsave(filename = paste0("plots/",sp[i],"_length_weight_scatter.jpg"),
         height = 4,
         width = 4,
         units ="in")
  
}
  


# Time Series plots 

surveys_complete %>% 
  filter(species_id=="DM") %>% 
  group_by(year) %>% 
  summarize( mean_weight= mean(weight),
            sd_weight= sd(weight)) %>% 
  ggplot(aes(x= year, y=mean_weight)) +
  geom_pointrange(aes (ymin= mean_weight -sd_weight,
                     ymax= mean_weight +sd_weight))


# Challenges genus dipodomys, separate by species/ year/ sex
 surveys_complete %>% 
  filter(genus=="Dipodomys") %>% 
  group_by(year,sex, species_id) %>% 
  summarize( mean_weight= mean(weight),
             sd_weight= sd(weight)) %>% 
  ggplot(aes(x= year, y=mean_weight, color= sex)) +
  geom_pointrange(aes (ymin= mean_weight -sd_weight,
                       ymax= mean_weight +sd_weight))+ 
   facet_wrap(vars(species_id), scales= "free_y", nrow= 3)
  
  
 #Using Facet Grid and geom text 
 
 surveys_complete %>%
   filter(genus == "Dipodomys") %>%
   group_by(year, species_id, sex) %>%
   summarize(mean_weight = mean(weight),
             sd_weight = sd(weight),
             n = n()) %>%
   ggplot(aes(x = year, y = mean_weight, color = sex)) +
   geom_pointrange(aes(ymin = mean_weight - sd_weight,
                       ymax = mean_weight + sd_weight), 
                   shape = 0) +
   geom_text(aes(label = n), size = 3, 
             color = "black") +
   facet_grid(rows = vars(species_id), 
              cols = vars(sex),
              scales = "free_y")

  

