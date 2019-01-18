### THIS IS THE UI CODE FOR NOISYAPP
### IT IS NOT YOUR ASSIGNMENT, JUST YOUR
### EXAMPLE
library(shiny)

ui <- fluidPage(
  titlePanel("Just random noise"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "color", # the name to give thet column in input i.e. input$color
        "plot color", 
        c("black", "red", "purple")
        ),
        sliderInput(
          "n", # the name to give the column in input i.e. input$n
          "number of points",
          1, 1000, 100)
    ),
    
    mainPanel(plotOutput("plot")) # references output$plot
  )
)