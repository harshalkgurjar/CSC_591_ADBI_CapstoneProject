#Data Integration
library(gdata)
library(streamR)
library(jsonlite)
library(ggplot2)
library(readr)
library(dplyr)

#load user data
#Due to my low configuration computer I will consider only first 100000 entry
user_data <- read.csv("yelp_dataset_challenge_round9/yelp_academic_dataset_user.csv", nrows=100000)
#load review data
reviews_data <- read.csv("yelp_dataset_challenge_round9/yelp_academic_dataset_review.csv",nrows=100000)

#integrate user data and review data
df_integrated<-merge(x=user_data,y=reviews_data,by="user_id")
#create csv file
write.csv(df_integrated,"yelp_dataset_challenge_round9/integratedUserAndReviewData.csv")