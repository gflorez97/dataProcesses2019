# dataProcesses2019

# Students
- Gonzalo Flórez Arias
- Antonio González Sanz
- Esaú García Sánchez-Torija
- Adrián Rodríguez Socorro
- Rafael Inés Guillén

# Abstract
- Succinctly summarizes the importance and findings of the project within the 150 word limit.

...

# Introduction and Related Work
- Provides a clear motivation for answering a _specific_ data driven question of interest (**5 points**)
  
## Introduction
Nowadays, stats are everywhere. They cover most aspects of life, enabling us to analyze any situation with just some numbers. They are also, of course, in sports. Specially in american sports, as it has been the norm for many years to gather any statistic that might be useful, hoping to obtain knowledge from it and being able to say how is each sport evolving and which young players should be scouted in order to try to predict who is going to be the new Jordan, the new Brady or the new Trout.

The selected domain of interest for this project is basketball, and in particular, professional basketball in the United States (the NBA). We have choosen this topic for different reasons: one of them is because nowadays we see it as an interesting domain,besides as more and more data is available daily as games are played, and being able to analyze all that data properly is starting to become a priority for professional teams. Also, it's a sport that we usually watch and like being updated about the different nba news, furthermore thus we can compare the results of our analysis to our previous knowledge and this will help us to understand better the keys to know more about what is hidden behind this sport. (It will be something similar to the film "Moneyball").

We are, particularly, going to try to answer the following question: _**what makes a player be one of the 10 best players in the NBA in a particular year?**_

For this, we have decided to focus in the All NBA selection. This annual selection consists in a voting, conducted by sportswriters and broadcasters throughout the United States and Canada, in which the best players of the season are selected. We are using the first and second all nba team, that is, the 10 best players in each year (regardless of the fact some positions might have better players than others, we are mostly getting 3-4 guards, 4-5 forwards and 1-3 centers per year).


- Cites 5 _relevant_ pieces of relevant work (whatever format you choose is fine, including just a hyperlink) (**1 point each**)
## Previous works: 
- [Bhandari, Colet, Parker, Pines, Pratap, Ramanujam (1997). Advanced Scout: Data Mining and Knowledge Discovery in NBA Data. Data Mining and Knowledge Discovery, 1, pp.121–125.](https://www.cse.unr.edu/~sushil/class/ml/papers/local/nba.pdf)
- [Goldsberry (2012). CourtVision: New Visual and Spatial Analytics for the NBA. MIT Sloan Sports Analytics Conference](http://www.sloansportsconference.com/wp-content/uploads/2012/02/Goldsberry_Sloan_Submission.pdf)
- [Mikołajec, Maszczyk, Zając (2013). Game Indicators Determining Sports Performance in the NBA. Journal of Human Kinetics, 37, 145-151](https://www.degruyter.com/downloadpdf/j/hukin.2013.37.issue-1/hukin-2013-0035/hukin-2013-0035.pdf)
- [Cervone, D’Amour, Bornn, Goldsberry (2014). POINTWISE: Predicting Points and Valuing Decisions in Real Time with NBA Optical Tracking Data. MIT Sloan Sports Analytics Conference](https://pdfs.semanticscholar.org/f4b3/81f4482586dbdd15fc92bee81ce68bcb6898.pdf)
- [Wang, Zemel (2016). Classifying NBA Offensive Plays Using Neural Networks. MIT Sloan Sports Analytics Conference](http://www.sloansportsconference.com/wp-content/uploads/2016/02/1536-Classifying-NBA-Offensive-Plays-Using-Neural-Networks.pdf)


# Exploratory Data Analysis
- Introduces the dataset by describing the origin (source) and structure (shape, relevant features) of the data being used (**5 points**)

For answering the question of interest, we needed two things: every NBA season for each player (Jordan at age 21, Jordan at age 22, Jordan at age 23...) with his main statistics, and whether that season resulted in a first or second all nba selection for that player. When starting this project, we proposed using a [Kaggle dataset](https://www.kaggle.com/drgilermo/nba-players-stats) that contained the stats we needed for every player, but it didn't contain any feature to know if that player had an all nba selection. Then, we used the R package [nbaStatR](https://github.com/abresler/nbastatR) to gather, from the [NBA API](https://stats.nba.com), a dataset with every player who was selected in any all nba team.

After that, we used R to generate the final dataset we wanted. For this, we filtered the all nba selections with just players in either first or second all nba; we joined both datasets, after a bit of pre-processing, to obtain in the statistics dataset a new variable, isAllNBA, which will be the categorical variable on which we will base our analysis; we took only the columns we wanted, adapting some of the from the original because we wanted stats to be applied per game, and not per season. Finally, we wanted to just omit every NA value, as some of the stats used weren't collected until 1978. The source of all these stats are manual in-game annotations, dating back to 1950, and so statistics that were not tracked then, as the number of blocks, can't be tracked now.

Our final dataset, that can be viewed PONER LINK, consists of 19554 observations of 14 variables, which are:
- **X**: just a nominal variable for each row.
- **isAllNBA**: TRUE if that player in that season was a first or second all nba.
- **Year**: the year of the season.
- **Player**: the name of the player.
- **Position**: the position played during that year by that player.
- **Rebounds**: rebounds per game of that player (adjusted to integer numbers)
- **Assists**: assists per game of that player (adjusted to integer numbers)
- **Blocks**: blocks per game of that player (adjusted to integer numbers)
- **Steals**: steals per game of that player (adjusted to integer numbers)
- **Points**: points per game of that player (adjusted to integer numbers)
- **Turnovers**: turnovers per game of that player (adjusted to integer numbers)
- **FieldGoalPercentage**: ratio of made shots by total shots (adjusted to [0,1])
- **Minutes**: minutes played per game of that player (adjusted to integer numbers)
- **Fouls**: fouls commited per game of that player (adjusted to integer numbers)
   


- Creates 5 well designed and formatted graphics (**15 points**, 3 each)
  - The visual uses the appropriate visual encodings based on the data type (**1 point**)
  - Written interpretation of graphic is provided (**1 point**)
  - Clear axis labels, titles, and legends are included, where appropriate (**1 point**)


We present below 5 graphics to illustrate our dataset:


![Graph 1: Histograms of features](https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph1.png "Graph 1: Histograms of features")

These histograms represent, at a glance, how our features are distributed. We can see Points, Rebounds, Assists, Blocks, Steals and Turnovers are left-skewed distributions, as most players are in the lower-end of all those stats, and just the best players in each area (except for Turnovers, which is a negative stat) peak with the greater values. The Field Goal Percentage seems to follow a normal distribution, with a mean of **0.44**, and some obvious outliers in 0 and 1 (in most cases, asociated with players that played just a few minutes in a season, and probably shot just 1 or 2 times and either scored or failed those shots). The Fouls feature tells us most players commit 1 or 2 fouls per game, and the Minutes feature is more evenly distributed, as there are more or less the same number of key players as role players and occasional players in the league.


![Graph 2: Points by FieldGoalPercentage, colored by Minutes](https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph2.png "Graph 2: Points by FieldGoalPercentage, colored by Minutes")

We already supposed the players that played more minutes usually scored more. This plot confirms this, while also telling us that Field Goal Percentage tends to the mean when players play lots of minutes: for players with less than 20 minutes per game (role players or occasional players), the percentage has a higher standard deviation (**0.12**),  than for players with more than 20 minutes per game (**0.05**).


![Graph 3: Missing values in the original dataset](https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph3.png "Graph 3: Missing values in the original dataset")

In this graph we obtain the percentage of values which are not available in the original dataset (the one dating back from 1950). As we can see, the position of the player or if he was an all nba is something that has been collected since them, but some game stats, like blocks or turnovers, where not computed until recent years, and thus should not be valid if we used the whole dataset. In the worst case, Turnovers, we are losing a 20% of the total number of players in the history of NBA, which doesn't sound too bad, all things considered. As we already stated, the first year we consider in our cleaned dataset is 1978.


![Graph 4: Violin plot of the main features](https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph4.png "Graph 4: Violin plot of the main features")

We decided to show a violin plot for 4 of the most important features (in our opinion, we'll ensure that in the next section): Points, Rebounds, Assists and Minutes. This type of plot is really useful to distinguish between our categorical variable, showing us the distribution of each variable depending on if the isAllNBA variable is TRUE or FALSE. For Points, we can observe most players lie between the 15 and 30 zone, with some outliers of players with more than 30 (all time great scorers like Michael Jordan or Kobe Bryant), and a few players with less than 15 (in most cases, great defensive players like Ben Wallace, with higher numbers for rebounds, blocks and steals). The Rebounds and Assists plots are more interesting, as it is not that clear that there is a real difference. In fact, there are more all nba players in the lower zone for assists than in the upper one, although non all nba players tend to have a small number of assists. Finally, it is clear that, while for non all nba players the minutes plot is more or less evenly distributed, most all nba play more than 30 minutes per game. From that we can suppose they play more because they are better, and playing more let them get better statistics. That is finally computed positively when being selected to the All NBA. Of course, as there are many more non All NBA than All NBA, this doesn't mean if a player plays more it is more likely he is an All NBA: from the 158 players with 40 or more minutes per game, only 49 (about one third of them) were selected to the All NBA first or second team.


![Graph 5: Density plot of the minutes](https://raw.githubusercontent.com/gflorez97/dataProcesses2019/master/Final%20Project/images/graph5.png "Graph 5: Density plot of the minutes")

Finally, we present a density plot of the minutes per game, to further insist in the fact than all NBA players play more minutes than non all NBA players, on average. This doesn't mean, as we already stated, that there are more all nba players playing lots of minutes than non all nba, it's just that players with less than 30 minutes are very less likely to be selected to the all nba. 
  

# Methods

The appropriate methods are employed to answer the question of interest, including:
- **Strength of relationships**: Uses the appropriate technique to assess the strength of relationships amongst your variables of interest. You should include: 
  - A formula describing how you believe your features (independent variables) are related to your outcome of interest (dependent variable) (**5 points**)
  - A defense of the variables included in your formula (**5 points**)
  - Creating the appropriate model based on your dataset (**5 points**)
- **Prediction**: You must also make predictions for your outcome of interest. In doing so, you must demonstrate a clear use of:
  - Splitting your data into testing/training data (**2 points**)
  - Applying cross validation to your model (**3 points**)
  - Appropriately handling any missing values (**2 points**)
  - Appropriately using categorical variables (**3 points**)
  - Using a grid search to find the best parameters for you model of interest (**2 points**)
  - Employing the algorithm of interest (**3 points**)

## Strength of relationships

...

## Prediction

The idea now is to be able to predict if a player season is one of the 10 best in the league, using our features. This is a classification problem, in which there are two classes (TRUE and FALSE). We will directly use the cleaned dataset without modifications, as we already handled missing values in previous sections.

First, we treat our isAllNBA variable as a factor (this is going to be the only categorical variable we are using), and create a data partition to split our data into testing and training data. We decided to use 80% for training and 20% for test, which is a reasonable partition for our dataset size.
```{r}
nbaFinal$isAllNBA <- factor(nbaFinal$isAllNBA)

trainIndex <- createDataPartition(nbaFinal$isAllNBA,
                                  p = .8,
                                  list = FALSE,
                                  times = 1)

training_set <- nbaFinal[ trainIndex, ]
test_set <- nbaFinal[ -trainIndex, ]
```

Now that we have our training and test set, we prepare our train function (we will use the train function from the caret package). For this, we need to declare that we are using cross validation (with 10 folds) for training:
```{r}
fitControl <- trainControl(
  method = "cv",
  number = 10,
  savePredictions = TRUE
)
```

A grid parameter is also used used for each technique, in order to optimize the parameters each machine learning technique uses. For example, for the K-nearest neighbors:
```{r}
grid <- expand.grid(k = 1:20)
```

Moving forward, we present the algorithms we have used for this machine learning section:

### K-nearest neighbors

...

### Decision tree
The idea now was to apply a decision tree algorithm to be able to visually get a glance at how this algorithm discriminate between the best players and the rest. In the result section we present a visualization of that tree, and try to interpret it, along with the prediction results.

### 
...


# Results
You must provide a clear interpretation of your statistical and machine learning results, including at least **one visual or table** for each.
- **Strengths of relationships**: For the features you included in your model, you must describe the strength (significance) and magnitude of the relationships. This can be presented in a table or chart, and pertinent observations should be described in the text. (**10 points**)
- **Predictions**: How well were you able to predict values in the dataset? You should both report appropriate metrics based on the type of outcome you're predicting (e.g., root mean squared error v.s. accuracy), as well as a high quality visual showing the strength of your model (**10 points**)

## Strength of relationships

...

## Prediction

### K-nearest neighbors

...

### Decision tree
...

### 
...

# Discussion and Future Work
Based on _specific observations_ from the results section, the report clearly provides:
  - An analysis of the real world implications of the results, at least one full paragraph (**5 points**)
  - Clear suggestion for directions of future research, at least one full paragraph (**5 points**)

...




# PROJECT PROPOSAL (para reusar)

# Domain of interest
The selected domain of interest for this project is basketball, and in particular, professional basketball in the United States (the NBA).
We have choosen this topic for different reasons, one of this it´s because nowadays we see it as an interesting domain, besides as more and more data is available daily as games are played, and being able to analyze all that data properly is starting to become a priority for professional teams.
Also, it's a sport that we usually watch and like being updated about the different nba news, furthermore thus we can compare the results of our analysis to our previous knowledge and this will help us to understand better the keys to know more about what is hidden behind this sport. (It will be something similar to the film "moneyball")

## Previous works
- [Paper from cse](https://www.cse.unr.edu/~sushil/class/ml/papers/local/nba.pdf): a relatively old (1996) paper describing how Data Mining and Knowledge Discovery can be applied to NBA data.
- [Paper from sloan sport conference](http://www.sloansportsconference.com/wp-content/uploads/2012/02/Goldsberry_Sloan_Submission.pdf): this paper includes a case study in which the author studies is who the best shooter in the NBA using game data from 2006 to 2011.
- [Paper from degruyter](https://www.degruyter.com/downloadpdf/j/hukin.2013.37.issue-1/hukin-2013-0035/hukin-2013-0035.pdf): this paper describes a method for ranking NBA teams based on a number of factors.

## Data-driven questions
<ol>
	<li>Who is the most consistent three-point shooter in NBA history?</li>
	<li>Which are the most offensive and defensive teams on a yearly basis?
	Which of those teams repeated these strategics the most?
	Which of those teams were on a streak?</li>
	<li>How did the points-per-game statistic evolved throughout the years and how is it related to the rest of the stats (steals, rebounds, blocks, turnovers)?</li>
</ol>

# Finding Data
## NBA Stats API
- URL: [Stats NBA](https://stats.nba.com)
- Description: this API includes data from mostly every game played in NBA history.
We will be using the `nbastatR` package to access this API and get all the needed information for teams and players.
- Data size: immeasurable (multiple endpoints, with multiple types of queries).
- Questions to answer: 1, 2, 3

## Basketball reference
- URL: [Basketball reference](https://www.basketball-reference.com)
- Description: this website also includes data from mostly every game played in NBA history.
We will be using the `nbastatR` package to wrap the data from this website and get all the needed information for teams and players, specially the information not available from the NBA Stats API directly (missing values, advanced statistics only available in this web...).
- Data size: immeasurable (multiple endpoints, with multiple types of queries).
- Questions to answer: 1, 2, 3

## NBA Players stats since 1950 (Kaggle dataset)
- URL: [Kaggle](https://www.kaggle.com/drgilermo/nba-players-stats)
- Description: finally, a _proper_ dataset from the Kaggle website, which also includes NBA players stats.
This dataset would be used in case we have any problem with the other two sources (like problems fetching data or with missing values), as data should be the same.
- Data size: the main CSV (`Seasons_stats`) has 24,691 observations and 53 features.
- Questions to answer: 1, 2, 3