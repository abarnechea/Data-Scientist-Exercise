library(tidyverse)
library(arrow)
library(data.table)
library(rstanarm)
library(tidybayes)

path <-
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

# Load census data clean
census_data <-
  data.table(read_parquet(paste0(path, "census_data_clean.parquet")))

# Evenly split into 4
census_datas <- split(census_data, 1:4)

census_data_1 <- census_datas[[1]]
census_data_2 <- census_datas[[2]]
census_data_3 <- census_datas[[3]]
census_data_4 <- census_datas[[4]]

# Load models
turnout_model <- readRDS(paste0(path, "turnout_model.rds"))
conservative_model <- readRDS(paste0(path, "conservative_model.rds"))
labour_model <- readRDS(paste0(path, "labour_model.rds"))
liberal_dem_model <- readRDS(paste0(path, "liberal_dem_model.rds"))
other_model <- readRDS(paste0(path, "other_model.rds"))

# Add turnout predictions
census_data_1 <-
  turnout_model %>%
  add_epred_draws(newdata = census_data_1, value = "turnout") %>%
  ungroup() %>%
  summarise(
    turnout = mean(turnout),
    .by = c(const_c, region, age_bracket, educ_level, female, count)
  )

census_data_2 <-
  turnout_model %>%
  add_epred_draws(newdata = census_data_2, value = "turnout") %>%
  ungroup() %>%
  summarise(
    turnout = mean(turnout),
    .by = c(const_c, region, age_bracket, educ_level, female, count)
  )

census_data_3 <-
  turnout_model %>%
  add_epred_draws(newdata = census_data_3, value = "turnout") %>%
  ungroup() %>%
  summarise(
    turnout = mean(turnout),
    .by = c(const_c, region, age_bracket, educ_level, female, count)
  )

census_data_4 <-
  turnout_model %>%
  add_epred_draws(newdata = census_data_4, value = "turnout") %>%
  ungroup() %>%
  summarise(
    turnout = mean(turnout),
    .by = c(const_c, region, age_bracket, educ_level, female, count)
  )

# Add conservative predictions
census_data_1 <-
  conservative_model %>%
  add_epred_draws(newdata = census_data_1, value = "conservative") %>%
  ungroup() %>%
  summarise(
    conservative = mean(conservative),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout
    )
  )

census_data_2 <-
  conservative_model %>%
  add_epred_draws(newdata = census_data_2, value = "conservative") %>%
  ungroup() %>%
  summarise(
    conservative = mean(conservative),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout
    )
  )

census_data_3 <-
  conservative_model %>%
  add_epred_draws(newdata = census_data_3, value = "conservative") %>%
  ungroup() %>%
  summarise(
    conservative = mean(conservative),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout
    )
  )

census_data_4 <-
  conservative_model %>%
  add_epred_draws(newdata = census_data_4, value = "conservative") %>%
  ungroup() %>%
  summarise(
    conservative = mean(conservative),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout
    )
  )

 # Add labour predictions
census_data_1 <-
  labour_model %>%
  add_epred_draws(newdata = census_data_1, value = "labour") %>%
  ungroup() %>%
  summarise(
    labour = mean(labour),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative
    )
  )

census_data_2 <-
  labour_model %>%
  add_epred_draws(newdata = census_data_2, value = "labour") %>%
  ungroup() %>%
  summarise(
    labour = mean(labour),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative
    )
  )

census_data_3 <-
  labour_model %>%
  add_epred_draws(newdata = census_data_3, value = "labour") %>%
  ungroup() %>%
  summarise(
    labour = mean(labour),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative
    )
  )

census_data_4 <-
  labour_model %>%
  add_epred_draws(newdata = census_data_4, value = "labour") %>%
  ungroup() %>%
  summarise(
    labour = mean(labour),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative
    )
  )

# Add ld predictions
census_data_1 <-
  liberal_dem_model %>%
  add_epred_draws(newdata = census_data_1, value = "liberal_dem") %>%
  ungroup() %>%
  summarise(
    liberal_dem = mean(liberal_dem),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour
    )
  )

census_data_2 <-
  liberal_dem_model %>%
  add_epred_draws(newdata = census_data_2, value = "liberal_dem") %>%
  ungroup() %>%
  summarise(
    liberal_dem = mean(liberal_dem),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour
    )
  )

census_data_3 <-
  liberal_dem_model %>%
  add_epred_draws(newdata = census_data_3, value = "liberal_dem") %>%
  ungroup() %>%
  summarise(
    liberal_dem = mean(liberal_dem),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour
    )
  )

census_data_4 <-
  liberal_dem_model %>%
  add_epred_draws(newdata = census_data_4, value = "liberal_dem") %>%
  ungroup() %>%
  summarise(
    liberal_dem = mean(liberal_dem),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour
    )
  )

# Add other predictions
census_data_1 <-
  other_model %>%
  add_epred_draws(newdata = census_data_1, value = "other") %>%
  ungroup() %>%
  summarise(
    other = mean(other),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour, liberal_dem
    )
  )

census_data_2 <-
  other_model %>%
  add_epred_draws(newdata = census_data_2, value = "other") %>%
  ungroup() %>%
  summarise(
    other = mean(other),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour, liberal_dem
    )
  )

census_data_3 <-
  other_model %>%
  add_epred_draws(newdata = census_data_3, value = "other") %>%
  ungroup() %>%
  summarise(
    other = mean(other),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour, liberal_dem
    )
  )

census_data_4 <-
  other_model %>%
  add_epred_draws(newdata = census_data_4, value = "other") %>%
  ungroup() %>%
  summarise(
    other = mean(other),
    .by = c(
      const_c, region, age_bracket,
      educ_level, female, count, turnout, conservative, labour, liberal_dem
    )
  )

# Bind rows to make data whole
census_data <- rbind(census_data_1, census_data_2, census_data_3, census_data_4)

# write csv
# write_csv(census_data, paste0(path,"census_data_predictions.csv"))
