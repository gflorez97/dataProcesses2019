# Students
# - Gonzalo Flórez Arias
# - Antonio González Sanz
# - Esaú García Sánchez-Torija
# - Adrián Rodríguez Socorro
# - Rafael Inés Guillén

library(dplyr)
library(nbastatR)
library(ggplot2)
library(arm)
library(stringr)
library(gridExtra)
library(formattable)
library(corrplot)

# Taking all NBA player stats, and getting the name without * (to be able to join by name)
nba.players <- as.data.frame(read.csv("./data/Seasons_Stats.csv", stringsAsFactors = FALSE, header = TRUE))
nba.players$Player <- gsub("\\*", "", nba.players$Player)

# Taking all players in any ALL NBA team
all.nbaAPI <- all_nba_teams(return_message =TRUE)

# Taking all players that appear in the NBA FIRST or SECOND team (ALL NBA)
all.nbaAPI <- all.nbaAPI %>% 
  filter(isAllNBA1==TRUE | isAllNBA2==TRUE)

# Reducing the All NBA dataframe to name, year and isAllNBA, and changing name to join easier
all.nbaAPI <- all.nbaAPI %>% 
  select(Player = namePlayer, Year = yearSeason, isAllNBA)

# Joining both dataframes to obtain a new variable, isAllNBA, in the original dataset
all.nbaAPI <- left_join(nba.players, all.nbaAPI, copy=T)

# Setting to false every NA for the new isAllNBA variable
all.nbaAPI$isAllNBA[is.na(all.nbaAPI$isAllNBA)] <- FALSE

# Taking only the columns we are going to need. Most columns have to be adapted to the "per game" version (adjusting to integer)
all.nbaFinal <- all.nbaAPI %>% 
  transform(Points = PTS%/%G, Minutes = MP%/%G, Fouls = PF%/%G, 
            Rebounds = TRB%/%G, Assists = AST%/%G, Blocks = BLK%/%G, Steals = STL%/%G, Turnovers = TOV%/%G) %>% 
  select(isAllNBA, Year, Player, Position = Pos, Rebounds, 
         Assists, Blocks, Steals, Points, 
         Turnovers, FieldGoalPercentage = FG., Minutes, Fouls)

# We will start from the 1978 season, as it is the first season with all data available
all.nbaFinal <- all.nbaFinal %>% 
  filter(Year >= 1978) %>% 
  na.omit()

# Saving the dataset
write.csv(all.nbaFinal,"./data/nbaFinal.csv", row.names = TRUE)

#####################

library(plotly)
library(tidyr)
library(Hmisc)
library(car)
library(lmtest)
library(tseries)
library(tibble)
library(caret)

# Initial visualization
nbaFinal <- as.data.frame(read.csv("./data/nbaFinal.csv", stringsAsFactors = FALSE, header = TRUE))

# Graph1
nbaFinal %>% 
  select(Points, Rebounds, Assists, Blocks, Steals, Turnovers, FieldGoalPercentage, Minutes, Fouls) %>% 
  hist()

# Graph2
ggplot(data = nbaFinal, mapping = aes(x = FieldGoalPercentage, y = Points)) +
  geom_point(alpha = 1, aes(color = Minutes)) +
  ggtitle("Plot of Points by FieldGoalPercentage, colored by Minutes")

# Standard deviation in Field Goal Percentage for less and more than 20 minutes per game
nbaFinal %>% filter(Minutes < 20) %>% select(FieldGoalPercentage) %>% apply(MARGIN=2, FUN=sd)
nbaFinal %>% filter(Minutes >= 20) %>% select(FieldGoalPercentage) %>% apply(MARGIN=2, FUN=sd)

#...

# Linear model
model = lm(isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes, data=nbaFinal)
summary(model)
outlierTest(model)
plot(model, which=c(1:4), ask=F)


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
  geom_line(mapping = aes(x = k, y = Accuracy))


#LMT

grid <- expand.grid(iter = 1:5)

fit_prediction <- train(
  isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes,
  data = training_set,
  method = "LMT",
  trControl = fitControl,
  tuneGrid = grid,
  preProcess = "range",
)

# Make predictions on the test set
fit_cv_grid_pp_preds <- predict(fit_prediction, test_set)

# Assess performance via a confusion matrix
confusionMatrix(test_set$isAllNBA, fit_cv_grid_pp_preds)

# Show the average performance (across folds) for each value of `k`
ggplot(data = fit_prediction$results) +
  geom_line(mapping = aes(x = k, y = Accuracy))


# Decision tree

library(rpart)
library(rpart.plot)
tree <- rpart(isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes, data=nbaFinal, cp=.02) #cp: complexity degree
# Visualize the decision trees
rpart.plot(tree, box.palette="RdBu", shadow.col="gray", nn=TRUE)
