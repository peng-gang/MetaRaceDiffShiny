library(shiny)
library(markdown)

source("functions.R")
source("parameters.R")

shinyUI(
  fluidPage(
    titlePanel(
      "meta",
      title = tags$strong("Metabolic Difference between Race/Ethnicity Groups")
    ),
    
    sidebarLayout(
      sidebarPanel(
        width = 3,
        tabsetPanel(
          type = "tabs",
          id = "meta",
          tabPanel(
            "Race",
            tags$div(
              title = "Select two race/ethnicity groups to compare",
              selectInput(
                "race1",
                label = h4("Race 1"),
                choices = makeList(raceAll),
                selected = 1
              ),
              
              selectInput(
                "race2",
                label = h4("Race 2"),
                choices = makeList(raceAll),
                selected = 2
              )
            ),
            
            hr(),
            
            tags$div(
              title = "Select a dataset",
              radioButtons(
                "dataSet", label = h3("Select data set"),
                choices = makeList(c("Controlled", "All")),
                selected = 1
              )
            ),
            
            hr(),
            
            actionButton("btnSubmit", "Submit")
          ),
          
          tabPanel(
            "About",
            includeMarkdown("content/about.md")
          )
        )
      ),
      
      mainPanel(
        plotOutput("cdPlot")
      )
    )
  )
)