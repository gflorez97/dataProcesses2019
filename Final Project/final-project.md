<h1 align="center">Final Project Data Processes 2019</h1>

## Students

- [Gonzalo Flórez Arias][gonzalo]
- [Antonio González Sanz][antonio]
- [Esaú García Sánchez-Torija][esau]
- [Adrián Rodríguez Socorro][adrian]
- [Rafael Inés Guillén][rafael]

[gonzalo]: https://github.com/gflorez97        "GitHub Profile — Gonzalo Flórez Arias"
[antonio]: https://github.com/antoniogonzalezs "GitHub Profile — Antonio González Sanz"
[esau]:    https://github.com/egasato          "GitHub Profile — Esaú García Sánchez-Torija"
[adrian]:  https://github.com/ars1096          "GitHub Profile — Adrián Rodríguez Socorro"
[rafael]:  https://github.com/RafaIG           "GitHub Profile — Rafael Inés Guillén"

## Abstract

This project aims to answer one of the most important questions in the world of NBA statistics: who are the best players at any given time?
To tackle this problem, we conducted a data driven examination, using a custom dataset based on the most important NBA statistics (points, rebounds, assists&hellip;).
With the objective of better understanding the data, we present some graphs.
Afterwards, we tried to assess the strength of relationships between the variety of features in our dataset, using a statistical approach.
Finally, we used a machine learning approach to try predicting whether a certain player could be selected as one of the best players in the league.

## Introduction and Related Work

### Introduction

Nowadays, stats are everywhere.
They cover most aspects of our life, ranging from rigorous industrial processes to mundane and trivial activities of our routine, enabling us to analyze any situation using numbers.
One of the topics in which they are widely used and considered very valuable is, of course, sports.
Especially in American sports, as it has been the norm for many years to gather any statistic that might be useful, hoping to extract knowledge from it.
The goal is being able to tell how the sports are evolving, which young players should be scouted, and predicting who is going to be the new Jordan, the new Brady or the new Trout.

The selected domain of interest for this project is basketball, and in particular, professional basketball in the United States of America, commonly known with the acronym NBA.
We have chosen this topic for numerous reasons: we believe it is an interesting domain&mdash;not only for us but for the general public&mdash;the amount of data is constantly increasing as everyday new games are played and more data is collected, and having the power of analyzing all the data properly is becoming an increasingly higher priority for professional teams.
On top of that, it is a sport we enjoy watching and we tend to be up-to-date with the different sources of NBA news, therefore we can compare the results of our analysis with our previous knowledge, helping us to better understand the unwritten rules behind this sport; similarly, this topic is explored in the film [Moneyball][moneyball].

We will try answering the following question: _**what makes a player be one of the top 10 best players in the NBA in a particular year?**_

To tackle this problem, we decided to focus in the [All-NBA][all-nba] selection.
This annual selection consists in a voting&mdash;conducted by sportswriters and broadcasters throughout the United States of America and Canada&mdash;in which the best players of the season are selected.
We used the first and second All-NBA team, that is, the top 10 best players in each year.
Regardless of the fact that some positions might have better players than others, we are mostly getting 3 to 4 guards, 4 to 5 forwards and 1 to 3 centers per year.

[moneyball]: https://en.wikipedia.org/wiki/Moneyball_(film) "Wikipedia — Moneyball (film)"
[all-nba]:   https://en.wikipedia.org/wiki/All-NBA_Team     "Wikipedia — All-NBA Team"

### Previous Work

- [Bhandari, Colet, Parker, Pines, Pratap, Ramanujam (1997). Advanced Scout: Data Mining and Knowledge Discovery in NBA Data. Data Mining and Knowledge Discovery, 1, pp.121–125.][advanced-scout]
- [Goldsberry (2012). CourtVision: New Visual and Spatial Analytics for the NBA. MIT Sloan Sports Analytics Conference][visual-spatial-analytics]
- [Mikołajec, Maszczyk, Zając (2013). Game Indicators Determining Sports Performance in the NBA. Journal of Human Kinetics, 37, 145-151][game-indicators]
- [Cervone, D’Amour, Bornn, Goldsberry (2014). POINTWISE: Predicting Points and Valuing Decisions in Real Time with NBA Optical Tracking Data. MIT Sloan Sports Analytics Conference][pointwise]
- [Wang, Zemel (2016). Classifying NBA Offensive Plays Using Neural Networks. MIT Sloan Sports Analytics Conference][classifying-nba]

[advanced-scout]:           https://www.cse.unr.edu/~sushil/class/ml/papers/local/nba.pdf                                                                  "Advanced Scout: Data Mining and Knowledge Discovery in NBA Data"
[visual-spatial-analytics]: http://www.sloansportsconference.com/wp-content/uploads/2012/02/Goldsberry_Sloan_Submission.pdf                                "CourtVision: New Visual and Spatial Analytics for the NBA"
[game-indicators]:          https://www.degruyter.com/downloadpdf/j/hukin.2013.37.issue-1/hukin-2013-0035/hukin-2013-0035.pdf                              "Game Indicators Determining Sports Performance in the NBA"
[pointwise]:                https://pdfs.semanticscholar.org/f4b3/81f4482586dbdd15fc92bee81ce68bcb6898.pdf                                                 "Predicting Points and Valuing Decisions in Real Time with NBA Optical Tracking Data"
[classifying-nba]:          http://www.sloansportsconference.com/wp-content/uploads/2016/02/1536-Classifying-NBA-Offensive-Plays-Using-Neural-Networks.pdf "Classifying NBA Offensive Plays Using Neural Networks"

## Exploratory Data Analysis

To answer the question of interest, we needed two things: the NBA seasons of the players (e.g. Jordan at age 21, Jordan at age 22 and so on) with their main statistics, and whether that season resulted in a first or second All-NBA selection for that player.
When we started this project, we proposed using a [Kaggle dataset][kaggle].
It contains the stats we needed, but it does not contain any feature that allows us to know whether a given player had an All-NBA selection.
Then, we used the R package [`nbaStatR`][nbastatr] to gather&mdash;from the [NBA API][nba-api]&mdash;a dataset with every player who was selected in any All-NBA team.
This was enough to generate the final dataset that we needed.

The generation was not a straightforward process, as it required data wrangling.
We filtered the All-NBA selections with players either in the first or second All-NBA; pre-processing the datasets was necessary to join both datasets.
The goal was to obtain a new variable named `isAllNBA`, which is the categorical variable on which we based our analysis.
We selected the relevant columns, transforming some of them throughout the process, because we wanted stats to be applied per game and not per season.
To conclude, we omitted the rows that contained `NA` values.
The reason some stats were not tracked is because, until a certain date, nobody thought they would be useful to create insightful analyses, and as a result some of the stats used were not collected until 1978.
This was the only reasonable explanation we found, because the source of all these stats was manual in-game annotations, dating back to 1950, so statistics that were not tracked back then, e.g. the number of blocks, cannot be accurately inferred now.

Our [final dataset][dataset] ([raw][dataset-raw]), consists of 19,554 observations with 14 variables.
A brief description of the variables is found below:
- **X**: a nominal variable for each row.
- **isAllNBA**: whether that player in that season was a first or second All-NBA.
- **Year**: the year of the season.
- **Player**: the name of the player.
- **Position**: the position played during that year by that player.
- **Rebounds**: rebounds per game of the player (adjusted to integer numbers)
- **Assists**: assists per game of the player (adjusted to integer numbers)
- **Blocks**: blocks per game of the player (adjusted to integer numbers)
- **Steals**: steals per game of the player (adjusted to integer numbers)
- **Points**: points per game of the player (adjusted to integer numbers)
- **Turnovers**: turnovers per game of the player (adjusted to integer numbers)
- **FieldGoalPercentage**: ratio of made shots by total shots (adjusted to `[0, 1]`)
- **Minutes**: minutes played per game of the player (adjusted to integer numbers)
- **Fouls**: fouls committed per game of the player (adjusted to integer numbers)

We present below 5 graphics to illustrate our dataset:

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph1.png" alt="Figure 1: Histograms of features">
	<figcaption>Figure 1: Histograms of features</figcaption>
</figure>

These histograms represent, at first sight, how the features are distributed.
It is noticeable that `Points`, `Rebounds`, `Assists`, `Blocks`, `Steals` and `Turnovers` are left-skewed distributions, as most players are in the lower-end of all those stats and just the best players in each area outstand peak with the highest values (with the exception of `Turnovers`, which is a negative stat).
The `FieldGoalPercentage` seems to follow a normal distribution with a mean of **0.44** and has some obvious outliers in `0` and `1`&mdash;in most cases, these outliers are probably associated with players that played just a few minutes in a season, and just shot a few times and either scored or failed those shots).
The `Fouls` feature is quite left-skewed, because most players commit between 1 and 2 fouls per game, whereas the `Minutes` feature is distributed more evenly, because the overall amount of key players, role players and occasional players in the league is approximately the same.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph2.png" alt="Figure 2: 'Points' by 'FieldGoalPercentage', colored by 'Minutes'">
	<figcaption>Figure 2: <code>Points</code> by <code>FieldGoalPercentage</code>, colored by <code>Minutes</code></figcaption>
</figure>

We suspected that the players who play more minutes usually score more.
This plot confirms it and shows that the `FieldGoalPercentage` tends to the mean when players play a considerable amount of minutes: for players with less than 20 minutes per game (role players or occasional players), the percentage has a higher standard deviation, **0.12** to be precise, than for players with more than 20 minutes per game (**0.05**).

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph3.png" alt="Figure 3.1: Missing values in the original dataset">
	<figcaption>Figure 3.1: Missing values in the original dataset</figcaption>
</figure>

In this graph we obtain the percentage of values which are not available in the original dataset (the one dating back to 1950).
The position of the player or whether he was an All-NBA is something that has been collected since then.
However, some game stats, like blocks or turnovers, were not computed until recently, hence the impossibility  to use the whole dataset.
The undeniable setback is that because we use the `Turnovers` stats, we omit 20% of the players in the history of NBA.
But given how rapidly evolve sports&mdash;it is enough to watch a video from a gold medalist of the 1956 Olympics to notice the performance difference&mdash;we believe that omitting this amount of observations is not a big deal, all things considered.
As we already stated, the first valid observation in our study dates back to 1978.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph3_2.png" alt="Figure 3.2: Number of missing variables per 'Year'">
	<figcaption>Figure 3.2: Number of missing variables per <code>Year</code></figcaption>
</figure>

In this case, we can observe the years in which the last variables started to appear.
Until the 70's, the last two features were still not present.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph4.png" alt="Figure 4: Violin plot of the main features">
	<figcaption>Figure 4: Violin plot of the main features</figcaption>
</figure>

We decided to generate a violin plot of what we consider the 4 most important features: `Points`, `Rebounds`, `Assists` and `Minutes`.
This type of plot is really helpful to distinguish the distribution of the aforementioned features based on the categorical variable `isAllNBA`.
When it comes to `Points`, we can observe most players lie in the interval `[15, 30]`.
There are some outliers with more than 30&mdash;these are the all-time great scorers like Michael Jordan or Kobe Bryant&mdash;and a few players with less than 15&mdash;these are, in most cases, great defensive players like Ben Wallace&mdash;with higher numbers for rebounds, blocks and steals.
The `Rebounds` and `Assists` plots are more interesting, as it is not that clear what the difference is.
In fact, there are more All-NBA players in the lower zone for assists than in the upper one, although non All-NBA players tend to have a small number of assists.
Finally, it is clear that although the play time of non-All-NBA players is distributed evenly, that is not the case for most of the All-NBA players, where play time is over 30 minutes per game.

Based on these facts, we suppose the better they are, the more they play, which results in more opportunities to improve their statistics.
This is taken into account positively when selecting whether he is All-NBA or not.
Of course, as there are many more non-All-NBA than All-NBA, this does not mean that if a player plays more it is more likely to be All-NBA: from the 158 players with 40 or more minutes per game, only 49 (about one third of them) were selected to the All-NBA first or second team.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph5.png" alt="Figure 5: Density plot of the minutes">
	<figcaption>Figure 5: Density plot of the minutes</figcaption>
</figure>

Finally, we present a density plot of the minutes per game, to further insist in the fact that All-NBA players play more minutes than non-All-NBA players, on average.
Again, this does not mean, as we already stated, that there are more All-NBA players playing lots of minutes than non-All-NBA.
It just means that players with less than 30 minutes of play time have lower probabilities of being selected to the All-NBA.

[kaggle]:      https://www.kaggle.com/drgilermo/nba-players-stats                                                       "Kaggle — NBA Player Stats Since 1950"
[nbastatr]:    https://github.com/abresler/nbastatR                                                                     "GitHub — abresler/nbastatR — NBA Stats API Wrapper and more for R"
[nba-api]:     https://stats.nba.com                                                                                    "NBA API"
[dataset]:     https://github.com/gflorez97/dataProcesses2019/blob/master/Final%20Project/data/nbaFinal.csv             "GitHub — gflorez97/dataProcesses2019 — Data Processes Project — NBA Dataset"
[dataset-raw]: https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/data/nbaFinal.csv   "GitHub — gflorez97/dataProcesses2019 — Data Processes Project — NBA Dataset (RAW)"
[figure-1]:    https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph1.png   "Figure 1: Histograms of features"
[figure-2]:    https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph2.png   "Figure 2: 'Points' by 'FieldGoalPercentage', colored by 'Minutes'"
[figure-3-1]:  https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph3.png   "Figure 3.1: Missing values in the original dataset"
[figure-3-2]:  https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph3_2.png "Figure 3.2: Number of missing variables per 'Year'"
[figure-4]:    https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph4.png   "Figure 4: Violin plot of the main features"
[figure-5]:    https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph5.png   "Figure 5: Density plot of the minutes"

## Methods

### Strength of Relationships

We tried to create a linear model, using the function ```lm```, to assessing the strength of relationships in our dataset related to whether a player is one of the top 10 best of a year.
Using the next formula, we wanted to obtain the model that maximized the R<sup>2</sup> value, as it is a metric of the strength of our model in describing the features.
After finding such model, we can study the significance of each of the features in it, to discover which ones are the most important for our variable of interest.

```r
model <- lm(isAllNBACuant ~ FEATURES, data = nbaFinalLM)
```

We tried several ways, but could not obtain a high R<sup>2</sup> value, even when including all the features, squared versions of the features we considered most important (e.g. `Minutes` and `Points`), or by transforming continuous features into 3 categorical values:

```r
nbaFinalLM$minutesCuant <- NA
nbaFinalLM$minutesCuant[nbaFinalLM$Minutes <= 15] <- "LOW"
nbaFinalLM$minutesCuant[ 15 < nbaFinalLM$Minutes & nbaFinalLM$Minutes <= 30] <- "MEDIUM"
nbaFinalLM$minutesCuant[nbaFinalLM$Minutes > 30] <- "HIGH"
```

More information is given in the next section as well as the explanation of why we decided to change the way we are assessing the strength of relationships.

### Prediction

The main idea is to predict whether a player in a given season is one of the top 10 best in the league, using our features.
This is a classification problem where there are only two output classes (`TRUE` and `FALSE`).
We will use the pre-processed dataset without modifications, as we already handled the missing values in previous sections.

First, we treat our `isAllNBA` variable as a factor&mdash;this will be the only categorical variable we will be using&mdash;and create a data partition to split the data into testing and training data.
We decided to use 80% of the observations for training and 20% for test, which is a reasonable partition size given our dataset size.

```r
nbaFinal$isAllNBA <- factor(nbaFinal$isAllNBA)
trainIndex <- createDataPartition(nbaFinal$isAllNBA, p = .8, list = FALSE, times = 1)
training_set <- nbaFinal[trainIndex, ]
test_set <- nbaFinal[-trainIndex, ]
```

Once the training and test sets are defined, the next step is to prepare the train function, that is to say, configure some of the parameters for the actual training process.
Because we will use the function `train` from the package `caret`, this is done with the function `trainControl` from the very same package.
We need to declare that we will use cross-validation (with 10 folds) during the training process:

```r
fitControl <- trainControl(
	method = "cv",
	number = 10,
	savePredictions = TRUE
)
```

A grid parameter is also used for each technique to optimize the parameters each machine learning technique uses.
For example, for the K-nearest neighbors we need to find the optimal value for `k`, so we will do the following to try different values:

```r
grid <- expand.grid(k = 1:20)
```

The model used in this section uses the following features described as a formula in R:

```r
isAllNBA ~ Points + Rebounds + Assists + Blocks + Steals + Minutes
```

In the next subsections, we present the algorithms that we have consider for this machine learning procedure.

#### K-Nearest Neighbors

The K-nearest neighbors algorithm is one of the most used machine learning techniques for classification.
The parameter to optimize is `k`, as the name of the algorithm implies.
It defines the number of nearest neighbors (to the data to predict) to be selected in order to try estimating the class of the data.

#### Decision Tree

The idea now is to apply a decision tree algorithm to visually appreciate how this algorithm discerns between the best players and the others.
In the result section we present a visualization of that tree and interpret it along with the prediction results.

#### Random Forest

Last but not least, we expanded the decision tree algorithm and use a random forest.
However, due to the high number of elements in our dataset, we could not train a big model unless we decreased the input to a subset of the dataset.
This limitation resulted in prediction results way worse than we expected, as it will be presented in the following section.

## Results

### Strength of Relationships

Here we present an example of a model summary using `isAllNBA` as the outcome of interest:

```r
Call:
lm(formula = isAllNBACuant ~ pointsCuant + Rebounds + Assists +
    Steals + Blocks + Minutes, data = nbaFinalLM)

Residuals:
     Min       1Q   Median       3Q      Max
-0.51455 -0.01777 -0.00043  0.01236  1.00735

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)        0.3503253  0.0063034  55.578  < 2e-16 ***
pointsCuantLOW    -0.3379426  0.0052482 -64.392  < 2e-16 ***
pointsCuantMEDIUM -0.3325302  0.0047105 -70.594  < 2e-16 ***
Rebounds           0.0127910  0.0005744  22.269  < 2e-16 ***
Assists            0.0211510  0.0007332  28.847  < 2e-16 ***
Steals             0.0097843  0.0023665   4.134 3.57e-05 ***
Blocks             0.0278016  0.0023220  11.973  < 2e-16 ***
Minutes           -0.0041232  0.0001909 -21.599  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1175 on 19546 degrees of freedom
Multiple R-squared:  0.3117,	Adjusted R-squared:  0.3114
F-statistic:  1264 on 7 and 19546 DF,  p-value: < 2.2e-16
```

As it can be appreciated, the Adjusted R<sup>2</sup> value is low (we estimate a decent value would be around **0.7**).
The R<sup>2</sup> indicates the percentage of the variance in the dependent variable explained by the independent variables.
This way it is clear that this model does not explain well the variable `isAllNBA`.
Therefore, we cannot make a correct analysis of the coefficients to see which variables are more important.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/residualPlotBadModel.png" alt="Figure 6: Residual analysis of the bad model">
	<figcaption>Figure 6: Residual analysis of the bad model</figcaption>
</figure>

Analyzing the residuals we obtain the same conclusion: this model does not fit well.
We also tried using the `glm` function from R to create a more complex model, using both binomial and poisson distributions, but neither of those solutions improved our results.

We conclude, then, that this problem is not a linear problem, so trying to use linear regression to predict whether a NBA player is one of the best of each year is not a good idea, as it is virtually impossible to fit well using a linear approach.
We believe that due to the All-NBA selection being subjective and not relying directly and solely on statistics, some players who had merits to be included (just by their stats) were not included.
Of course, the other way around also happened, therefore some players with worse numbers got included&mdash;maybe because of intangibles, basketball IQ or defense capabilities, which are harder to measure.

As we still wanted to prove our hypothesis regarding the strength of relationships between our features, we decided to change and create a model using the `Minutes` feature as the outcome.
To do so, we made the initial assumption that players that play more play better and make more numbers, and that those with good numbers start playing more.
Taking that into account, and after studying which features could help us, we created the next model:

```r
Call:
lm(formula = Minutes ~ Points + Rebounds + Assists + Turnovers *
    -1 + Fouls * -1 + FieldGoalPercentage * pointsCuant, data = nbaFinalLM)

Residuals:
     Min       1Q   Median       3Q      Max
-23.8765  -2.0058  -0.2315   1.8584  14.2333

Coefficients:
                                       Estimate Std. Error t value Pr(>|t|)    
Points                                  1.25393    0.01026 122.251  < 2e-16 ***
Rebounds                                1.00716    0.01369  73.576  < 2e-16 ***
Assists                                 1.38186    0.01845  74.916  < 2e-16 ***
Turnovers                              -0.89549    0.04950 -18.092  < 2e-16 ***
Fouls                                   1.54654    0.03531  43.793  < 2e-16 ***
FieldGoalPercentage                   -40.16364    2.61708 -15.347  < 2e-16 ***
pointsCuantHIGH                        13.56846    1.28385  10.569  < 2e-16 ***
pointsCuantLOW                          5.41802    0.10700  50.636  < 2e-16 ***
pointsCuantMEDIUM                      15.97931    0.48770  32.764  < 2e-16 ***
FieldGoalPercentage:pointsCuantLOW     37.39795    2.62250  14.260  < 2e-16 ***
FieldGoalPercentage:pointsCuantMEDIUM  11.03847    2.77499   3.978 6.98e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.071 on 19543 degrees of freedom
Multiple R-squared:  0.9806,	Adjusted R-squared:  0.9806
F-statistic: 8.998e+04 on 11 and 19543 DF,  p-value: < 2.2e-16
```

The results are way better than in the previous model.
We included `Points`, `Rebounds`, `Assists`, a negative version of `Fouls` and `Turnovers`&mdash;even though playing more time probably means more chances to make turnovers, we consider it something bad per se, hence we include it as negative&mdash;and `FieldGoalPercentage` multiplied by the categorical version of points (either `LOW`, `MEDIUM` or `HIGH`).
The R<sup>2</sup> is now almost **1**, so we can start confidently interpreting how our features play a role in the amount of minutes played.

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/residualPlotGoodModel.png" alt="Figure 7: Residual analysis of the good model">
	<figcaption>Figure 7: Residual analysis of the good model</figcaption>
</figure>

But first, we wanted to compare the residual plot we made earlier with this new one.
Even though not being perfect, it is clearly more linear than the previous one.
Interestingly, two of the three left-side outliers correspond to the seasons of Russell Westbrook from 2015 and 2017, an all-around star player with great stats and many minutes, but clearly a player that is not perfectly fitted in our model.

All of the coefficients have a really low p-value, which means it is unlikely that we are observing a relationship between `Minutes` and each other variable due to chance.
All the standard errors are pretty low too, which means the estimate variance is low.
The t-values can give us some hints about whether there is really a relationship: it does exist if those values are distant from 0.
It is the case for all of them, except maybe for `FieldGoalPercentage` multiplied by the `MEDIUM` category of points.
Maybe that percentage varies more for that category specifically, and so a proper relationship is not easily generated with respect to the number of minutes.
To conclude, we wanted to study the F-statistic: the further it is from 0, the most probable it is to indicate a relationship between `Minutes` and the other variables.
As we can see the number is really big, so there's no room for other interpretation.

Let's observe now how are the predicted values compared to the real values of `Minutes`:

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/predictedVSreal.png" alt="Figure 8: Predicted values vs. Real values">
	<figcaption>Figure 8: Predicted values vs. Real values</figcaption>
</figure>

We obtain good results, indicating this model is objectively good to assess the number of minutes.

[figure-6]: https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/residualPlotBadModel.png  "Figure 6: Residual analysis of the bad model"
[figure-7]: https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/residualPlotGoodModel.png "Figure 7: Residual analysis of the good model"
[figure-8]: https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/predictedVSreal.png       "Figure 8: Predicted values vs. Real values"

### Prediction

After presenting the trained models to the test set to predict, we obtained the results explained in each subsection.

#### K-Nearest Neighbors

We compute the confusion matrix and generate some basic statistics to better analyze the results.

```r
Confusion Matrix and Statistics

          Reference
Prediction FALSE TRUE
     FALSE  3812   18
     TRUE     35   45

               Accuracy : 0.9864          
                 95% CI : (0.9823, 0.9898)
    No Information Rate : 0.9839          
    P-Value [Acc > NIR] : 0.11172         

                  Kappa : 0.6226          

 Mcnemars Test P-Value : 0.02797         

            Sensitivity : 0.9909          
            Specificity : 0.7143          
         Pos Pred Value : 0.9953          
         Neg Pred Value : 0.5625          
             Prevalence : 0.9839          
         Detection Rate : 0.9749          
   Detection Prevalence : 0.9795          
      Balanced Accuracy : 0.8526  
```

In this case, as this is a classification problem, we are mostly looking at the accuracy (or the confidence intervals), the sensitivity and the specificity.
The accuracy is really good: 3,857 out of 3,910 players were correctly predicted, and most of the errors were All-NBA players predicted as not All-NBA players.
This is understandable, as there are way more `FALSE` than `TRUE`, the model tends to select more `FALSE`.
Sensitivity, in this case, refers to the number of predicted `FALSE` players divided by the total real number of `FALSE` players: it states how well our model predict a player is not an All-NBA, taking into account all the players that really are All-NBA.
On the other hand, the specificity refers to the number of predicted `TRUE` players, divided by the correct total of `TRUE` players.
This number is smaller, which means some `TRUE` players were predicted as `FALSE`.
This is also understandable, as there are less training cases of `TRUE` players, the model fails sometimes to detect a player as `TRUE`.

Let's see the evolution of the parameter `k`, which was tuned using a grid search:

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/kEvolution.png" alt="Figure 8: Predicted values vs. Real values">
	<figcaption>Figure 9: <code>k</code> parameter evolution</figcaption>
</figure>

The best accuracy is obtained with `k = 9`, but the difference is really small compared to other values.
It seems clear 1 and 2 are not the best values in this case, but others result in similar outputs.

[figure-9]: https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/kEvolution.png "Figure 9: 'k' parameter evolution"

#### Decision Tree

In this case, along with the prediction, we wanted to obtain a visual of a tree to illustrate the strength of this model, and how it discretizes between the two possible output classes.
We obtained the following tree:

<figure>
	<img src="https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/predictionTree.png" alt="Figure 10: Decision Tree">
	<figcaption>Figure 10: Decision Tree</figcaption>
</figure>

This gives us some key clues about our data.
The first discriminant feature is `Points`: if a player scored more than 23, he is more likely to be an All-NBA&mdash;the more blue, the more likely to select `TRUE`, and the more red, the more likely to select `FALSE`&mdash;and if he scored more than 27, even more; finally, it will be considered `TRUE` if there were more than 5 rebounds.

If we take another path, the reasoning changes.
For players with less than 23 points, assist number is heavily weighted: if they have less than 10 (that is, non-scorer players who are not either great passers) they are more probably not an All-NBA.
But, if they are good passers, the decision divides between more or less than 14 points: the tree shows that less than 14 points is a really low number, even for a non-mainly scorer (like a play-making point guard), therefore he is probably not an All-NBA.

```r
Confusion Matrix and Statistics

          Reference
Prediction FALSE TRUE
     FALSE  3813   17
     TRUE     38   42

               Accuracy : 0.9859          
                 95% CI : (0.9817, 0.9894)
    No Information Rate : 0.9849          
    P-Value [Acc > NIR] : 0.329154        

                  Kappa : 0.5973          

 Mcnemars Test P-Value : 0.007001        

            Sensitivity : 0.9901          
            Specificity : 0.7119          
         Pos Pred Value : 0.9956          
         Neg Pred Value : 0.5250          
             Prevalence : 0.9849          
         Detection Rate : 0.9752          
   Detection Prevalence : 0.9795          
      Balanced Accuracy : 0.8510
```

There are no major changes between this and the k-nearest neighbor, neither in the accuracy nor in the sensitivity or specificity.

#### Random forest

In this case, the model is not able to correctly adjust to what we want.

```r
Confusion Matrix and Statistics

          Reference
Prediction FALSE  TRUE
     FALSE 18962     0
     TRUE    396     0

               Accuracy : 0.9795          
                 95% CI : (0.9774, 0.9815)
    No Information Rate : 1               
    P-Value [Acc > NIR] : 1               

                  Kappa : 0               

 Mcnemars Test P-Value : <2e-16          

            Sensitivity : 0.9795          
            Specificity :     NA          
         Pos Pred Value :     NA          
         Neg Pred Value :     NA          
             Prevalence : 1.0000          
         Detection Rate : 0.9795          
   Detection Prevalence : 0.9795          
      Balanced Accuracy :     NA          
```

Why, if the accuracy is still high?
Because now every value is assigned to `FALSE`.
Due to that, the majority the data is correctly classified, as there are way more `FALSE` than `TRUE`, but this only assumes that any player is not an All-NBA, which is a dull prediction.
We guess this happens because of the reduced training set, or because this algorithm cannot fit well our model with the parameters selected (we used the `cforest` method from the package `caret`).

## Discussion and Future Work

Based on the results presented in the strength of relationships and prediction sections, we can estimate this analysis would be useful in drafting and trading NBA players between teams.
NBA teams could even use our models in the case of injured players that need a substitute.
Taking into consideration the accuracy obtained in our models, especially in the prediction section, we can definitely conclude whether a certain player would be one of the best 10 players in the league.
Despite all those implications, we were unable to find a good model for the strength of relationships section.

We tried to think about suggestions for future research, and we believe including subjective features, such as nationality, popularity (e.g. number of followers in social media accounts), participation in All-Star events (dunk contest, three-point contest, skill challenge), and so on.
We can also extrapolate our models to other sports, changing the features with the main statistics of those sports, to analyze the best players.
