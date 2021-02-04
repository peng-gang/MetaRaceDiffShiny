library(shiny)

source("functions.R")
source("parameters.R")

shinyServer(function(input, output, session) {
  
  btnCdPlot <- eventReactive(input$btnSubmit, {
    idxRace1 <- as.integer(input$race1)
    idxRace2 <- as.integer(input$race2)
    idxDataSet <- as.integer(input$dataSet)
    
    return(cdPlot(idxRace1, idxRace2, idxDataSet))
  })
  
  output$cdPlot <- renderPlot({
    btnCdPlot()
  })
})