# Code for practicing style and best practices
# By Riemer and Guo, modified by López Lloreda # Apparently it doesn't like accents?
# 9/16/2021

## Finish fixing according to styling guide


# Load libraries
library(ggplot2)
library(dplyr)

# Read in manual data
d <- read.csv("wp.csv")

# Look at the structure of the data
str(d)

# Create functions

SE <- function(x){
        sd(x,na.rm=T)/sqrt(length(x))
}

sum_WP <- d %>%
  mutate(datetime=as.POSIXct(strptime(datetime, "%m/%d/%Y %H:%M")),
         date=as.POSIXct(paste0(date," 00:00"), format="%m/%d/%Y %H:%M"))%>%
  group_by(date) %>%
  summarize(m=mean(negWP,na.rm=T),se=SE(negWP),sd=sd(negWP))


# Load in automated data
load("../psychrometer_append/clean3/new_1b_3.r")

# Look at the structure of this data
str(new_d1)

#### Create plots ####

fig1 <- ggplot() +
          geom_point(data=new_d1, aes(x=datetime, y=psy))+
          geom_point(data=sum_WP, aes(x=date, y=m), stat="identity", size=3, col="red")+
          geom_errorbar(data=sum_WP, aes(x=date, ymin=m-sd, ymax=m+sd), stat="identity",width=5)
fig1

