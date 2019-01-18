### 9.1 WHAT IS A DATA FRAME ###
# Data Frames are essentially tables, likened to excel spreadsheets 
# Each row represents a record, where each column is a feature of the record
# In terms of R, a data frame is a list of vector elements.  Each element can
# be of a different data type, giving a lot of versatility



### 9.1.1 CREATING DATA FRAMES ###
height <- 58:62 # vector
weight <- c(115, 117, 120, 123, 126)
my_data <- data.frame(height, weight)

# if a string is in your data frame you should include this last argument
# so the strings arent interpreted as factors
name <- c("Ada", "Bob", "Chris", "Diya", "Emma")
my_data2 <- data.frame(name, height, weight, stringsAsFactors = FALSE)

# note that you can access each of the vectors the same way as you can any
# other element in a list
my_weights <- my_data$weight
my_heights <- my_data[["height"]]



### 9.1.2 DESCRIBING STRUCTURE OF DATA FRAMES ###
# the following functions interact with the structure of a data frame
nrow(my_data_frame) # number of rows in the frame
ncol(my_data_frame) # number of columns in the frame
dim(my_data_frame) # dimensions (rows, cols) of the frame (vector?)
colnames(my_data_frame) # names of each column in a string vector
rownames(my_data_frame) # names of each row in a string vector
head(my_data_frame) # extracts first "few" rows as a data frame
tail(my_data_frame) # extracts last "few" rows as a data frame
View(my_data_frame) # opens the frame in a spreadsheet viewer in R



### 9.1.3 ACCESSING DATA IN DATA FRAMES ###
# kind of like 2D arrays, you can access a data frame using bracket notation
# use the comma to differentiate x vs y traversal through the data frame
my_data_frame[row_index, column_index] # returns the data at this specific cell
my_data_frame[row_name, column_name]
my_data_frame[row, ] # all cells in this row
my_data_frame[ , col] # all cells in this column



### 9.2 WORKING WITH CSV FILES ###
# Comma Separated Value files are easy to interact with in R.  You import it
# using the following command (dont forget to pay attention to working directory)
my_data <- read.csv('my_file.csv', stringsAsFactors=FALSE) 



### 9.2.1 WORKING DIRECTORY ###
# RStudio has its own working directory, which is separate from the directories
# of the scripts it is running.  IT IS PROBABLY BEST TO USE SETTINGS > SET
# WORKING DIRECTORY IN RSTUDIO INSTEAD.  You would set it to Source File Location
getwd() # absolute path of RStudio's current directory
setwd("~/Desktop/project-name") # sets the current directory



### 9.3 Factor Variables ###
# factorizing variables is a way to optimize their storage in memory.  You do
# this with variables that are dedicated to categorizing other pieces of data

# start with a string vector of a bunch of different shirts
shirt_sizes <- c("small", "medium", "small", "large", "medium", "large")

# convert it into a vector of factor data
factored_shirt_sizes <- as.factor(shirt_sizes)

# view the factor and its levels.  It'll be in the same format
print(factored_shirt_sizes)
length(factored_shirt_sizes) # the length will also be the same