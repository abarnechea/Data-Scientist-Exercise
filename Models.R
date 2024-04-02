library(tidyverse)
library(arrow)
library(data.table)
library(rstanarm)

path <- 
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

# Load survey data
survey_data <- 
  data.table(read_parquet(paste0(path,"survey_data_clean.parquet")))

# Run models
turnout_model <-
  stan_glmer(
    turnout ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
    data = survey_data, family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    chain = 4,
    iter = 2000,
    cores = 4,
    adapt_delta = 0.95,
    seed = 688
  )
saveRDS(turnout_model, paste0(path, "turnout_model.rds"))

conservative_model <-
  stan_glmer(
    conservative ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
    data = survey_data, family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    chain = 4,
    iter = 2000,
    cores = 4,
    adapt_delta = 0.95,
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
     adapt_delta = 0.95,
     seed = 688
   ) 
 saveRDS(labour_model, paste0(path, "labour_model.rds"))
 
 liberal_dem_model <-
   stan_glmer(
     liberal_dem ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 |educ_level),
     data = survey_data, family = binomial(link = "logit"),
     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
     chain = 4,
     iter = 2000,
     cores = 4,
     adapt_delta = 0.95,
     seed = 688
   )
 saveRDS(liberal_dem_model, paste0(path, "liberal_dem_model.rds"))
 
other_model <-
   stan_glmer(
     other ~ female + (1 | region) + (1 | const_c) + (1 | age_bracket) + (1 | educ_level),
     data = survey_data, family = binomial(link = "logit"),
     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
     chain = 4,
     iter = 2000,
     cores = 4,
     adapt_delta = 0.95,
     seed = 688
   )
 saveRDS(other_model, paste0(path, "other_model.rds"))
 