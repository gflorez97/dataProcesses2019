# Students
# - Gonzalo Flórez Arias
# - Antonio González Sanz
# - Esaú García Sánchez-Torija
# - Adrián Rodríguez Socorro
# - Rafael Inés Guillén

install.packages(c("plotly", "tidyr", "Hmisc", "car", "lmtest", "tseries", "tibble", "caret", "ggpubr"))
install.packages(c("dplyr", "ggplot2", "arm", "stringr", "gridExtra", "formattable", "corrplot"))
library(dplyr)
library(ggplot2)
library(arm)
library(stringr)
library(gridExtra)
library(formattable)
library(corrplot)
library(plotly)
library(tidyr)
library(Hmisc)
library(car)
library(lmtest)
library(tseries)
library(tibble)
library(caret)
library(ggpubr)

nbaFinal <- as.data.frame(read.csv("./data/nbaFinal.csv", stringsAsFactors = FALSE, header = TRUE))

# Prediction
#K Nearest Neighbors

nbaFinal$isAllNBA <- factor(nbaFinal$isAllNBA)
trainIndex <- createDataPartition(nbaFinal$isAllNBA,
                                  p = .8,
                                  list = FALSE,
                                  times = 1)
training_set <- nbaFinal[ trainIndex, ]
test_set <- nbaFinal[ -trainIndex, ]

fitControl <- trainControl(
  method = "cv",
  number = 10,
  savePredictions = TRUE
)
grid <- expand.grid(k = 1:20)

fit_prediction <- train(
  isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes,
  data = training_set,
  method = "knn",
  trControl = fitControl,
  tuneGrid = grid,
  preProcess = "range"
)

# Make predictions on the test set
fit_cv_grid_pp_preds <- predict(fit_prediction, test_set)

# Assess performance via a confusion matrix
confusionMatrix(test_set$isAllNBA, fit_cv_grid_pp_preds)

# Show the average performance (across folds) for each value of `k`
ggplot(data = fit_prediction$results) +
  geom_line(mapping = aes(x = k, y = Accuracy)) +
  scale_x_continuous(breaks = round(seq(1, 20, by = 1),1))


# Decision tree
install.packages(c("rpart", "rpart.plot"))
library(rpart)
library(rpart.plot)

nbaFinal$isAllNBA <- factor(nbaFinal$isAllNBA)
trainIndex <- createDataPartition(nbaFinal$isAllNBA,
                                  p = .8,
                                  list = FALSE,
                                  times = 1)
training_set <- nbaFinal[ trainIndex, ]
test_set <- nbaFinal[ -trainIndex, ]

tree <- rpart(isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes, data=training_set, cp=.01) #cp: complexity degree

# Make predictions on the test set
fit_cv_grid_pp_preds <- predict(tree, test_set, type = 'class')

# Assess performance via a confusion matrix
confusionMatrix(test_set$isAllNBA, fit_cv_grid_pp_preds)

# Visualize the decision trees
rpart.plot(tree, box.palette="RdBu", shadow.col="gray", nn=TRUE)


# Random forest: worse results (in this case, smaller dataset or our PC can't handle it)
nbaFinal$isAllNBA <- factor(nbaFinal$isAllNBA)
trainIndex <- createDataPartition(nbaFinal$isAllNBA,
                                  p = .01,
                                  list = FALSE,
                                  times = 1)
training_set <- nbaFinal[ trainIndex, ]
test_set <- nbaFinal[ -trainIndex, ]

grid <- expand.grid(mtry = 0:3)

fit_prediction <- train(
  isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes,
  data = training_set,
  method = "cforest",
  trControl = fitControl,
  #tuneGrid = grid,
  preProcess = "range"
)

# Make predictions on the test set
fit_cv_grid_pp_preds <- predict(fit_prediction, test_set)

# Assess performance via a confusion matrix
confusionMatrix(test_set$isAllNBA, fit_cv_grid_pp_preds)
