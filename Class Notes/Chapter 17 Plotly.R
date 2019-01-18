### PLOTLY ###

### A.1 GETTING STARTED ###
install.packages("plotly")
library(plotly)

### A.2 BASIC CHARTS ###
# pass a dataframe into plot_ly and specify what datapoints you want
# to display using parameters
# using ~ indicates that variable as a formula
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, 
	mode = "markers", type = "scatter")


### A.3 LAYOUT ###
# while plot_ly controls data, other aspects of the chart are controlled by
# layout().  You can use piping to neatly edit this stuff
output <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, 
	mode = "markers", type = "scatter", 
	marker = list(size = 10,
				  color = 'rgba(255, 182, 193, .9)',
				  line = list(color = 'rgba(152, 0, 0, .8)',
				  	width = 2))) %>%

# configure layout
layout(title = "Styled Scatter",
	   yaxis = list(zeroline = FALSE),
	   xaxis = list(zeroline = FALSE))

# displays the chart
p


### A.4 HOVERS ###
# plotly provides information on each element when you hover it by default.
# use the attribute `text` in `plot_ly()`to modify the info. Populate it with
# your own data

# your dataset
data <- diamonds[sample(nrow(diamonds), 1000), ]

# create plot, specify the hover text
p <- plot_ly(
	d, x = ~carat, y = ~price, mode = "markers", type = "scatter",

	# hover text.  Note that plotly supports html syntax for its text rather
	# than markdown
	text = ~paste0("Price: $", price, "<br>Cut: ", cut), # <br> is line break
	color = ~carat, size = ~carat
)

# output.  If you're doing a shiny app you have to use renderPlotly and 
# plotlyOutput in ui.R and in assigning output$plot.
p