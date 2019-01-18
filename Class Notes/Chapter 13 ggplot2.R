### THE gglot2 LIBRARY ###
# programmatically creates visualizations through a nifty vocab set
# called the Grammar of Graphics, kind of like dplyr's grammarset.


### 13.1 A GRAMMAR OF GRAPHICS ###
# construct graphical figures out of visual elements.
# lets you control the following:
#		the _data_ being plotted
#		the _geometric objects_ in the plot (circles, lines)
#		the _aesthetics_ of the objects and the _mappings_ of variables
#	to those aesthetics
#		_statistical transformation_ used to calculate the data in the plot
#		_position adjustment_ for locating each geometric object on the plot
#		_scale_ (range of values) for each aesthetic mapping used
#		_coordinate system_ to organize the geometric objects
#		_facets_ (groups of data) that are displayed on different plots

# this is also split up into _layers_ where each layer has exactly one
# geometric object, one statistical transformation, and one position adjustment


### 13.2 BASIC PLOTTING WITH ggplot2 ###
# to start plotting, call ggplot() with your dataset as your argument
# then you add new layers which are _geometric objects_
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy))
			# creates a graph with mpg's data
			# `displ` and `hwy` are columns from the dataset

# there are many types of _geometric objects_ you can specify. Each of them
# represents a different way to convey the data
geom_point() 		# plot of just the data points
geom_bar() 			# plot of a bar chart
geom_abline()		# draws a line
geom_hline()		# draws a horizontal line
geom_vline()		# draws a vertical line

# for each geometric object you need to specify its _aesthetic mappings_
# typically you do this using aes().  You can then add more layers using 
# + notation, the same way you can use piping %>% in dplyr


### 13.2.1 AESTHETIC MAPPINGS ###
# takes properties of data and uses them to influence _visual channels_
# like position or color or size or shape.

# adding `color = class` makes ggplot2 look at the `class` column in mpg
# and assign a color to each one.  It'll then map the dots on the plot to
# each color and look real dope
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class))

# meanwhile if you want to set the entire geometric object to a color,
# you need to do it as an argument of geom_point() instead of aes()
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy), color = "blue")


### 13.3 COMPLEX PLOTS ###
# Basically any kind of plot can be built using the grammar of graphics.


### 13.3.1 SPECIFYING GEOMETRY ###
# different types of _geometric objects_  give you the most power in making
# different-looking plots.
geom_point()		# for drawing individual points (e.g. scatter plot)
geom_line()		# for drawing lines (e.g. line chart)
geom_smooth()	# for drawing smoothed lines (trends or approximations)
geom_bar()		# for drawing bars (e.g. bar chart)
geom_polygon() 	# for drawing shapes (something on a coordinate plane)
geom_map()		# for drawing a map using polygons (use map_data())
 	
# line graph of the same data
ggplot(data = mpg) +
	geom_line(mapping = aes(x = displ, y = hwy))

# bar chart of the same data
ggplot(data = mpg) +
	geom_bar(mapping = aes(x = class)) # notice no y, because bar chart

# scatter plot AND a trend line
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	geom_smooth(mapping = aes(x = displ, y = hwy))


### 13.3.1.1 STATISTICAL TRANSFORMATIONS ###
# data created from the dataset to further process information. An example is
# in the bar chart--it uses "count" as the y axis, which wasn't a column in
# `mpg` but was statistically derived from it.

# control the _statistical transformation_ that ggplot executes on the dataset
# using the keyword `stat`
# `identity` is a tag that does not transform the data.  It leaves it alone
ggplot(new_cars) +
	geom_bar(mapping = aes(x = car, y = hwy), stat = "identity")
	coord_flip() # flips the bar chart sideways

# can use various stat_ transformations in the same way you can use geom_.
ggplot(data = mpg) +
	stat_bin(aes(x = hwy, color = hwy), binwidth = 4) # histogram in groups of 4

# many geom_ and stat_ functions are actually the same thing because reasons
ggplot(data = mpg) +						# these two are
	geom_bar(mapping = aes(x = class))

ggplot(data = mpg) +						# the same chart
	stat_count(mapping = aes(x = class))

### 13.3.1.2 POSITION ADJUSTMENTS ###
# another aspect of each `geom_` is they have a default _position adjustment_
# which talks about how the components should be spaced relative to one another

# bar chart of mileage, colored by engine type
ggplot(data = mpg) +
	geom_bar(mapping = aes(x = hwy, fill = class)) 
					   # fill color instead of outlining
#
 you can transform bar charts to fill the space above the bar with a color
# rather than being blank by messing with `position`
ggplot(data = mpg) +
	geom_bar(mapping = aes(x = hwy, fill = drv), position = "fill")

ggplot(data = mpg) +
	geom_bar(mapping = aes(x = hwy, fill = drv), position = "dodge")


### 13.3.2 STYLING WITH SCALES ###
# scales determine the range of values the data maps to.
# both of these are the same, these are just the default scales the funct uses
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
	scale_x_continuous() +
	scale_y_continuous() +
	scale_colour_discrete()

# every scale starts with scale_ followed by the name of the aesthetic property
# and then the name of the scale. `continuous` scales are for things like
# numeric data (with a continuous set of numbers) whereas `discrete` scales
# are for stuff like colors, which has a small list of distinct elements.
# you can specify different scales if you wanted
ggplot(data = mpg) +
	geom_point(mapping = aes(x = cty, y = hwy)) +
	scale_x_reverse()

# put limits your scale so you can change the window of the plot
suv <- mpg %>% filter(class == "suv")
ggplot(data = suv) +
	geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
	scale_x_continuous(limits = range(mpg$displ)) +
	scale_y_continuous(limits = range(mpg$hwy))

# color is a common scale to want to change.  Based off of the website
# colorbrewer.org, you can set them like this
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 4) +
	scale_color_brewer(palette = "Set3")


### 13.3.3 COORDINATE SYSTEMS ###
# Self explanatory.  Mess with the type of coordinate system the chart uses.
# these also support the xlim and ylim args, specifying the limits of the system
coord_cartesian 	# conventional x and y value grid
coord_flip			# cartesian system where x and why are inverted
coord_fixed 		# cartesian system with a fixed aspect ratio
coord_polar 		# uses polar coordinates
coord_quickmap 		# coordinate system that approximates a good aspect ratio.


### 13.3.4 FACETS ###
# groups data plots into smaller subplots based on what are called categorical
# variables.  Use facet_wrap() to construct a multifaceted plot
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_wrap(~class)


### 13.3.5 LABELS AND ANNOTATIONS
# add them using labs()
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
	labs(
		title = "Fuel Efficiency by Engine Power, 1999-2008",
		x = "Engine power (litres displacement)",
		y = "Fuel Efficiency (miles per gallon)",
		color = "Car Type" # puts a label by the legend describing the colors
	)

# put labels directly on the plot using geom_text() or geom_labels.  Basically
# this is plotting a new set of data that happens to be the labels that you want
# use ggrepel to position the labels properly
best_in_class <- mpg %>%
	group_by(class) %>%
	filter(row_number(desc(hwy)) == 1)

	ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
		geom_point(mapping = aes(color = class)) +
		geom_label(data = best_in_class, 
				   mapping = aes(label = model, alpha = 0.5))


### 13.4 OTHER VISUALIZATION LIBRARIES ###
# the intent of ggplot2 is to create static visualizations.  To have one that
# can be interacted with, use  ggvis, Bokeh, Plotly, or rCharts