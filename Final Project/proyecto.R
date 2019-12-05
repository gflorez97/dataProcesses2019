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

# Taking all NBA player stats, and getting the name without *
nba.players <- as.data.frame(read.csv("./data/Seasons_Stats.csv", stringsAsFactors = FALSE, header = TRUE))
#FALTA QUITAR EL * de los nombres para que el JOIN vaya bien

# Taking all players in any ALL NBA team
all.nbaAPI <- all_nba_teams(return_message =TRUE)

# Taking all players that appear in the NBA FIRST and SECOND team (ALL NBA)
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
  transform(Points = PTS%/%G, MinutesPerGame = MP%/%G, FoulsPerGame = PF%/%G, 
            Rebounds = TRB%/%G, Assists = AST%/%G, Blocks = BLK%/%G, Steals = STL%/%G, Turnovers = TOV%/%G) %>% 
  select(isAllNBA, Year, Player, Position = Pos, Rebounds, 
         Assists, Blocks, Steals, Points, 
         Turnovers, FieldGoalPercentage = FG., MinutesPerGame, FoulsPerGame)

# We will start from the 1978 season, as it is the first season with all data available
all.nbaFinal <- all.nbaFinal %>% 
  filter(Year >= 1978) %>% 
  na.omit()

# Saving the dataset
write.csv(all.nbaFinal,"./data/nbaFinal.csv", row.names = TRUE)