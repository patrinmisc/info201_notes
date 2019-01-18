###Chapter 10 dplyr ###
Data manipulations with dplyr

Chaining with Pipes

Grouping with groupby

(Non-) Standard Evaluation

### Reading CSV Files
# example: seahawks
sh<- read.csv("../data/seahawks2016.csv") # file path
sh<- read.csv("../data/seahawks2016.csv", stringsAsFactors=FALSE)

# example: babynames
# we want to find the most common male and female names in 1998.

##1. Filter out 1998 data, gender data
boys_subset <- babynames[babynames$year == 1998 & babynames$sex == "M"]
boys_subset[which.max(subset$n),]

girls_subset <- babynames[babynames$year == 1998 & babynames$sex == "F"]
girls_subset[which.max(subset$n),]

##2. Find the most popular girl name in 1921
flapper_subset <- babynames[babynames$year == 1921 & babynames$sex == "F"]
flapper_subset[which.max(subset$n),]

# mutate() adds new variables that are functions of existing variables



### 10.1 GRAMMAR OF DATA MANIPULATION
## package that provides a bunch of verbs that let you mess with a dataset
## easily.  The following are capabilities provided by dplyr
	# SELECT specific columns of interest in a dataset
	# FILTER out irrelevant columns
	# MUTATE a dataset by adding more columns
	# ARRANGE the observations (rows) in different orders
	# SUMMARIZE the data in terms of min/max/median/mode/mean
	# JOIN many datasets together into one data frame



### 10.2 USING DPLYR FUNCTIONS
## 10.2.1 SELECT ##

# lets you specify the two columns 'name' and 'sex' from the dataset
# note that these two lines of code say the same thing
select(babynames, name, sex) 
babynames[, c("names", "sex")] # this says "I want column 'name' and column 'sex'
			 				   # and then all rows"

## 10.2.2 FILTER ##
# where SELECT lets you isolate a column that you want, FILTER lets you isolate
# a row that you are looking for--like in Babynames, you can find all of the data
# about the name "Mary".
filter(babynames, year == 1998) # returns a subset of babynames from the year 1998
babynames[babynames$year == 1998,]

filter(babynames, year == 1998, sex == "M") # finds names of boys born in 1998


## 10.2.3 MUTATE ##
# Creates additional columns in the data frame.  With babynames we can add a
# column for whether the name has the letter 'a' in it or not
babynames <- mutate(babynames, vowel_start = stringr::str_detect(name, "a"))


## 10.2.4 ARRANGE ##
# Allows you to sort the rows however you want them to be sorted
sorted_babynames <- arrange(babynames, n) # observations (rows) in ascending order
multiple_arguments <- arrange(babynames, n, name) # sorts by number, then by name


## 10.2.5 SUMMARIZE ##
# computes statistical information about your data
# prints median of the quantities
summary <- summarize(
 babynames,
 median = median(n)
 mean = mean(n)
 sum = sum(n)
 count = n() # number of values
) 


## 10.2.6 DISTINCT ##
# allows you to extract specific rows based on having distinct values
x <- c(1, 1, 2, 2, 3, 3, 4, 4)
y <- 1:8
my_data_frame <- data.frame(x, y)

# performs the check in terms of just the x column
distinct_rows <- distinct(my_data_frame, x)
		# returns	x
		#		  1 1
		#		  2 2
		#		  3 3
		#		  4 4

# Select distinct rows, judging by the `x` and `y`columns
# returns whole table, since no duplicate rows
distinct_rows <- distinct(my_df, x, y)  

### USING PIPING ###
# formatting option that removes the constantly retyping and using pointer
# variables. 

# using nested functions
head(arrange(filter(babynames, year == 1998, sex == "F"), desc(n), 4)

# using the pipe operator  
babynames %>%
	filter(year == 1998, sex == "F") %>%
	arrange(desc(n)) %>%
	head(4)


### 10.4 GROUPED OPERATIONS ###
# let you group rows together so you can perform operations on the
# entire group rather than just one row, kinda like vectorization

# lets say you wanted to know the all-time frequency of names rather
# than their frequency in every given year.
baby_summary <- group_by(babynames, name) %>% 
	summarize(
		mean = mean(n)) # canthelp but feel like you'd have to write babynames$n
		sum = sum(n)
		n = n()
	)

# in another example, answering the following question using the mtcars dataset
# What are the differences in mean miles per gallon for cars with 
# different numbers of gears (3, 4, or 5)?
gear_summary <- group_by(mtcars, gear) %>%
	summarize(mean = mean(mpg))


### 10.5 JOINS ###
# The process of combining data from multiple data frames

# this method looks for columns in the two data frames that have the same
# name, and combines them there. If both data frames have a 'name' column
# then the first argument is the one that keeps its 'name' column while the
# second one loses it

# returns the rows from the left dataframe, updated with information 
# about those rows that were found in the right dataframe
left_join(songs, artists)

# another example with student id's and majors
student_contact <- data.frame(
	student_id = c(1, 2, 3, 4)
	email = c("id1@school.edu", "id2@school.edu", "id3@school.edu", "id4@school.edu")
)

student_majors <- data.frame(
	student_id = c(1, 2, 3, 4)
	major = c("sociology", "math", "biology")
)

merged_student_info <- left_join(student_contact, student_majors)
						#    student_id          email     major
                        # 1          1 id1@school.edu sociology
                        # 2          2 id2@school.edu      math
                        # 3          3 id3@school.edu   biology
                        # 4          4 id4@school.edu      <NA>

# there is also a right_join().  Which does exactly what you think
# inner_join() only returns rows that exist in BOTH dataframes.  You won't
# get any NA values from this
# full_join() returns all rows