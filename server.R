
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
GA<-function(popSize,popLen,crossingRate,mutationRate,loops)
{
  set.seed(111)
  source("GA/fitness.R")
  source("GA/selection.R")
  source("GA/crossing.R")
  source("GA/calPopFit.R")
  source("GA/mutation.R")
  t<-matrix(rnorm(popLen*popLen)+4.2,popLen,popLen)##the distance between two cities
  fitValues<-NULL
  ##Initializing the population and calculate fitness of each group
  population<-matrix(0,popSize,popLen)
  fitValues<-rep(0,popSize)
  pop<-list(population=population,fitness=fitValues)
  for(i in 1:popSize)
  {
    path<-sample(1:popLen,replace=FALSE)
    pop$population[i,]<-path
    pop$fitness[i]<-fitness(path,t)
  }
  ##mainbody
  loop<-0
  while(loop<loops)
  {
    ##Selection
    rate<-crossingRate
    selected<-selection(pop,rate)
    ##Crossing
    pop<-crossing(pop, selected)
    pop<-calPopFit(pop,t)
    ##mutation
    rate<-mutationRate
    pop<-mutation(pop,rate)
    pop<-calPopFit(pop,t)
    loop<-loop+1
  }
  orders<-order(pop$fitness,decreasing=T)
  bestItem<-pop$population[orders[1],]
  bestItem
}

library(shiny)
library(ggplot2)
shinyServer(function(input, output) {

  path<-reactive({popSize<-input$popSize
                  popLen<-input$popLength
                  loops<-input$repTimes
                  mr<-input$mutationRate
                  cr<-input$crossingRate
                  GA(popSize,popLen,cr,mr,loops)})
  
  output$path<-renderPrint({path()
  })
  output$graph<-renderPlot({
    len<-length(path())
    x<-seq(len)
    y<-path()
    cityname<-paste0("City",as.character(y))
    route<-data.frame(x,y,cityname)
#     g<-ggplot(route,aes(x,y))
#     g<g+geom_point(color='red',size=3)
#     g<-g+geom_line(color='green',size=1)+geom_text(aes(label=cityname))
#     g<-g+labs(title="Optimal Path for Traveling Salesman",x="City Sequence",y="City Name")
#     print(g)
     plot(route$x,route$y,xlab="City Sequence",ylab="City Name")
     lines(path(),col='red')
     text(x,y,labels=cityname)
    })
  
})
