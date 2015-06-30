##Crossing the parents and producing children
##Written by Richard Soon
crossing<-function(pop,selected)
{
  if(length(selected)>1)
  {parents<-pop$population[selected,]
   size<-dim(parents)
   sequence<-sample(size[1])
   len<-size[2]
   pairs<-as.integer(size[1]/2)##number of pairs
   location<-as.integer(len/2)##cross point

   ##keep the best items
   orders<-order(pop$fitness,decreasing=T)
   bestItem<-pop$population[orders[1],]
   for(i in 1:pairs)
   {
     child1<-NULL
     child2<-NULL
     parent1<-parents[sequence[2*i-1],]##choose parent1 randomly
     parent2<-parents[sequence[2*i],]##choose parent2 randomly
     child1<-parent1[1:location]##Get the first half from Father
     child2<-parent2[1:location]##Get the first half from Mother
     index1<-parent2 %in% child1
     index2<-parent1 %in% child2
     child1[(location+1):len]<-parent2[!index1]##Get the second half from Mother
     child2[(location+1):len]<-parent1[!index2]##Get the second half from Father
     names(child1)<-names(parent1)##Equalize the names
     names(child2)<-names(parent2)##Equalize the names
     parents[sequence[2*i-1],]<-child1  ##Replace the old item
     parents[sequence[2*i],]<-child2 ##Replace the old item
   }
   pop$population[selected,]<-parents
  ## pop<-calPopFit(pop,t)##calculate the new fitness
   ##replace the worst item with the best items
   orders<-order(pop$fitness,decreasing=F)
   pop$population[orders[1],]<-bestItem
  }
   pop
}