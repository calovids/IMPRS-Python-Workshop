##load packages
library("dplyr")
#Setting a working directory
setwd('/home/calovi/Dropbox/Konstanz/IMPRS-Python-Workshop/R_Tutorial')
setwd("~/Dropbox/Konstanz/IMPRS-Python-Workshop/R_Tutorial")
#cleaning the environment
rm(list = ls())

#the help command

?read.csv

#reading a csv file
Small=read.csv  ('Small.csv')
Small1=read.table('Small.csv')

## check for inconsistencies
summary(Small)
summary(Small1)
View(Small)
View(Small1)


## correct loading
Small1=read.table('Small.csv',sep=",",header = TRUE)
summary(Small)
summary(Small1)
View(Small)
View(Small1)

##Row based listing
Small[1,]
##Column based listing
Small[,1]

##Listing the first NN lines of the file
head(Small,n=2)

##Listing the last N lines of the file
tail(Small,n=1)

##Indexing slicing
Small[c(20:30),]
New=Small[-c(30:100),]
##picking specific locations and ranges
Small[c(15,20:30,50,1),]

#removing certain values
Small[-c(20:90),]



## Dataframes
Small$Trial
Small$x
Small$y

#creating new variables:
Small$Radius <- sqrt(Small$x^2+Small$y^2)
Small$Radius



##ploting
?plot

plot(Small$x,Small$y)
plot(Small$x,Small$y,t='l')

plot(Small$x,Small$y)
lines(Small$x,Small$y)
lines(Small$y)

plot(Small$x,Small$y,t='l')
points(Small$x,Small$y)

plot(Small$x,Small$y,t='b',xlim=c(-0.04,-0.03),ylim=c(0.05,0.055),
     xlab = "X (m)",main='Zommed in plot with labels')

#loading a larger file
Clean=read.table('Clean.csv',sep=",",header = TRUE)
Clean$Radius<-sqrt(Clean$x^2+Clean$y^2)
summary(Clean)

unique(Clean$Trial)

#Conditional statements
Variable=2
if( Variable==1)
{
  print('It\'s one')
} else {
  print('It\'s different than one')
}
#For loops and creating a mix of text
#and variables
for (i in 1:10){
    print(paste("The number is",i))
}

#For loops and if statements together
# Note that for loops should be avoided
Trials=unique(Clean$Trial)
for (Current_Trial in Trials){
  Temp=(Clean$Trial==Current_Trial)
  print(paste('The total amount of elements in Trial',
              Current_Trial,'is',sum(Temp)))
}

#histograms
?hist
#assigning an histogram to a variable
h<-hist(Clean$Trial)

#inspecting the data
View(h)
print(h$counts)

hist(Clean$x,breaks=100)

#PDF
hist(Clean$Radius,100,freq=FALSE)

#selecting bins
Bins=seq(from=0, to=0.1,by=0.005)
Bins2=seq(0,0.1,length.out=30)
hist(Clean$Radius,breaks=Bins,freq=FALSE)
hist(Clean$Radius,breaks=Bins2,freq=FALSE)

##boxplots
boxplot(Clean)
boxplot(Clean$Radius)

boxplot(Clean)

library("ggplot2")
ggplot(Clean, aes(x=as.factor(Trial),y=Radius)) +
  geom_boxplot()+
  xlab('Trial')

ggplot(Clean, aes(x=as.factor(Trial),y=Radius,fill=as.factor(Trial))) +
  geom_boxplot( alpha=0.5) + 
  xlab('Trial')


#filtering data and pipes

Clean %>% filter(Radius<0.03)

Clean %>% filter(Radius<0.03,x>0)



