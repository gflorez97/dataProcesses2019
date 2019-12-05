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
  
...

- Cites 5 _relevant_ pieces of relevant work (whatever format you choose is fine, including just a hyperlink) (**1 point each**)
## Previous works: 
- [Bhandari, Colet, Parker, Pines, Pratap, Ramanujam (1997). Advanced Scout: Data Mining and Knowledge Discovery in NBA Data. Data Mining and Knowledge Discovery, 1, pp.121–125.](https://www.cse.unr.edu/~sushil/class/ml/papers/local/nba.pdf)
- [Goldsberry (2012). CourtVision: New Visual and Spatial Analytics for the NBA. MIT Sloan Sports Analytics Conference](http://www.sloansportsconference.com/wp-content/uploads/2012/02/Goldsberry_Sloan_Submission.pdf)
- [Mikołajec Maszczyk, Zając (2013). Game Indicators Determining Sports Performance in the NBA. Journal of Human Kinetics, 37, 145-151](https://www.degruyter.com/downloadpdf/j/hukin.2013.37.issue-1/hukin-2013-0035/hukin-2013-0035.pdf)
- ...
- ...


# Exploratory Data Analysis
- Introduces the dataset by describing the origin (source) and structure (shape, relevant features) of the data being used (**5 points**)

...


- Creates 5 well designed and formatted graphics (**15 points**, 3 each)
  - The visual uses the appropriate visual encodings based on the data type (**1 point**)
  - Written interpretation of graphic is provided (**1 point**)
  - Clear axis labels, titles, and legends are included, where appropriate (**1 point**)

...


  
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

...

# Results
You must provide a clear interpretation of your statistical and machine learning results, including at least **one visual or table** for each.
- **Strengths of relationships**: For the features you included in your model, you must describe the strength (significance) and magnitude of the relationships. This can be presented in a table or chart, and pertinent observations should be described in the text. (**10 points**)
- **Predictions**: How well were you able to predict values in the dataset? You should both report appropriate metrics based on the type of outcome you're predicting (e.g., root mean squared error v.s. accuracy), as well as a high quality visual showing the strength of your model (**10 points**)

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