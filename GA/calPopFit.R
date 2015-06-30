##Calculate fitness of the population
##Written by Richard Soon
##pop, population of paths and fitnesses
##t, matrix of distances between each two cities
calPopFit<-function(pop,t)
{
  if(class(pop)=="list")
  {
   size<-length(pop$fitness)
    for(i in 1:size)
    {
     path<-pop$population[i,]
     pop$fitness[i]<-fitness(path,t)
    }
   }
  pop
}