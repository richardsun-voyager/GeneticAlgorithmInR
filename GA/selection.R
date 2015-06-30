##Selecting Items Based on their fitness
##Written by Richard Soon
selection<-function(pop,rate)
{
  selected<-NULL
  popSize<-length(pop$fitness)##The size of the population
  num<-as.integer(popSize*rate)
  num<-ifelse(num>0,num,1)
  wt<-pop$fitness/sum(pop$fitness)##The odds of each item
  selected<-sample(1:popSize,num,prob=wt)##Pick items according to their weights
  selected
}