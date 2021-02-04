library(shiny)

shinyUI(
  fluidPage(
    titlePanel(
      "AA",
      title = tags$strong("AA")
    ),
    
    sidebarLayout(
      sidebarPanel(),
      mainPanel()
    )
  )
)