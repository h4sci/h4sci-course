library(shiny)
shinyUI(fluidPage(
  titlePanel("A random normal"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs",
                  "Number of obs:",
                  min = 1,
                  max = 1000,
                  value = 100)
    ),
    mainPanel(
      plotOutput("randomPlot")
    )
  )
))
