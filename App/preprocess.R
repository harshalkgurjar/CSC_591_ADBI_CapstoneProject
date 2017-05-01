#install.packages("streamR")
#install.packages("jasonlite")
#install.packages("readr")
#install.packages("dplyr")
library(gdata)
library(streamR)
library(jsonlite)
library(ggplot2)
library(readr)
library(dplyr)
#tip <- stream_in(file("yelp_dataset_challenge_round9/yelp_academic_dataset_tip.json"))
#checkin <- stream_in(file("yelp_dataset_challenge_round9/yelp_academic_dataset_checkin.json"))
###
#load user data
#Due to my low configuration computer I will consider only first 100000 entry
user_data <- read.csv("yelp_dataset_challenge_round9/yelp_academic_dataset_user.csv", nrows=100000)
#load review data
reviews_data <- read.csv("yelp_dataset_challenge_round9/yelp_academic_dataset_review.csv",nrows=100000)

#review <- stream_in(file("yelp_dataset_challenge_round9/yelp_academic_dataset_review.json"))
#business <- stream_in(file("yelp_dataset_challenge_round9/yelp_academic_dataset_business.json"))
#plot average ratings of all users
##
ggplot(user_data, aes(x = average_stars)) + geom_histogram(alpha = .50, binwidth=.1, colour = "blue")
#Plot graph for review count vs average stars. 
#This will give us idea about how many reviews do we have for each ratings
##
ggplot(user_data, aes(average_stars, review_count)) + geom_point()
# plot graph of stars given by user
ggplot(user, aes(x = astars)) + geom_histogram(alpha = .50, binwidth=.1, colour = "black")



