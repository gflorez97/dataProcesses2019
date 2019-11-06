# dataProcesses2019

# Students
- Gonzalo Flórez Arias
- Antonio González Sanz
- Esaú García Sánchez-Torija
-

# Domain of interest
The selected domain of interest for this project is basketball, and in particular, professional basketball in the United States (the NBA).
It is an interesting domain, as more and more data is available daily as games are played, and being able to analyze all that data properly is starting to become a priority for professional teams.
Also, it's a sport we know about and like, and thus we can compare the results of our analysis to our previous knowledge.

## Previous works
- https://www.cse.unr.edu/~sushil/class/ml/papers/local/nba.pdf: a relatively old (1996) paper describing how Data Mining and Knowledge Discovery can be applied to NBA data.
- http://www.sloansportsconference.com/wp-content/uploads/2012/02/Goldsberry_Sloan_Submission.pdf: this paper includes a case study in which the author studies who the best shooter in the NBA is using game data from 2006 to 2011.
- https://www.degruyter.com/downloadpdf/j/hukin.2013.37.issue-1/hukin-2013-0035/hukin-2013-0035.pdf: this paper describes a method for ranking NBA teams based on a number of factors.

## Data-driven questions
<ol>
	<li>Who is the most consistent three-point shooter in NBA history?</li>
	<li>TODO</li>
	<li>TODO</li>
</ol>

# Finding Data
## NBA Stats API
- URL: [stats.nba.com](https://stats.nba.com)
- Description: this API includes data from mostly every game played in NBA history.
We will be using the `nbastatR` package to access this API and get all the needed information for teams and players.
- Data size: immeasurable (multiple endpoints, with multiple types of queries).
- Questions to answer: 1

## Basketball reference
- URL: [www.basketball-reference.com](https://www.basketball-reference.com)
- Description: this website also includes data from mostly every game played in NBA history.
We will be using the `nbastatR` package to wrap the data from this website and get all the needed information for teams and players, specially the information not available from the NBA Stats API directly (missing values, advanced statistics only available in this web...).
- Data size: immeasurable (multiple endpoints, with multiple types of queries).
- Questions to answer: 1

## NBA Players stats since 1950 (Kaggle dataset)
- URL: [www.kaggle.com/drgilermo/nba-players-stats](https://www.kaggle.com/drgilermo/nba-players-stats)
- Description: finally, a _proper_ dataset from the Kaggle website, which also includes NBA players stats.
This dataset would be used in case we have any problem with the other two sources (like problems fetching data or with missing values), as data should be the same.
- Data size: the main CSV (`Seasons_stats`) has 24,691 observations and 53 features.
- Questions to answer: 1
