library(gdata)
library(streamR)
library(jsonlite)
library(ggplot2)
library(readr)
library(dplyr)
library(caret)
library(qdap)
library(quantmod)
df_userReview<-read.csv("yelp_dataset_challenge_round9/integratedUserAndReviewData.csv")

#calculate number of word in review and adding colum to df_userReview
for(i in 1:nrow(df_userReview)){
wordCount<-wc(df_userReview$text)
}
wordCount<-wc(df_userReview$text)
df_userReview["ReviewLength"]<-NA
df_userReview$ReviewLength<-wordCount

# model to build prediction of ratings by user

fit1 <- lm(stars ~ average_stars, data = df_userReview)
summary(fit1)
fit2 <- lm(stars ~ review_count, data = df_userReview)
summary(fit2)
fit3 <- lm(stars ~ ReviewLength, data = df_userReview)
summary(fit3)
fit4 <- lm(stars ~ average_stars+  review_count +ReviewLength, data = df_userReview)
summary(fit4)
anova(fit1, fit2, fit3)

# split data into training set and testing set
#60% training set and 40 % testing set

inTrain = createDataPartition(df_userReview$stars, p = 0.6, list=FALSE)
training = df_userReview[ inTrain,]
testing = df_userReview[-inTrain,]
dim(training)
dim(testing)


## validation of model
modFit <- train(stars ~ average_stars + review_count+ReviewLength,data=training,method="lm")
predictions <- round(predict(modFit, testing))
u = union(predictions, testing$stars)
t = table(factor(predictions, u), factor(testing$stars, u))
confusionMatrix(t)

##testing
testing$predictions <- predictions
testing$difference <- testing$stars - testing$predictions
hist(testing$difference, breaks = 10, main = "Difference between Predicted and Actual")
axis(side=1, at=seq(-5,5, 1), labels=seq(-5,5,1))

## difference
difference <- as.data.frame(table(testing$difference))
(difference[4,2]+difference[5,2]+difference[6,2])/sum(difference[,2])
# 0.6564164

##ouput top 10 restuarants
business_data <- read.csv("yelp_dataset_challenge_round9/yelp_academic_dataset_business.csv", nrows=100000)
df_topBusinessId<-data.frame(c(df_userReview$business_id,predicted_values))
business_DaTa<-data.frame(c(businessIdVec,predicted_values))
#order based on predicted ratings
sortedBusinessList<-business_data[order(business_data$stars),]
print("Top 10 restaurants are : \n")
for(i in 1:10)
{
print(sortedBusinessList$name[i])
}



