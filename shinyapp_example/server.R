### THIS IS THE SERVER CODE FOR NOISYAPP
### IT IS NOT YOUR ASSIGNMENT, JUST YOUR
### EXAMPLE

library(shiny)

server <- function(input, output) {
  createData <- reactive({ # a function that responds to UI interactions
    data.frame( 
      x=rnorm(input$n), # just a bunch of random numbers that simulate data
      y=rnorm(input$n))
  })
  output$plot <- renderPlot({
    noise <- createData() # if input$color changes, shiny WILL NOT RUN THIS LINE OF CODE AGAIN because it does not depend
                          # on input$color.  Which is CRAZY
    plot(y ~ x, data = noise, 
         col = input$color) # base R function. Plot y as vertical and x as horizontal, use `noise` as your dataset
  })
}