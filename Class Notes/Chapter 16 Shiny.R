### 16.1 CREATING SHINY APPS ###
# works as an online web framework.  So you code it the same
# but it renders as an interactive webpage
install.packages("shiny")
library(shiny)

### 16.1.1 APPLICATION STRUCTURE ###
# Divided into two parts: the UI and the Server
# The UI is composed of text and graphics like you see in Rmd, but also has 
# widgets, which are interactive controls (buttons and sliders).  The UI specifies
# a layout for this stuff

# the UI is stored in a variable, called from a layout function
# this UI defines a fluidPage with two _content elements_: a text input box
# for typing in the user's name, and some output text that can be changed with
# the `message` variable
my_ui <- fluidPage(
	# this is a widget, a text input box.  The input is saved
	# in the key `username`
	textInput("username", label = "What is your name?"),

	# an output element for `message`
	textOutput("message")
)

# the Server defines what data is going to be displayed through the UI.  It's
# kind of like the script, using _reactive expressions_ that automatically re-run
# whenever an input changes
my_server <- function(input, output) {
	# assign a value to `message` using `output
	output$message <- renderText({

		# notice that every input is saved as a column in `input` and every
		# output is saved as a column in `output`
		greeting_message <- paste("Hello", input$username)
			return greeting_message
		})
}


### 16.1.1.1 COMBINING UI AND SERVER ###
# combine the two elements by defining a file called app.R, which should at
# some point call the function `shinyApp()`
shinyApp(ui = my_ui, server = my_server) # same as clicking "Run App"


### 16.1.2 THE UI ###
# specify the content of what you want in the layout by passing in 
# content elements.  So earlier we passed in a textInput and textOutput
ui <- fluidPage(
	h1("My App"), # first argument, and a header 1
	textInput('username', label = "What is your name?"), # second argument
	textOutput('message')
	)

# UI's _return as content elements_.  This means you can put a layout inside
# of another layout, because they take themselves as arguments
ui <- fluidPage(   # UI is a fluid page
  titlePanel("My Title"),  # include panel with the title (also sets browser title)

  sidebarLayout(   # layout the page in two columns
    sidebarPanel(  # specify content for the "sidebar" column
      p("sidebar panel content goes here")
    ),
    mainPanel(     # specify content for the "main" column
      p("main panel content goes here")
    )
  )
)

# content functions
p() # creates paragraphs like plain text in markdown
h1() # used to create headings. Also h2() and h3() et cetera
em() # creates emphasized text (italics.) same as _text_ in markdown
strong() # creates __bolded__ text


### 16.1.2.1 CONTROL WIDGETS AND REACTIVE OUTPUTS ###
# control widgets are dynamic elements that the user interacts with
textInput() # creates a text box for the user to input text
sliderInput() # creates a slider 
selectInput() # creates a dropdown menu
checkboxInput() # creates checkbox. use checkboxGroupInput() to group them
radioButtons() # creates radio buttons

# each widget takes in at least two arguments
	# the _name_ is what the key is to be called in your input list. so like
		# if you have input `age`, you can access that datapoint with input$age
	# _label_ is information shown alongside the widget to the user
	# other widgets require other arguments though. ex) slider needs min and max

# outputs are how information is sent back to user.  Their information can
# change dynamically
textOutput() # displays a text output
tableOutput() # displays info in a table kind of like kable()
plotOutput() # creates a graphical plot similar to ggplot2


### 16.1.3 THE SERVER ###
# defined by calling a function with this specific format
server <- function(input, output) {
	# any code you don't put in a _render function_ is going to only be
	# run on startup

	# note that your information can only be put in output through a
	# render function
	# this _render function_ is only rerun when one of the input values
	# that it references is changed
 	output$msg <- renderText({
		my_greeting <- "Greetings,"
		message <- paste(my_greeting, input$name)
		return(message)
		})
}

# types of render functions
renderText()
renderTable()
renderPlot()

server <- function(input, output) {
	# when num is changed, it'll regenerate the randomized data that 
	# we're going to plot
	generate_data <- reactive({
			return(runif(input$num, 1, 10))
		})

	# renders a histogram plot with whatever number of datapoints between
	# 1 and ten that the user specified
	output$hist <- renderPlot({
			return(hist(generate_data())) # note THAT IT IS CALLED AS A FUNCTION
		})

	# renders the counts
	output$counts <- renderPrint({
		counts <- factor(cut(generate_data()))
		return(summary(counts))
		})
}


### 16.2 PUBLISHING SHINY APPS ###
# do this through shinyapps.io
# note that you also need this package in Rstudio to make it work.  You run
# all of this stuff in console (make sure the arguments of deployApp() leads
# to the filepath of the app)
install.packages("rsconnect")
library("rsconnect")
deployApp()