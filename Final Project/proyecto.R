# Students
# - Gonzalo Flórez Arias
# - Antonio González Sanz
# - Esaú García Sánchez-Torija
# - Adrián Rodríguez Socorro
# - Rafael Inés Guillén

install.packages(c("dplyr", "ggplot2", "arm", "stringr", "gridExtra", "formattable", "corrplot"))

#nbastatR only needed to access the original dataset from the API
library(nbastatR)

library(dplyr)
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

install.packages(c("plotly", "tidyr", "Hmisc", "car", "lmtest", "tseries", "tibble", "caret", "ggpubr"))
library(plotly)
library(tidyr)
library(Hmisc)
library(car)
library(lmtest)
library(tseries)
library(tibble)
library(caret)
library(ggpubr)

# Initial visualization
nbaFinal <- as.data.frame(read.csv("./data/nbaFinal.csv", stringsAsFactors = FALSE, header = TRUE))

# Graph1
nbaSelect <- nbaFinal %>%
  select(Points, Rebounds, Assists, Blocks, Steals, Turnovers, FieldGoalPercentage, Minutes, Fouls)

drawFunction <- function(dataToDraw,xTitle,size){
  ggplot(nbaSelect, aes(x=dataToDraw)) + xlab(xTitle) + labs() + ggtitle("")+
    geom_histogram(color="black", fill="white", binwidth = size)
}

ggarrange(drawFunction(nbaSelect$Points,xTitle ="Points",size = 1), drawFunction(nbaSelect$Rebounds,xTitle = "Rebounds",size = 1), drawFunction(nbaSelect$Assists,xTitle = "Assists",size = 1),
          drawFunction(nbaSelect$Blocks,xTitle = "Blocks",size = 1), drawFunction(nbaSelect$Steals, xTitle = "Steals",size = 1), drawFunction(nbaSelect$Turnovers,xTitle = "Turnovers",size = 1),
          drawFunction(nbaSelect$FieldGoalPercentage,xTitle = "FieldGoalPercentage",size = 0.01), drawFunction(nbaSelect$Minutes,xTitle = "Minutes",size = 1), drawFunction(nbaSelect$Fouls,xTitle = "Fouls",size = 1),
          labels = c("Points", "Rebounds", "Assists","Blocks","Steals","Turnovers","FieldGoalPercentage","Minutes","Fouls"),
          ncol = 3, nrow = 3)

# Graph2
ggplot(data = nbaFinal, mapping = aes(x = FieldGoalPercentage, y = Points)) +
  geom_point(alpha = 1, aes(color = Minutes)) +
  ggtitle("Plot of Points by FieldGoalPercentage, colored by Minutes")

# Standard deviation in Field Goal Percentage for less and more than 20 minutes per game
nbaFinal %>% filter(Minutes < 20) %>% select(FieldGoalPercentage) %>% apply(MARGIN=2, FUN=sd)
nbaFinal %>% filter(Minutes >= 20) %>% select(FieldGoalPercentage) %>% apply(MARGIN=2, FUN=sd)

# Graph 3 #Over the original dataset with all players
library(DataExplorer)
plot_missing(all.nbaFinal, geom_label_args = list("size" = 3, "label.padding" = unit(0.3, "lines")),group = list("Perfect" = 0, "Valid" = 0.06, "No valid" = 1))+ labs(y="N. Missing Values",x="Value", title ="Missing Values") + theme_light()

all.nbaFinal2 = all.nbaFinal[!duplicated(all.nbaFinal$Year),]
all.nbaFinal2$na_count <- apply(all.nbaFinal2, 1, function(x) sum(is.na(x)))
all.nbaFinal2 <- all.nbaFinal2[!is.na(all.nbaFinal2$Year), ]

ggplot(data=all.nbaFinal2, aes(x=Year, y=na_count, colour = factor(na_count))) + geom_point() +
  labs(y="Missing Values", x="Year", colour="Missing Values", title="Number of Missing values per year") + 
  theme_light()

# Graph 4
ggarrange(ggplot(data = nbaFinal) +
            geom_violin(aes(x=isAllNBA, y = Points, fill= isAllNBA)),
          ggplot(data = nbaFinal) +
            geom_violin(aes(x=isAllNBA, y = Rebounds, fill= isAllNBA)),
          ggplot(data = nbaFinal) +
            geom_violin(aes(x=isAllNBA, y = Assists, fill= isAllNBA)),
          ggplot(data = nbaFinal) +
            geom_violin(aes(x=isAllNBA, y = Minutes, fill= isAllNBA)))

nbaFinal %>%  filter(Minutes > 39) %>% summary

# Graph 5
uniPosition <- nbaFinal %>% 
  filter(Position %in% c("C","PF","SF","SG","PG")) %>% 
  arrange(Position)

ggdensity(uniPosition, x = "Minutes", fill = "isAllNBA", palette = "simpsons")




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
