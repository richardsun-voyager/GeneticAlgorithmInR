
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Genetic Algorithm For Traveling Salesman Problem"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput('mutationRate', 'Numeric input, rate of mutation', 0.005, min = 0.005, max = 0.5, step = 0.005),
      sliderInput('crossingRate', 'Numeric input, rate of crossing', 0.1, min = 0.1, max = 1, step = 0.01),
      numericInput('popSize',  "Size of the population",20,min=20,max=100,step=10),
      numericInput('popLength',  "Number of cities",10,min=10,max=100,step=10),
      numericInput('repTimes',  "Repetition Times",10,min=10,max=2000,step=100)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      h4('The optimized path is'),
      verbatimTextOutput("path"),
      h4('The graph is below'),
      plotOutput('graph')
#       h4('The total distance'),
#       verbatimTextOutput("distance"),
    )
  )
))
