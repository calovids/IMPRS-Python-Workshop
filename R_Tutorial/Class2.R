##load packages
library("dplyr")
library("ggplot2")
#Setting a working directory
setwd('/home/calovi/Dropbox/Konstanz/IMPRS-Python-Workshop/R_Tutorial')
setwd("~/Dropbox/Konstanz/IMPRS-Python-Workshop/R_Tutorial")
#cleaning the environment
rm(list = ls())

#reading a csv file
Clean=read.table('Clean.csv',sep=",",header = TRUE)
Clean$Radius<-sqrt(Clean$x^2+Clean$y^2)


#histograms
?hist
hist(Clean$x,breaks=100)

#PDF
hist(Clean$Radius,100,freq=FALSE,ylim=c(0,100))


#selecting bins
Bins=seq(from=0, to=0.1,by=0.005)
Bins


Bins2=seq(0,0.1,length.out=30)
Bins2


hist(Clean$Radius,breaks=Bins,freq=FALSE)
hist(Clean$Radius,breaks=Bins2,freq=FALSE)

##boxplots
boxplot(Clean)
boxplot(Clean$Radius)


ggplot(Clean, aes(x=as.factor(Trial),y=Radius)) +
  geom_boxplot()+
  xlab('Trial')

ggplot(Clean, aes(x=as.factor(Trial),y=Radius,fill=as.factor(Trial))) +
  geom_boxplot( alpha=0.9) + 
  xlab('Trial')

ggplot(Clean, aes(x=as.factor(Trial),y=Radius,fill=as.factor(y>0))) +
  geom_boxplot( alpha=0.5) + 
  xlab('Trial')

ggplot(Clean, aes(x=x, y=y) ) +
  geom_bin2d(bins = 70) +
  scale_fill_continuous(type = "viridis") +
  theme_bw()

ggplot(Clean, aes(x=x, y=y) ) +
  geom_hex(bins = 20) 
#filtering data and pipes

Clean %>% filter(Radius<0.03)

Clean %>% filter(Radius<0.03,x>0)


Clean<-Clean %>%
  mutate(ShiftX=x+0.05)


Stats=Clean %>%
  group_by(Trial)%>%
  summarise(AverageR=mean(Radius),
            MaxR=max(Radius),
            MinR=min(Radius),
            MinX=min(x),
            )



Window=20
Clean<-Clean %>%
  group_by(Trial)%>%
  mutate(dx = c(rep(NA,Window/2),
                x[(Window+1):length(x)]-x[1:(length(x)-Window)],
                rep(NA,Window/2)),
         
         dy = c(rep(NA,Window/2),
                y[(Window+1):length(y)]-y[1:(length(y)-Window)],
                rep(NA,Window/2)),
         
         Speed=sqrt(dx^2+dy^2))/Window
        

#looking at data

plot(Clean$Speed[1:200],t='l')
#writing data into a file
write.csv(Stats,file="Stats.csv",sep=",",col.names = TRUE)
