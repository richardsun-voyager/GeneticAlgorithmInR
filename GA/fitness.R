##Calculate the fitness of each route
fitness<-function(x,t)
{
sum<-0
if(class(t)=="matrix")##judge the type of the data
{
for(i in 1:(length(x)-1))
{
sum<-sum+t[x[i],x[i+1]]
}
}
fitness<-sum
}