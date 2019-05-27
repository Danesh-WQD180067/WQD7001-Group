#library(mlbench)
#install.packages("readr")
library(tidyverse)
library(caret)
library(readr)
library(stats)
library(gbm)
library(C50)
library(rpart)
library(klaR)
library(ggplot2)
heart_disease <- read_csv("data/clean_cardio_train.csv")
heart_disease <- subset(heart_disease, select = -c(ID))
load("models.RData")

Modes <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)]
}

getMin <- function(x) {
  min <- sum(boxplot(as.numeric(x), plot = FALSE)$stats[1])
  median <- sum(boxplot(as.numeric(x), plot = FALSE)$stats[3])
  return(min - (median - min))
}
getMax <- function(x) {
  max <-  sum(boxplot(as.numeric(x), plot = FALSE)$stats[5])
  median <- sum(boxplot(as.numeric(x), plot = FALSE)$stats[3])
  return(max + (max - median))
}
