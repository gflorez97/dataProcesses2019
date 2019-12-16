# Students
# - Gonzalo Flórez Arias
# - Antonio González Sanz
# - Esaú García Sánchez-Torija
# - Adrián Rodríguez Socorro
# - Rafael Inés Guillén

install.packages(c("dplyr", "ggplot2", "arm", "stringr", "gridExtra", "formattable", "corrplot"))
install.packages(c("plotly", "tidyr", "Hmisc", "car", "lmtest", "tseries", "tibble", "caret", "ggpubr"))
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