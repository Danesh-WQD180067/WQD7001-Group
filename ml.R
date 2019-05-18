library(tidyverse)
library(neuralnet)
library(caTools)
library(caret)

heart_disease <- read.csv("data/clean_cardio_train.csv")
split_data <- sample.split(heart_disease$ï..ID, Split = 0.75)
train_data <- subset(heart_disease, split == T)
test_data <- subset(heart_disease, split == F)

# Create model with default paramters
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 7
metric <- "Accuracy"
set.seed(seed)
mtry <- sqrt(ncol(x))
tunegrid <- expand.grid(.mtry=mtry)
log.model <- train(Cardiovascular_Disease ~ ., data=train_data, method="rf", metric=metric, tuneGrid=tunegrid, trControl=control)
print(log.model)
