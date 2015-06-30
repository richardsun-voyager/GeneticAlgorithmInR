##This program runs genetic algorithm in order to find a optimal path for TSP
##Written by Richard Soon,05/25/2015
GA<-function(popSize,popLen,crossingRate,mutationRate,loops)
{
set.seed(111)
source("fitness.R")
source("selection.R")
source("crossing.R")
source("calPopFit.R")
source("mutation.R")
t=matrix(rnorm(popSize*popLen)+4.2,popSize,popLen)##the distance between two cities
fitValues<-NULL
##Initializing the population and calculate fitness of each group
population<-matrix(0,popSize,len)
fitValues<-rep(0,popSize)
pop<-list(population=population,fitness=fitValues)
for(i in 1:popSize)
{
path<-sample(1:len,replace=FALSE)
pop$population[i,]<-path
pop$fitness[i]<-fitness(path,t)
}
##mainbody
loop<-0
while(loop<loops)
{
##Selection
rate=0.2
selected<-selection(pop,rate)
##Crossing
pop<-crossing(pop, selected)
##mutation
rate=0.01
pop<-mutation(pop,rate)
loop<-loop+1
}
pop
}

