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

# Linear model

nbaFinalLM = nbaFinal
nbaFinalLM$pointsCuant <- NA
nbaFinalLM$pointsCuant[nbaFinalLM$Points <= 10] <- "LOW"
nbaFinalLM$pointsCuant[ 10 < nbaFinalLM$Points & nbaFinalLM$Points <= 20] <- "MEDIUM"
nbaFinalLM$pointsCuant[nbaFinalLM$Points > 20] <- "HIGH"

nbaFinalLM$minutesCuant <- NA
nbaFinalLM$minutesCuant[nbaFinalLM$Minutes <= 15] <- "LOW"
nbaFinalLM$minutesCuant[ 15 < nbaFinalLM$Minutes & nbaFinalLM$Minutes <= 30] <- "MEDIUM"
nbaFinalLM$minutesCuant[nbaFinalLM$Minutes > 30] <- "HIGH"

nbaFinalLM$isAllNBACuant <- NA
nbaFinalLM$isAllNBACuant[nbaFinalLM$isAllNBA==T] <- 1
nbaFinalLM$isAllNBACuant[nbaFinalLM$isAllNBA==F] <- 0


model = glm(isAllNBACuant ~ Points + Rebounds + Assists + Steals + Blocks + Minutes, data=nbaFinalLM, family=gaussian)
model = lm(isAllNBACuant ~ pointsCuant + Rebounds + Assists + Steals + Blocks + Minutes, data=nbaFinalLM)
model = lm(Minutes ~ Points + Rebounds + Assists + Turnovers*-1 + Fouls*-1 + FieldGoalPercentage*pointsCuant , data = nbaFinalLM)
summary(model)
plot(model)

# Make a column `model_preds` that hold the predictions from this model
nbaFinalLM$model_preds <- model$fitted.values

# Plot these predicted values against the actual values
ggplot(data = nbaFinalLM) +
  geom_point(mapping = aes(x = Minutes, y = model_preds)) + 
  labs(y="Predicted values", x="Real values") +
  geom_abline(slope=1)