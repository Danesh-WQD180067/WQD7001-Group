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
load("models_accuracy.RData")
load("models.RData")
test_results <- data.frame(test_data$Cardiovascular_Disease)

test_results$predicted_lda <- predict(fit.lda, test_data)
test_results$predicted_knn <- predict(fit.knn, test_data)
test_results$predicted_nb <- predict(fit.nb, test_data)
test_results$predicted_cart <- predict(fit.cart, test_data)
test_results$predicted_c50 <- predict(fit.c50, test_data)
test_results$predicted_gbm <- predict(fit.gbm, test_data)
test_results$mode <- apply(test_results[2:6], 
                             1, 
                             Compose(table,
                                     function(i) i==max(i),
                                     which,
                                     names,
                                     function(i) i[1]
                                     )
                             )


confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_lda)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_knn)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_nb)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_cart)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_c50)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, test_results$predicted_gbm)
confusionMatrix(test_results$test_data.Cardiovascular_Disease, as.factor(test_results$mode))

# Table comparison
summary(results)
# boxplot comparison
bwplot(results)
# Dot-plot comparison
dotplot(results)

