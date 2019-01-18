# You can create sequences using : notation.
one_to_ninety <- 1:90 # creates a vector of 1 to 90

# you can also use rep(), which REPEATS one element a certain number of times
rep("Xi'an", 5) # [1] "Xi'an" "Xi'an" "Xi'an" "Xi'an" "Xi'an"

# while c() is used to create vectors, you can use c() with a vector and an
# element to lengthen the vector.
people <- c("Sarah", "Amit", "Zhang")
people <- c(people, 'Josh')

# you can change elements in a pre-existing vector
# note that R is a 1-based language rather than 0-based when it comes to index
people[1] <- "George" # people = ("George", "Amit", "Zhang")
people[c(2, 3)] <- c("Laptop", "Pencil")

example <- -5:5 # example = (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5)
example[example<0] <- 0 # example = (0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5)

# defining a function
multiply <- function(x, y) { #you can now call 'multiply' just like a method
	return x*y
}