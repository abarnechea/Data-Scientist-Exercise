library(tidyverse)
library(haven)
library(arrow)

path <-
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

# Load census data
census_data <- read_csv(paste0(path, "CensusData2021.csv"))

# Drop observations from first two age categories (too young to vote)
census_data <- census_data %>% filter(`Age (12 categories) Code` > 2)

# Rename columns
census_data <-
  rename(census_data,
    const_c = `Westminster Parliamentary constituencies Code`,
    const_n = `Westminster Parliamentary constituencies`,
    educ_level = `Highest level of qualification (8 categories) Code`,
    female = `Sex (2 categories) Code`,
    age_bracket = `Age (12 categories) Code`,
    count = `Observation`
  )

# Recode age bracket labels to 1-10
census_data$age_bracket <- census_data$age_bracket - 2

# Recode female to 0s and 1s
census_data$female <- ifelse(census_data$female == 2, 0, census_data$female)

# Group non_classified in educ level 7
census_data$educ_level <-
  ifelse(census_data$educ_level == -8, 7, census_data$educ_level)

# Change column class to factor
census_data <-
  census_data %>%
  mutate_at(vars(const_c, const_n, age_bracket, educ_level), as.factor)

# Drop unused columns
census_data <-
  census_data %>%
  select(1, 3, 5, 7, 9)

# Add region
election_results <- read_sav(paste0(path, "Results2019.sav"))
election_results_e_w <-
  election_results %>%
  filter(Country == 1 | Country == 3)
election_results_e_w <-
  election_results_e_w %>%
  select(2, 5)
election_results_e_w <-
  election_results_e_w %>%
  rename(const_c = ONSConstID, region = Region)

census_data <- census_data %>% left_join(election_results_e_w, by = "const_c")
census_data$region <- as.factor(census_data$region)

# write parquet
# write_parquet(census_data, paste0(path, "census_data_clean.parquet"))
