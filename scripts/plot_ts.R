#Styling an R code
#modified by Isabel Siles

#### Adding all the libraries ####

library(dplyr)
library(ggplot2)

#### Manual data ####

#adding the data
d<-read.csv("wp.csv")
str(d)

#Creating a function 
SE<-function(x){sd(x,na.rm=T)/sqrt(length(x))}
sum_WP<-d%>%
  mutate(datetime=as.POSIXct(strptime(datetime, "%m/%d/%Y %H:%M")),
         date=as.POSIXct(paste0(date," 00:00"), format="%m/%d/%Y %H:%M"))%>%
  group_by(date)%>%
  summarize(m=mean(negWP,na.rm=T),se=SE(negWP),sd=sd(negWP))

#### Automated data  ####

#adding the data
load("../psychrometer_append/clean3/new_1b_3.r")
str(new_d1)

#creating a figure with the data
fig1<-ggplot()+
  geom_point(data=new_d1, aes(x=datetime, y=psy))+
  geom_point(data=sum_WP, aes(x=date, y=m), stat="identity", size=3, col="red")+
  geom_errorbar(data=sum_WP, aes(x=date, ymin=m-sd, ymax=m+sd), stat="identity",width=5)
fig1
