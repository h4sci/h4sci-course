shinyServer(function(input, output) {
  output$randomPlot <- renderPlot({
    hist(rnorm(input$obs),
         col = 'darkgray',
         border = 'white')
  })
})
