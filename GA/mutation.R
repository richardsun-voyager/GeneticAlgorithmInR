##Mutation of population,two points mutation
##Written by Richard Soon
##pop:population
##rate:mutation rate of the population
mutation<-function(pop,rate)
{
  size<-dim(pop$population)
  num<-as.integer(size[1]*rate)
  if(num>0)
  {  selected<-sample(size[1],num)##select items which are going to mutate
     location<-sample(size[2],2)##select the points where mutation happens
     ##keep the best items
     orders<-order(pop$fitness,decreasing=T)
     bestItem<-pop$population[orders[1],]
     for(i in selected)
     {
       item<-pop$population[i,]
       ##swap the values
       temp<-item[location[1]]
       item[location[1]]<-item[location[2]]
       item[location[2]]<-temp
       pop$population[i,]<-item
     }
     ##replace the worst item with the best items
     orders<-order(pop$fitness,decreasing=F)
     pop$population[orders[1],]<-bestItem}
    pop 
}