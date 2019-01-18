# Chapter 8 Lists

### 8.1.1 CREATING LISTS ###
## functionally lists are kind of like Maps from Java--you can associate
## one data value with another, and they don't even have to be the same type

# as a result of this code, a list of 4 elements exist
# note in the second line that you can instantiate a list without tags
person <- list(first_name = "Ada", job = "programmer", salary = 78000)
person_alt <- list("Ada", "programmer", 78000) # uncommon as it's harder to read
 


### 8.1.2 ACCESSING LISTS ###
# trying to print 'person' would lead to all of this information being printed
# in formatted form
> print(person)
$first_name
[1] "Ada"

$job
[1] "programmer"

$salary
[1] 78000

# you can also access individual fields like so
print(person$first_name) # using $ notation instead of . notation like in java
person$job <- "Senior programmer"

# the names() function gives you the tags used in the list
names(person) # [1] "first_name" "job" "salary"



### 8.1.3 LIST INDICES ###
# rather than using tags, you can also use the index values in a list
# while vectors use [], lists use [[]]
animals <- list("aardvark", "baboon", "camel")
animals[[1]] # [1] "aardvark"
animals[[3]] # [1] "camel"
animals[[4]] # [1] Error: subscript out of bounds!

# or via the name of the tag
person2 <- list(first_name = "Bill", job = "industrial", salary = 60000)
person2[["first_name"]] # [1] "Bill"
person2[["salary"]] # [1] "Bill"



### 8.1.4 MODIFYING LISTS ###
person3 <- list(first_name = "Clem", job = "comm", salary = 20000)

# add elements to a preexisting list by simply declaring them
person3$age # returns NULL
person3$age <- 40
person3$age # now returns 40

# can also do this using indexes
person3[[10]] <- "Tenth field" # elements 5-9 are going to be NULL

# remove elements by assigning their value as NULL

a_list <- list('A', 201, T)
a_list[[2]] <- NULL
print(a_list)
	#[[1]] 'A' [[2]] TRUE



### 8.2 lapply() ###
# lapply() is a function that applies a function to a list, letting you
# modify every element at once
people <- list("Sarah", "Amit", "Zhang")
people_upper <- lapply(people, toupper) # applies toupper() to people
	# [1] "SARAH"
	# [2] "AMIT"
	# [3] "ZHANG"

# a method that has arguments can have its arguments entered in lapply as well
dance_party <- lapply(people, paste, "dances!")
	# [1] "Sarah dances!"
	# [2] "Amit dances!"
	# [3] "Zhang dances!"

# it is common to use lapply to apply your custom function to a big list of data
greet <- function(item) {		# custom function greets the input
  return(paste("Hello", item))
}

# a list of people
people <- list("Sarah", "Amit", "Zhang")

# greet each name
greetings <- lapply(people, greet) # every person is now greeted
            # [1] "Hello Sarah"
            # [1] "Hello Amit"
            # [1] "Hello Zhang"

# sapply() is the same as lapply, but it relates to vectors instead of lists