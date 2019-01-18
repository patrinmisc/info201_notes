Chapter 11 Web API
## API links are composed of two elements.

### 11.2 RESTFUL REQUESTS ###
# this is the base URI, which references the database we want
https://api.github.com/ 

# this is an endpoint, which specifies what datapoint we want
# from the database.  The structure of the endpoints is of
# course going to change between databases
/users/mkfreeman				# accesses the user info of {user}
/orgs/{organization}/repos		# accesses the repos of {organization}

# example of accessing my github account info
https://api.github.com/users/patrinsinteppadon


### 11.2.1.1 QUERY PARAMETERS ###
# after the path, you can write an additional query to get a set of information
# that falls within a grouping, kind of like what you'd get from dplyr

# they always start with a question mark, followed by your parameters which follow
# key and value format

# firstParam is the key, firstValue is the data
firstParam=firstValue

?firstParam=firstValue&secondParam=secondValue&thirdParam=thirdValue

# it seems like the keys are built into the api, and it knows what to do with
# it. so with google, the endpoint /search has a parameter q
https://www.google.com/search?q=patrin


### 11.2.1.2 ACCESS TOKENS AND API KEYS ###
# provided by APIs so they can recognize who is requesting info
# it's usually provided as a query, the parameter is usually named
# something like access_token or api_key

# write your password into another script in the repo so it doesn't get
# pushed to the cloud.  Then include the file name in the .gitignore file
api_key <- "123456789abcdefg"

# this is how you access the variable in another script
source("api-key.R")
print(api_key)


### 11.2.2 HTTP VERBS ###
# when you send a request to an API you have to tell it what you wanna do.
# In a web browser you're usually just trying to retrieve information which
# means it's a GET function.  But you can also do the following:
GET # returns a representation of the current state of the resource
POST # adds a new subresource (kinda like insert a record)
PUT # update the resource to have a new state
PATCH # Update part of the resource
DELETE # Remove the resource
OPTIONS # returns methods that can be used


### 11.3 ACCESSING WEB API'S ###
# use the httr library to send GET requests through R
install.packages("httr")
library("httr")

# one way of saying it
response <- GET("https://api.github.com/search/repositories?q=d3&sort=forks")

# another way of saying it
query_params <- list(q = "d3", sort = "forks")
response <- GET("https://api.github.com", query = query_params)


### 11.4 JSON DATA ###
# Most data from APIs is returned in JavaScript Object Notation. A big element
# is that JSON lets you organize data in key-value pairs

# example
{
  "first_name": "Ada",
  "job": "Programmer",
  "salary": 78000,
  "in_union": true,
  "favorites": {		# this is a list
    "music": "jazz",
    "food": "pizza",
  }
  ["Aardvark", "Baboon", "Camel"]
}

# this is a common way that a data frame would be displayed in JSON
[
  { "opponent": "Dolphins", "sea_score": 12, "opp_score": 10 },
  { "opponent": "Rams", "sea_score": 3, "opp_score": 9 },
  { "opponent": "49ers", "sea_score": 37, "opp_score": 18 },
  { "opponent": "Jets", "sea_score": 27, "opp_score": 17 },
  { "opponent": "Falcons", "sea_score": 26, "opp_score": 24 }
]

### 11.4.1 PARSING JSON DATA ###
# while httr is able to parse the json data into R-friendly data
# structures, jsonlite is a better library for parsing.
install.packages("jsonlite")
library("jsonlite")

# send request for albums by David Bowie
# usually the dataframe you get after you first do this is going to be
# messy.  You have to play with the data a bit more to clean it up
<<<<<<< HEAD
query_params <- list(q = "d3", sort = "forks")
response <- GET("https://api.github.com", query = query_params)
>>>>>>> 112475b2d49fb2adbcb635aef504ee74c89a9a15
body <- content(response, "text")  # extract the body JSON
parsed_data <- fromJSON(body)  # convert the JSON string to a list

# to clean data, you can either print() it, use str(), or use names()
# to get a list of the keys which might help you figure out what to do

# continuation of the previous code
is.data.frame(parsed_data) # NOT USABLE, just CONVERTING TO AN R STRUCTURE
names(parsed_data)
		# "href" "items" "limit" "next" "offset" "previous" "total"
	# note that 'items' is the key we probably want the most

items <- parsed_data$items  # extract that element from the list
is.data.frame(items)  # TRUE; you can work with that!


### 11.4.2 FLATTENING DATA ###
# use flatten when you're working with a nested list
people <- flatten(people)