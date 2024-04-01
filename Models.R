library(tidyverse)
library(arrow)
library(data.table)
library(rstanarm)

path <- 
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

survey_data <- 
  data.table(read_parquet(paste0(path,"survey_data_clean.parquet")))

turnout_model <-
  stan_glmer(
    turnout ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
    data = survey_data, family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    chain = 4,
    iter = 2000,
    cores = 4,
    adapt_delta = 0.99,
    seed = 688
  )
saveRDS(turnout_model, paste0(path, "turnout_model.rds"))

conservative_model <-
  stan_glmer(
    conservative ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level) ,
    data = survey_data, family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    chain = 4,
    iter = 2000,
    cores = 4,
    adapt_delta = 0.99,
    seed = 688
  )
saveRDS(conservative_model, paste0(path, "conservative_model.rds"))
 
 
 labour_model <-
   stan_glmer(
     labour ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
     data = survey_data, family = binomial(link = "logit"),
     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
     chain = 4,
     iter = 2000,
     cores = 4,
     adapt_delta = 0.99,
     seed = 688
   ) 
 saveRDS(labour_model, paste0(path, "labour_model.rds"))
 
 liberal_dem <-
   stan_glmer(
     liberal_dem ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
     data = survey_data, family = binomial(link = "logit"),
     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
     chain = 4,
     iter = 2000,
     cores = 4,
     adapt_delta = 0.99,
     seed = 688
   )
 saveRDS(liberal_dem, paste0(path, "liberal_dem_model.rds"))