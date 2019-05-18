library(tidyverse)
library(mlbench)
library(caret)
require(caTools)

heart_disease <- read.csv("data/clean_cardio_train.csv")
heart_disease <- subset(heart_disease, select = -c(ï..ID))
sample <- sample.split(heart_disease, SplitRatio = 0.75)
train_data <- subset(heart_disease, sample == TRUE)
test_data <- subset(heart_disease, sample == FALSE)

# Create model with default paramters
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 101
metric <- "Accuracy"
preProcess=c("center", "scale")

# Linear Discriminant Analysis
set.seed(seed)
fit.lda <- train(Cardiovascular_Disease~., data=train_data, method="lda", metric=metric, preProc=c("center", "scale"), trControl=control)
# kNN
set.seed(seed)
fit.knn <- train(Cardiovascular_Disease~., data=train_data, method="knn", metric=metric, preProc=c("center", "scale"), trControl=control)
# Naive Bayes
set.seed(seed)
fit.nb <- train(Cardiovascular_Disease~., data=train_data, method="nb", metric=metric, trControl=control)
# CART
set.seed(seed)
fit.cart <- train(Cardiovascular_Disease~., data=train_data, method="rpart", metric=metric, trControl=control)
# C5.0
set.seed(seed)
fit.c50 <- train(Cardiovascular_Disease~., data=train_data, method="C5.0", metric=metric, trControl=control)
# Stochastic Gradient Boosting (Generalized Boosted Modeling)
set.seed(seed)
fit.gbm <- train(Cardiovascular_Disease~., data=train_data, method="gbm", metric=metric, trControl=control, verbose=FALSE)

save(fit.lda, fit.knn, fit.nb, fit.cart, fit.c50, fit.gbm, file = "models.RData")

results <- resamples(list(lda=fit.lda, knn=fit.knn, nb=fit.nb, cart=fit.cart, c50=fit.c50,
                          gbm=fit.gbm))

#bagging=fit.treebag,

save(results, file = "models_accuracy.RData")

test_data$predicted <- predict(fit.gbm, test_data)

# Table comparison
summary(results)
# boxplot comparison
bwplot(results)
# Dot-plot comparison
dotplot(results)

