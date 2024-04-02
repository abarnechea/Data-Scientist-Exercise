# Data Scientist Exercise

## Description
I was tasked with estimating UK 2019 General Election results for England and Wales using a simple Multilevel Regression and Poststratification (MRP) model.

### Data
For my poststratification I used population counts for interlocked demographic groups, downloaded from the ONS's "Create  a custom dataset" page. The demographic characteristics included were age (12 categories), highest level of qualification (8 categories) and sex.

To develop a set of models to estimate differential turnout rates and the percentage of people voting for the Conservatives, Labor, Liberal Democrats, or Other parties, I used cross-sectional data from the 2019 BES Post-Election Random Probability Survey.

Finally, the true election results were extracted from the 2010-2019 BES Constituency Results with Census and Candidate Data.

### Model
I used a logistic regression model to estimate 5 outcomes (turnout, conservative, labour, liberal democrat, and other). The varialbes in included in this model were female (a dummy for whether the individual is as male or female), region (included because the survey data did not contain estimates for all constituencies) constituency, age bracket (with 10 age levels), and educational level (with 8 levels). Addtionally, I used random intercepts for all factor predictors to account for variation between groups given the heirarchical nature of my dataset. 

## Results
